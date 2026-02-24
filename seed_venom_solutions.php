<?php

declare(strict_types=1);

use Illuminate\Database\Capsule\Manager as Capsule;

require __DIR__ . '/init.php';

date_default_timezone_set('UTC');

$report = [
    'backup' => null,
    'configChanges' => [],
    'languageFiles' => [],
    'productGroupId' => null,
    'products' => [],
    'addon' => null,
    'departments' => [],
    'emailTemplate' => null,
    'currencyValidation' => [],
    'gateway' => [],
    'customFields' => [],
    'validation' => [],
    'manualSteps' => [],
    'logs' => [],
];

$adminUsername = Capsule::table('tbladmins')
    ->where('disabled', 0)
    ->orderBy('id', 'asc')
    ->value('username');

if (!$adminUsername) {
    throw new RuntimeException('No active admin user found for localAPI execution.');
}

function logAction(array &$report, string $message): void
{
    $line = '[' . date('Y-m-d H:i:s') . '] ' . $message;
    $report['logs'][] = $line;
    print $line . PHP_EOL;
}

function callLocalApi(string $command, array $values, string $adminUsername, array &$report): array
{
    $response = localAPI($command, $values, $adminUsername);
    logAction($report, sprintf('localAPI %s => %s', $command, json_encode($response)));
    return $response;
}

function upsertPricing(string $type, int $currencyId, int $relid, array $prices): void
{
    $defaults = [
        'msetupfee' => '0.00',
        'qsetupfee' => '0.00',
        'ssetupfee' => '0.00',
        'asetupfee' => '0.00',
        'bsetupfee' => '0.00',
        'tsetupfee' => '0.00',
        'monthly' => '-1.00',
        'quarterly' => '-1.00',
        'semiannually' => '-1.00',
        'annually' => '-1.00',
        'biennially' => '-1.00',
        'triennially' => '-1.00',
    ];

    $payload = array_merge($defaults, $prices);

    $existingId = Capsule::table('tblpricing')
        ->where('type', $type)
        ->where('currency', $currencyId)
        ->where('relid', $relid)
        ->value('id');

    if ($existingId) {
        Capsule::table('tblpricing')->where('id', $existingId)->update($payload);
    } else {
        Capsule::table('tblpricing')->insert(array_merge([
            'type' => $type,
            'currency' => $currencyId,
            'relid' => $relid,
        ], $payload));
    }
}

function upsertGatewaySetting(string $gateway, string $setting, string $value): void
{
    $row = Capsule::table('tblpaymentgateways')
        ->where('gateway', $gateway)
        ->where('setting', $setting)
        ->first();

    if ($row) {
        Capsule::table('tblpaymentgateways')
            ->where('id', $row->id)
            ->update(['value' => $value]);
        return;
    }

    Capsule::table('tblpaymentgateways')->insert([
        'gateway' => $gateway,
        'setting' => $setting,
        'value' => $value,
        'order' => 0,
    ]);
}

function createPrewriteBackup(string $rootPath, array &$report): string
{
    $dbConfig = [];

    (static function (string $configFile, array &$dbConfig): void {
        require $configFile;
        $dbConfig = [
            'host' => isset($db_host) ? (string) $db_host : '127.0.0.1',
            'port' => isset($db_port) ? (string) $db_port : '3306',
            'username' => isset($db_username) ? (string) $db_username : '',
            'password' => isset($db_password) ? (string) $db_password : '',
            'database' => isset($db_name) ? (string) $db_name : '',
        ];
    })($rootPath . '/configuration.php', $dbConfig);

    if (!$dbConfig['username'] || !$dbConfig['database']) {
        throw new RuntimeException('Database credentials are missing in configuration.php');
    }

    $backupDir = $rootPath . '/backups';
    if (!is_dir($backupDir) && !mkdir($backupDir, 0775, true) && !is_dir($backupDir)) {
        throw new RuntimeException('Unable to create backups directory: ' . $backupDir);
    }

    $backupFile = $backupDir . '/whmcs_seed_prewrite_' . date('Ymd_His') . '.sql';
    $command = sprintf(
        'mysqldump --host=%s --port=%s --user=%s --password=%s %s > %s 2>&1',
        escapeshellarg($dbConfig['host']),
        escapeshellarg($dbConfig['port']),
        escapeshellarg($dbConfig['username']),
        escapeshellarg($dbConfig['password']),
        escapeshellarg($dbConfig['database']),
        escapeshellarg($backupFile)
    );

    exec($command, $output, $exitCode);
    if ($exitCode !== 0 || !is_file($backupFile) || filesize($backupFile) === 0) {
        throw new RuntimeException('Backup failed: ' . implode("\n", $output));
    }

    logAction($report, 'Created backup file: ' . $backupFile);
    return $backupFile;
}

logAction($report, 'Starting Venom Solutions WHMCS seed/config run.');

$report['backup'] = createPrewriteBackup(__DIR__, $report);

$configTargets = [
    'Language' => 'english',
    'AllowLanguageChange' => '1',
    'Template' => 'venom-solutions',
    'OrderFormTemplate' => 'venom_cart',
    'domainLookupProvider' => 'WhmcsWhois',
];

foreach ($configTargets as $key => $newValue) {
    $oldValue = (string) Capsule::table('tblconfiguration')->where('setting', $key)->value('value');
    if ($oldValue !== $newValue) {
        callLocalApi('SetConfigurationValue', ['setting' => $key, 'value' => $newValue], $adminUsername, $report);
    }
    $currentValue = (string) Capsule::table('tblconfiguration')->where('setting', $key)->value('value');
    $report['configChanges'][$key] = ['old' => $oldValue, 'new' => $currentValue];
    logAction($report, sprintf('Config %s: %s -> %s', $key, $oldValue, $currentValue));
}

$languageFiles = [
    __DIR__ . '/lang/arabic.php',
    __DIR__ . '/admin/lang/arabic.php',
];

foreach ($languageFiles as $languageFile) {
    if (is_file($languageFile)) {
        $disabledPath = $languageFile . '.disabled-by-venom';
        if (!is_file($disabledPath)) {
            rename($languageFile, $disabledPath);
            $report['languageFiles'][] = ['action' => 'disabled', 'path' => $disabledPath];
            logAction($report, 'Disabled language file: ' . $disabledPath);
        } else {
            unlink($languageFile);
            $report['languageFiles'][] = ['action' => 'removed-duplicate', 'path' => $languageFile];
            logAction($report, 'Removed duplicate Arabic file at: ' . $languageFile);
        }
    }
}

$currencyRows = Capsule::table('tblcurrencies')->orderBy('id', 'asc')->get(['id', 'code', 'prefix', 'suffix', 'default', 'rate']);
$usdCurrency = Capsule::table('tblcurrencies')->where('code', 'USD')->first();
if (!$usdCurrency) {
    throw new RuntimeException('USD currency row not found.');
}

foreach ($currencyRows as $currencyRow) {
    if ((int) $currencyRow->id !== (int) $usdCurrency->id) {
        Capsule::table('tblcurrencies')->where('id', $currencyRow->id)->delete();
        logAction($report, 'Deleted non-USD currency ID ' . $currencyRow->id . ' (' . $currencyRow->code . ')');
    }
}

Capsule::table('tblcurrencies')->where('id', $usdCurrency->id)->update(['default' => 1]);
$report['currencyValidation'] = [
    'usdCurrencyId' => (int) $usdCurrency->id,
    'rows' => Capsule::table('tblcurrencies')->orderBy('id', 'asc')->get(['id', 'code', 'prefix', 'suffix', 'default', 'rate']),
];

$groupName = 'Venom Solutions Plans';
$groupSlug = 'venom-solutions-plans';
$groupId = (int) (Capsule::table('tblproductgroups')->where('name', $groupName)->value('id') ?: 0);

if (!$groupId) {
    $groupId = (int) Capsule::table('tblproductgroups')->insertGetId([
        'name' => $groupName,
        'slug' => $groupSlug,
        'headline' => 'Venom Solutions Service Plans',
        'tagline' => 'Premium infrastructure plans for professional providers.',
        'orderfrmtpl' => 'venom_cart',
        'disabledgateways' => '',
        'hidden' => 0,
        'order' => 0,
        'icon' => '',
        'created_at' => date('Y-m-d H:i:s'),
        'updated_at' => date('Y-m-d H:i:s'),
    ]);
    logAction($report, 'Created product group ' . $groupName . ' (ID ' . $groupId . ')');
} else {
    Capsule::table('tblproductgroups')->where('id', $groupId)->update([
        'slug' => $groupSlug,
        'headline' => 'Venom Solutions Service Plans',
        'tagline' => 'Premium infrastructure plans for professional providers.',
        'orderfrmtpl' => 'venom_cart',
        'hidden' => 0,
        'updated_at' => date('Y-m-d H:i:s'),
    ]);
    logAction($report, 'Updated existing product group ID ' . $groupId);
}

$report['productGroupId'] = $groupId;

$emailName = 'Venom Solutions Service Welcome Email';
$emailSubject = 'Your Venom Solutions Service Details';
$emailBody = "Hello {\$client_name},\n\nWelcome to Venom Solutions. Your service is now active.\nYou can find all credentials and connection details in the Client Area under Services.\n\nClient Area: {\$whmcs_url}/clientarea.php?action=products\n\nIf you need any assistance, please open a ticket with Technical Support.\n\nRegards,\nVenom Solutions Team";

$emailTemplateId = (int) (Capsule::table('tblemailtemplates')
    ->where('type', 'product')
    ->where('name', $emailName)
    ->value('id') ?: 0);

if (!$emailTemplateId) {
    $emailTemplateId = (int) Capsule::table('tblemailtemplates')->insertGetId([
        'type' => 'product',
        'name' => $emailName,
        'subject' => $emailSubject,
        'message' => $emailBody,
        'attachments' => '',
        'fromname' => '',
        'fromemail' => '',
        'disabled' => 0,
        'custom' => 1,
        'language' => 'english',
        'copyto' => '',
        'blind_copy_to' => '',
        'plaintext' => 1,
        'created_at' => date('Y-m-d H:i:s'),
        'updated_at' => date('Y-m-d H:i:s'),
    ]);
    logAction($report, 'Created product welcome email template ID ' . $emailTemplateId);
} else {
    Capsule::table('tblemailtemplates')->where('id', $emailTemplateId)->update([
        'subject' => $emailSubject,
        'message' => $emailBody,
        'disabled' => 0,
        'custom' => 1,
        'language' => 'english',
        'plaintext' => 1,
        'updated_at' => date('Y-m-d H:i:s'),
    ]);
    logAction($report, 'Updated product welcome email template ID ' . $emailTemplateId);
}

$report['emailTemplate'] = [
    'id' => $emailTemplateId,
    'name' => $emailName,
    'subject' => $emailSubject,
];

$productDefinitions = [
    [
        'name' => 'Trial Plan (7 Days)',
        'description' => "Perfect for testing infrastructure\nIncludes: 1 Server Access, 1 Load Balancer, Standard Support, Basic Analytics\nNo free trial is provided in the system.",
        'paytype' => 'onetime',
        'prices' => [
            'monthly' => '50.00',
        ],
        'apiPricing' => [
            'monthly' => '50.00',
        ],
    ],
    [
        'name' => 'Monthly Access',
        'description' => "For professional providers\nIncludes: Main Server License, 1 Free Load Balancer, Priority Support, Advanced Analytics\nExtra Load Balancers available as an addon ($10 each per month equivalent).",
        'paytype' => 'recurring',
        'prices' => [
            'monthly' => '100.00',
            'quarterly' => '285.00',
            'semiannually' => '540.00',
            'annually' => '960.00',
        ],
        'apiPricing' => [
            'monthly' => '100.00',
            'quarterly' => '285.00',
            'semiannually' => '540.00',
            'annually' => '960.00',
        ],
    ],
];

$productIdsByName = [];

foreach ($productDefinitions as $definition) {
    $productName = $definition['name'];
    $productId = (int) (Capsule::table('tblproducts')->where('name', $productName)->value('id') ?: 0);

    if (!$productId) {
        $addResponse = callLocalApi('AddProduct', [
            'type' => 'other',
            'gid' => $groupId,
            'name' => $productName,
            'description' => $definition['description'],
            'paytype' => $definition['paytype'],
            'hidden' => 0,
            'showdomainoptions' => 0,
            'welcomeemail' => $emailTemplateId,
            'currencyid' => (int) $usdCurrency->id,
            'msetupfee' => '0.00',
            'qsetupfee' => '0.00',
            'ssetupfee' => '0.00',
            'asetupfee' => '0.00',
            'bsetupfee' => '0.00',
            'tsetupfee' => '0.00',
            'monthly' => $definition['apiPricing']['monthly'] ?? '-1.00',
            'quarterly' => $definition['apiPricing']['quarterly'] ?? '-1.00',
            'semiannually' => $definition['apiPricing']['semiannually'] ?? '-1.00',
            'annually' => $definition['apiPricing']['annually'] ?? '-1.00',
            'biennially' => '-1.00',
            'triennially' => '-1.00',
        ], $adminUsername, $report);

        $productId = (int) ($addResponse['pid'] ?? 0);
        if (!$productId) {
            $productId = (int) (Capsule::table('tblproducts')->where('name', $productName)->value('id') ?: 0);
        }
        if (!$productId) {
            throw new RuntimeException('Failed to create product: ' . $productName);
        }
        logAction($report, 'Created product ' . $productName . ' (ID ' . $productId . ')');
    } else {
        logAction($report, 'Product exists; applying idempotent update by model for ' . $productName . ' (ID ' . $productId . ')');
    }

    Capsule::table('tblproducts')->where('id', $productId)->update([
        'gid' => $groupId,
        'type' => 'other',
        'name' => $productName,
        'description' => $definition['description'],
        'hidden' => 0,
        'retired' => 0,
        'showdomainoptions' => 0,
        'welcomeemail' => $emailTemplateId,
        'paytype' => $definition['paytype'],
        'allowqty' => 0,
        'updated_at' => date('Y-m-d H:i:s'),
    ]);

    upsertPricing('product', (int) $usdCurrency->id, $productId, $definition['prices']);

    $pricing = Capsule::table('tblpricing')
        ->where('type', 'product')
        ->where('currency', (int) $usdCurrency->id)
        ->where('relid', $productId)
        ->first();

    $report['products'][$productName] = [
        'id' => $productId,
        'paytype' => $definition['paytype'],
        'monthly' => $pricing->monthly,
        'quarterly' => $pricing->quarterly,
        'semiannually' => $pricing->semiannually,
        'annually' => $pricing->annually,
    ];

    $productIdsByName[$productName] = $productId;
}

$selectedProductIds = array_values($productIdsByName);
sort($selectedProductIds);
Capsule::table('tblproducts')
    ->where('gid', $groupId)
    ->whereNotIn('id', $selectedProductIds)
    ->update(['hidden' => 1, 'retired' => 1, 'updated_at' => date('Y-m-d H:i:s')]);

$addonName = 'Additional Load Balancer';
$addonDescription = 'Add extra load balancers to improve stability under peak load and optimize routing for a smoother experience.';
$addonId = (int) (Capsule::table('tbladdons')->where('name', $addonName)->value('id') ?: 0);
$packageList = implode(',', $selectedProductIds);

if (!$addonId) {
    $addonId = (int) Capsule::table('tbladdons')->insertGetId([
        'packages' => $packageList,
        'name' => $addonName,
        'description' => $addonDescription,
        'billingcycle' => 'recurring',
        'allowqty' => 1,
        'tax' => 0,
        'showorder' => 1,
        'hidden' => 0,
        'retired' => 0,
        'downloads' => '',
        'autoactivate' => '',
        'suspendproduct' => 0,
        'welcomeemail' => 0,
        'type' => '',
        'module' => '',
        'server_group_id' => 0,
        'prorate' => 0,
        'weight' => 0,
        'autolinkby' => '',
        'created_at' => date('Y-m-d H:i:s'),
        'updated_at' => date('Y-m-d H:i:s'),
    ]);
    logAction($report, 'Created addon ' . $addonName . ' (ID ' . $addonId . ')');
} else {
    Capsule::table('tbladdons')->where('id', $addonId)->update([
        'packages' => $packageList,
        'description' => $addonDescription,
        'billingcycle' => 'recurring',
        'allowqty' => 1,
        'showorder' => 1,
        'hidden' => 0,
        'retired' => 0,
        'updated_at' => date('Y-m-d H:i:s'),
    ]);
    logAction($report, 'Updated addon ' . $addonName . ' (ID ' . $addonId . ')');
}

upsertPricing('addon', (int) $usdCurrency->id, $addonId, [
    'monthly' => '10.00',
    'quarterly' => '30.00',
    'semiannually' => '60.00',
    'annually' => '120.00',
]);

$addonPricing = Capsule::table('tblpricing')
    ->where('type', 'addon')
    ->where('currency', (int) $usdCurrency->id)
    ->where('relid', $addonId)
    ->first();

$report['addon'] = [
    'id' => $addonId,
    'name' => $addonName,
    'allowqty' => (int) Capsule::table('tbladdons')->where('id', $addonId)->value('allowqty'),
    'packages' => $packageList,
    'monthly' => $addonPricing->monthly,
    'quarterly' => $addonPricing->quarterly,
    'semiannually' => $addonPricing->semiannually,
    'annually' => $addonPricing->annually,
];

$departmentDefinitions = [
    ['name' => 'Technical Support', 'description' => 'Technical assistance for Venom Solutions services.', 'email' => 'support@venom-solutions.test'],
    ['name' => 'Billing Support', 'description' => 'Billing and payment support for Venom Solutions services.', 'email' => 'billing@venom-solutions.test'],
];

foreach ($departmentDefinitions as $department) {
    $departmentId = (int) (Capsule::table('tblticketdepartments')->where('name', $department['name'])->value('id') ?: 0);
    if (!$departmentId) {
        $nextOrder = (int) Capsule::table('tblticketdepartments')->max('order') + 1;
        $departmentId = (int) Capsule::table('tblticketdepartments')->insertGetId([
            'name' => $department['name'],
            'description' => $department['description'],
            'email' => $department['email'],
            'clientsonly' => '',
            'piperepliesonly' => '',
            'noautoresponder' => '',
            'hidden' => '',
            'order' => $nextOrder,
            'host' => '',
            'port' => '',
            'login' => '',
            'password' => '',
            'mail_auth_config' => '',
            'feedback_request' => 0,
            'prevent_client_closure' => 0,
        ]);
        logAction($report, 'Created department ' . $department['name'] . ' (ID ' . $departmentId . ')');
    } else {
        Capsule::table('tblticketdepartments')->where('id', $departmentId)->update([
            'description' => $department['description'],
            'email' => $department['email'],
            'hidden' => '',
        ]);
        logAction($report, 'Updated department ' . $department['name'] . ' (ID ' . $departmentId . ')');
    }

    $report['departments'][$department['name']] = $departmentId;
}

$customFieldNames = [
    'Server URL',
    'Username',
    'Password',
    'M3U Playlist URL',
    'EPG URL',
];

foreach ($selectedProductIds as $productId) {
    foreach ($customFieldNames as $sortOrder => $fieldName) {
        $customFieldId = (int) (Capsule::table('tblcustomfields')
            ->where('type', 'product')
            ->where('relid', $productId)
            ->where('fieldname', $fieldName)
            ->value('id') ?: 0);

        if (!$customFieldId) {
            $customFieldId = (int) Capsule::table('tblcustomfields')->insertGetId([
                'type' => 'product',
                'relid' => $productId,
                'fieldname' => $fieldName,
                'fieldtype' => 'text',
                'description' => '',
                'fieldoptions' => '',
                'regexpr' => '',
                'adminonly' => '',
                'required' => '',
                'showorder' => '',
                'showinvoice' => '',
                'sortorder' => $sortOrder + 1,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
            ]);
            logAction($report, 'Created custom field ' . $fieldName . ' for product ID ' . $productId);
        } else {
            Capsule::table('tblcustomfields')->where('id', $customFieldId)->update([
                'fieldtype' => 'text',
                'adminonly' => '',
                'required' => '',
                'showorder' => '',
                'showinvoice' => '',
                'sortorder' => $sortOrder + 1,
                'updated_at' => date('Y-m-d H:i:s'),
            ]);
        }

        $report['customFields'][] = [
            'productId' => $productId,
            'fieldId' => $customFieldId,
            'fieldName' => $fieldName,
        ];
    }
}

$gatewayFiles = glob(__DIR__ . '/modules/gateways/*.php') ?: [];
$gatewayModules = [];
foreach ($gatewayFiles as $gatewayFile) {
    $module = basename($gatewayFile, '.php');
    if ($module === 'index') {
        continue;
    }
    $gatewayModules[] = $module;
}

$preferredGateways = ['banktransfer', 'mailin', 'offlinecc', 'directdebit'];
$selectedGateway = null;
foreach ($preferredGateways as $preferredGateway) {
    if (in_array($preferredGateway, $gatewayModules, true)) {
        $selectedGateway = $preferredGateway;
        break;
    }
}

if (!$selectedGateway && !empty($gatewayModules)) {
    $selectedGateway = $gatewayModules[0];
}

if (!$selectedGateway) {
    throw new RuntimeException('No gateway modules found in modules/gateways/.');
}

$isGatewayActive = Capsule::table('tblpaymentgateways')
    ->where('gateway', $selectedGateway)
    ->where('setting', 'type')
    ->exists();

if (!$isGatewayActive) {
    callLocalApi('ActivateModule', [
        'moduleType' => 'gateway',
        'moduleName' => $selectedGateway,
    ], $adminUsername, $report);
}

upsertGatewaySetting($selectedGateway, 'instructions', 'After placing your order, contact billing to complete payment.');

$activeGateways = Capsule::table('tblpaymentgateways')
    ->where('setting', 'type')
    ->pluck('gateway')
    ->toArray();

$report['gateway'] = [
    'selectedModule' => $selectedGateway,
    'activeGateways' => array_values(array_unique($activeGateways)),
];

if (empty($report['gateway']['activeGateways'])) {
    throw new RuntimeException('Gateway activation failed; no active gateways found.');
}

$homepagePath = __DIR__ . '/templates/venom-solutions/homepage.tpl';
if (is_file($homepagePath)) {
    $homepage = file_get_contents($homepagePath);
    if ($homepage !== false) {
        $trialPid = $productIdsByName['Trial Plan (7 Days)'];
        $monthlyPid = $productIdsByName['Monthly Access'];
        $homepage = preg_replace('/cart\.php\?a=add&pid=\d+" class="btn-venom-outline" style="width: 100%; text-align: center;">Start Trial</', 'cart.php?a=add&pid=' . $trialPid . '" class="btn-venom-outline" style="width: 100%; text-align: center;">Start Trial<', $homepage);
        $homepage = preg_replace('/cart\.php\?a=add&pid=\d+" class="btn-glow" style="width: 100%; text-align: center;">Get Started</', 'cart.php?a=add&pid=' . $monthlyPid . '" class="btn-glow" style="width: 100%; text-align: center;">Get Started<', $homepage);
        file_put_contents($homepagePath, $homepage);
        logAction($report, 'Updated homepage product links with product IDs.');
    }
}

$allowLanguageChange = (string) Capsule::table('tblconfiguration')->where('setting', 'AllowLanguageChange')->value('value');
$language = (string) Capsule::table('tblconfiguration')->where('setting', 'Language')->value('value');
$arabicExists = is_file(__DIR__ . '/lang/arabic.php') || is_file(__DIR__ . '/admin/lang/arabic.php');

$productCountInGroup = (int) Capsule::table('tblproducts')
    ->where('gid', $groupId)
    ->whereIn('name', ['Trial Plan (7 Days)', 'Monthly Access'])
    ->count();

$additionalProductsInGroup = (int) Capsule::table('tblproducts')
    ->where('gid', $groupId)
    ->whereNotIn('name', ['Trial Plan (7 Days)', 'Monthly Access'])
    ->where('retired', 0)
    ->where('hidden', 0)
    ->count();

$report['validation'] = [
    'allowLanguageChangeOff' => in_array(strtolower($allowLanguageChange), ['0', 'off', 'false'], true),
    'allowLanguageChangeOn' => in_array(strtolower($allowLanguageChange), ['1', 'on', 'true'], true),
    'defaultLanguageEnglish' => strtolower($language) === 'english',
    'arabicRemoved' => !$arabicExists,
    'usdOnly' => Capsule::table('tblcurrencies')->count() === 1
        && Capsule::table('tblcurrencies')->where('code', 'USD')->where('default', 1)->exists(),
    'gatewayEnabled' => !empty($report['gateway']['activeGateways']),
    'productGroupHasTwoExpectedProducts' => $productCountInGroup === 2 && $additionalProductsInGroup === 0,
    'addonQuantityEnabled' => (int) Capsule::table('tbladdons')->where('id', $addonId)->value('allowqty') === 1,
    'addonAttachedToBothProducts' => $packageList === implode(',', $selectedProductIds),
    'templatePricingTogglePresent' => strpos((string) file_get_contents($homepagePath), 'pricing-cycle-toggle') !== false,
];

print PHP_EOL;
print '==== VENOM SOLUTIONS WHMCS FINAL REPORT ====' . PHP_EOL;
print json_encode($report, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES) . PHP_EOL;

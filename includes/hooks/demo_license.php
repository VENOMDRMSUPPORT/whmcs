<?php
/**
 * Demo License Hooks
 * File: includes/hooks/demo_license.php
 *
 * (1) AfterModuleCreate  – sets nextduedate = regdate + 7 days for pid=3
 * (2) DailyCronJob       – suspends/terminates expired demo services
 */

if (!defined('WHMCS')) {
    die('This file cannot be accessed directly');
}

// ─────────────────────────────────────────────────────────────
// HOOK 1: On service activation – lock nextduedate to +7 days
// ─────────────────────────────────────────────────────────────
add_hook('AfterModuleCreate', 1, function ($vars) {
    $serviceId = (int) ($vars['params']['serviceid'] ?? 0);
    if (!$serviceId) {
        return;
    }

    // Fetch the service record
    $service = Capsule::table('tblhosting')->where('id', $serviceId)->first();
    if (!$service) {
        return;
    }

    // Only apply to 7-Day Demo License (pid = 3)
    if ((int) $service->packageid !== 3) {
        return;
    }

    $regDate    = $service->regdate ?: date('Y-m-d');
    $expireDate = date('Y-m-d', strtotime($regDate . ' +7 days'));

    Capsule::table('tblhosting')
        ->where('id', $serviceId)
        ->update([
            'nextduedate'     => $expireDate,
            'nextinvoicedate' => $expireDate,
            'billingcycle'    => 'Free Account', // prevents WHMCS from auto-invoicing
            'updated_at'      => date('Y-m-d H:i:s'),
        ]);

    logActivity("Demo License Hook: Service #$serviceId — nextduedate set to $expireDate (7-day trial)");
});

// ─────────────────────────────────────────────────────────────
// HOOK 2: DailyCronJob – expire overdue demo services
// ─────────────────────────────────────────────────────────────
add_hook('DailyCronJob', 1, function ($vars) {
    $today = date('Y-m-d');

    // Find all Active demo services that are past their due date
    $expired = Capsule::table('tblhosting')
        ->where('packageid', 3)
        ->where('domainstatus', 'Active')
        ->where('nextduedate', '<', $today)
        ->get();

    if ($expired->isEmpty()) {
        return;
    }

    foreach ($expired as $service) {
        $serviceId = (int) $service->id;
        $userId    = (int) $service->userid;

        try {
            // Use WHMCS API to suspend the service
            $results = localAPI('ModuleSuspend', [
                'serviceid' => $serviceId,
                'suspendreason' => '7-Day Demo License expired. Please upgrade to the Main Server License.',
            ]);

            if ($results['result'] === 'success') {
                logActivity("Demo License Expired: Service #$serviceId (User #$userId) suspended — trial ended on {$service->nextduedate}");

                // Send notification email using WHMCS SendEmail API
                localAPI('SendEmail', [
                    'messagename' => 'Service Suspension',
                    'id'          => $serviceId,
                ]);
            } else {
                // Fallback: direct DB suspend if module suspend fails
                Capsule::table('tblhosting')
                    ->where('id', $serviceId)
                    ->update([
                        'domainstatus'  => 'Suspended',
                        'suspendreason' => '7-Day Demo License expired.',
                        'updated_at'    => date('Y-m-d H:i:s'),
                    ]);

                logActivity("Demo License Expired (DB fallback): Service #$serviceId suspended on $today");
            }
        } catch (\Exception $e) {
            logActivity("Demo License Hook ERROR: Service #$serviceId — " . $e->getMessage());
        }
    }
});

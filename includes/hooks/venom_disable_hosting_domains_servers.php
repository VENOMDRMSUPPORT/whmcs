<?php

declare(strict_types=1);

if (!defined('WHMCS')) {
    exit('This file cannot be accessed directly');
}

/**
 * Venom Solutions platform guard:
 * - disable domain ordering/management routes in client area
 * - remove server status/network issue links
 * - hide domain menu entries from nav
 */

use WHMCS\View\Menu\Item as MenuItem;

add_hook('ClientAreaPage', 1, static function (array $vars): array {
    $route = (string) ($vars['routePath'] ?? '');
    $filename = (string) ($vars['filename'] ?? '');

    $blockedRoutePrefixes = [
        '/domain',
        '/domains',
        '/domainchecker',
        '/cart/domain',
        '/store/weebly/buy/domain',
        '/store/sitebuilder/buy/domain',
    ];

    $blockedFiles = [
        'domainchecker',
        'serverstatus',
        'networkissues',
    ];

    foreach ($blockedRoutePrefixes as $prefix) {
        if ($route !== '' && strpos($route, $prefix) === 0) {
            header('Location: clientarea.php');
            exit;
        }
    }

    if (in_array($filename, $blockedFiles, true)) {
        header('Location: clientarea.php');
        exit;
    }

    // Block legacy cart domain actions: cart.php?a=add&domain=register|transfer
    $domainAction = (string) ($_GET['domain'] ?? '');
    if ($filename === 'cart' && in_array($domainAction, ['register', 'transfer'], true)) {
        header('Location: clientarea.php');
        exit;
    }

    return [
        'openNetworkIssueCounts' => [
            'open' => 0,
            'scheduled' => 0,
        ],
        // Force-disable domain register / transfer widgets in all templates
        'registerdomainenabled' => false,
        'transferdomainenabled' => false,
    ];
});

add_hook('ClientAreaPrimaryNavbar', 1, static function (MenuItem $primaryNavbar): void {
    $toRemove = [
        'Domains',
        'Domain Checker',
        'Register a New Domain',
        'Transfer Domains to Us',
        'Domain Renewals',
        'Network Status',
    ];

    foreach ($toRemove as $name) {
        $child = $primaryNavbar->getChild($name);
        if ($child) {
            $primaryNavbar->removeChild($name);
        }
    }

    // Network Status is under Support dropdown in WHMCS - remove from there
    $support = $primaryNavbar->getChild('Support');
    if ($support && $support->getChild('Network Status')) {
        $support->removeChild('Network Status');
    }

    $services = $primaryNavbar->getChild('Services');
    if ($services) {
        foreach (['My Domains', 'Register a New Domain', 'Domain Renewals'] as $name) {
            if ($services->getChild($name)) {
                $services->removeChild($name);
            }
        }
    }
});

add_hook('ClientAreaPrimarySidebar', 1, static function (MenuItem $sidebar): void {
    $domainShortcutNames = [
        'Register a New Domain',
        'Transfer in a Domain',
        'Domain Checker',
        'Domain Renewals',
        'My Domains',
    ];

    $toRemoveFromAllPanels = array_merge($domainShortcutNames, ['Network Status']);

    // Strip domain entries and Network Status from every sidebar panel (Shortcuts, Support, etc.)
    foreach ($sidebar->getChildren() as $panel) {
        foreach ($toRemoveFromAllPanels as $name) {
            if ($panel->getChild($name)) {
                $panel->removeChild($name);
            }
        }
        // Fallback: remove by label match (handles translated names)
        $toRemoveByLabel = [];
        foreach ($panel->getChildren() as $child) {
            $label = (string) $child->getLabel();
            if ((stripos($label, 'register') !== false && stripos($label, 'domain') !== false)
                || (stripos($label, 'network') !== false && stripos($label, 'status') !== false)) {
                $toRemoveByLabel[] = $child->getName();
            }
        }
        foreach ($toRemoveByLabel as $name) {
            if ($panel->getChild($name)) {
                $panel->removeChild($name);
            }
        }
    }

    // Also remove the entire Domains panel if it exists
    if ($sidebar->getChild('Domains')) {
        $sidebar->removeChild('Domains');
    }
});

add_hook('ClientAreaSecondarySidebar', 1, static function (MenuItem $sidebar): void {
    foreach ($sidebar->getChildren() as $panel) {
        if ($panel->getChild('Network Status')) {
            $panel->removeChild('Network Status');
        }
        foreach (['Register a New Domain', 'Transfer in a Domain'] as $name) {
            if ($panel->getChild($name)) {
                $panel->removeChild($name);
            }
        }
    }
});

add_hook('OrderFormSidebar', 1, static function (MenuItem $secondarySidebar): void {
    $domainItemNames = [
        'Register a New Domain',
        'Transfer in a Domain',
        'Transfer Domains to Us',
        'Domain Checker',
        'Domain Renewals',
        'My Domains',
    ];

    // Remove domain items from every panel (Actions, etc.) in the cart sidebar
    foreach ($secondarySidebar->getChildren() as $panel) {
        foreach ($domainItemNames as $name) {
            if ($panel->getChild($name)) {
                $panel->removeChild($name);
            }
        }
    }

    // Remove the entire Actions panel if it becomes empty after domain removal
    $actions = $secondarySidebar->getChild('Actions');
    if ($actions !== null && !$actions->hasChildren()) {
        $secondarySidebar->removeChild('Actions');
    }
});

add_hook('ClientAreaSecondaryNavbar', 1, static function (MenuItem $secondaryNavbar): void {
    $toRemove = [
        'Domain Details Management',
        'Domain Contacts Management',
        'Domain Addons',
        'Nameservers',
        'DNS Management',
        'Email Forwarding',
        'Registrar Lock',
        'Get EPP Code',
        'Manage Domain',
    ];

    foreach ($toRemove as $name) {
        if ($secondaryNavbar->getChild($name)) {
            $secondaryNavbar->removeChild($name);
        }
    }
});

add_hook('ClientAreaHomepagePanels', 1, static function (MenuItem $homePagePanels): void {
    if ($homePagePanels->getChild('Register a New Domain')) {
        $homePagePanels->removeChild('Register a New Domain');
    }
});

/**
 * CSS fallback: force-hide domain/network elements when menu hooks fail.
 * Targets sidebar links by menuItemName and by href.
 */
add_hook('ClientAreaHeadOutput', 1, static function (): string {
    return <<<'CSS'
<style id="venom-hide-domains-network">
/* Sidebar: Network Status (Support card) */
a[menuItemName="Network Status"],
a[href*="serverstatus"],
a[href*="networkissues"],
.sidebar a[href*="serverstatus"],
.sidebar a[href*="networkissues"] {
    display: none !important;
}
/* Sidebar: Register a New Domain (Shortcuts card) */
a[menuItemName="Register a New Domain"],
a[href*="domainchecker"],
a[href*="domain=register"],
a[href*="domain=transfer"],
.sidebar a[href*="domainchecker"],
.sidebar a[href*="domain=register"],
.sidebar a[href*="domain=transfer"] {
    display: none !important;
}
/* Navbar Support dropdown: Network Status */
.dropdown-menu a[href*="serverstatus"],
.dropdown-menu a[href*="networkissues"] {
    display: none !important;
}
/* Homepage: Register a New Domain panel */
div[menuItemName="Register a New Domain"] {
    display: none !important;
}
</style>
CSS;
});


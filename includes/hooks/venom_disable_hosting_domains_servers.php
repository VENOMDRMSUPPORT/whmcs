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

    return [
        'openNetworkIssueCounts' => [
            'open' => 0,
            'scheduled' => 0,
        ],
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

    $services = $primaryNavbar->getChild('Services');
    if ($services) {
        foreach (['My Domains', 'Register a New Domain', 'Domain Renewals'] as $name) {
            if ($services->getChild($name)) {
                $services->removeChild($name);
            }
        }
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


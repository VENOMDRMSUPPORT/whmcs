<?php
/**
 * VENOM DRM - Navigation Menu Customization Hook
 * 
 * This hook modifies the WHMCS client area navigation to:
 * - Remove Domains menu and sub-items
 * - Remove Affiliates menu
 * - Remove Network Status (unused)
 * - Remove Downloads (unused)
 * - Keep only: Home, Pricing (Store), Knowledgebase, Support, Client Area
 * 
 * @package VENOM_DRM
 * @location includes/hooks/venom_navigation.php
 */

if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

use WHMCS\View\Menu\Item as MenuItem;

/**
 * Modify the primary navigation menu (top nav)
 */
add_hook('ClientAreaPrimaryNavbar', 1, function (MenuItem $primaryNavbar) {
    
    // Remove Domains menu entirely (not applicable for SaaS licensing)
    if (!is_null($primaryNavbar->getChild('Domains'))) {
        $primaryNavbar->removeChild('Domains');
    }
    
    // Remove Affiliates menu (not using affiliate system)
    if (!is_null($primaryNavbar->getChild('Affiliates'))) {
        $primaryNavbar->removeChild('Affiliates');
    }
    
    // Remove Network Status (no public server status for SaaS)
    if (!is_null($primaryNavbar->getChild('Network Status'))) {
        $primaryNavbar->removeChild('Network Status');
    }
    
    // Remove Downloads (no public downloads)
    if (!is_null($primaryNavbar->getChild('Downloads'))) {
        $primaryNavbar->removeChild('Downloads');
    }
    
    // Rename "Services" to "Licenses" if it exists
    if (!is_null($primaryNavbar->getChild('Services'))) {
        $services = $primaryNavbar->getChild('Services');
        $services->setLabel('Licenses');
        
        // Rename submenu items
        if (!is_null($services->getChild('My Services'))) {
            $services->getChild('My Services')->setLabel('My Licenses');
        }
        if (!is_null($services->getChild('Order New Services'))) {
            $services->getChild('Order New Services')->setLabel('Order New License');
        }
    }
    
    // Ensure Store/Pricing is accessible
    if (!is_null($primaryNavbar->getChild('Store'))) {
        $store = $primaryNavbar->getChild('Store');
        $store->setLabel('Pricing');
        
        // Remove "Browse All" if it exists and rename appropriately
        if (!is_null($store->getChild('Browse Products Services'))) {
            $store->getChild('Browse Products Services')->setLabel('View Licenses');
        }
        
        // Remove any domain-related store items
        if (!is_null($store->getChild('Register Domain'))) {
            $store->removeChild('Register Domain');
        }
        if (!is_null($store->getChild('Transfer Domain'))) {
            $store->removeChild('Transfer Domain');
        }
    }
});

/**
 * Modify the secondary sidebar (client area pages)
 */
add_hook('ClientAreaSecondarySidebar', 1, function (MenuItem $secondarySidebar) {
    
    // Remove Domains sidebar if present
    if (!is_null($secondarySidebar->getChild('My Domains'))) {
        $secondarySidebar->removeChild('My Domains');
    }
    
    // Remove Affiliates sidebar if present
    if (!is_null($secondarySidebar->getChild('Affiliates'))) {
        $secondarySidebar->removeChild('Affiliates');
    }
    
    // Rename "My Services" to "My Licenses" in sidebar
    if (!is_null($secondarySidebar->getChild('My Services'))) {
        $secondarySidebar->getChild('My Services')->setLabel('My Licenses');
    }
});

/**
 * Modify the client area homepage panels
 */
add_hook('ClientAreaHomepagePanels', 1, function ($homePagePanels) {
    
    // Remove any domain-related panels
    if (!is_null($homePagePanels->getChild('Domains Expiring Soon'))) {
        $homePagePanels->removeChild('Domains Expiring Soon');
    }
    
    if (!is_null($homePagePanels->getChild('Domain Renewals'))) {
        $homePagePanels->removeChild('Domain Renewals');
    }
    
    // Remove affiliate panel if present
    if (!is_null($homePagePanels->getChild('Affiliate Program'))) {
        $homePagePanels->removeChild('Affiliate Program');
    }
    
    // Rename services panel to licenses
    if (!is_null($homePagePanels->getChild('Active Products/Services'))) {
        $homePagePanels->getChild('Active Products/Services')->setLabel('Your Active Licenses');
    }
    
    if (!is_null($homePagePanels->getChild('Services Renewing Soon'))) {
        $homePagePanels->getChild('Services Renewing Soon')->setLabel('Licenses Renewing Soon');
    }
    
    return $homePagePanels;
});

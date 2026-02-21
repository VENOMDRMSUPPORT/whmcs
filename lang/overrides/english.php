<?php
/**
 * WHMCS Language Overrides - VENOM DRM Branding
 * 
 * This file overrides default WHMCS language strings to transform
 * the portal from "web hosting" to "SaaS licensing portal".
 * 
 * @package VENOM_DRM
 * @location lang/overrides/english.php
 */

// Company Branding
$_LANG['companyName'] = "VENOM Solutions";
$_LANG['copyrightFooterNotice'] = "Copyright &copy; :year VENOM Solutions. All Rights Reserved.";

// Navigation - Replace hosting/domain terminology
$_LANG['navservices'] = "Licenses";
$_LANG['navservicesorder'] = "Order New License";
$_LANG['navservicesplaceorder'] = "Purchase a License";
$_LANG['navdomains'] = ""; // Hide domains
$_LANG['navrenewdomains'] = "";
$_LANG['navregisterdomain'] = "";
$_LANG['navtransferdomain'] = "";
$_LANG['navdomainsearch'] = "";

// Client Area Labels
$_LANG['clientareanavservices'] = "My Licenses";
$_LANG['clientareaproducts'] = "My Licenses";
$_LANG['clientareaproductsnone'] = "No Licenses Ordered";
$_LANG['clientareahostingaddons'] = "License Addons";
$_LANG['clientareahostingpackage'] = "License Type";
$_LANG['clientareadescription'] = "Manage your software licenses";

// Service Labels
$_LANG['hosting'] = "Software License";
$_LANG['servicesRenew'] = "Renew License";
$_LANG['clientareaactive'] = "Active";
$_LANG['clientareasuspended'] = "Suspended";
$_LANG['clientareacancelled'] = "Cancelled";
$_LANG['clientareaterminated'] = "Terminated";
$_LANG['clientareapending'] = "Pending";

// Order Form Labels
$_LANG['orderchooseapackage'] = "Choose a License";
$_LANG['orderproduct'] = "License";
$_LANG['ordernoproducts'] = "No Licenses Available";
$_LANG['cartbrowse'] = "Browse Licenses";
$_LANG['cartproductaddons'] = "License Addons";
$_LANG['cartproductaddonsnone'] = "No Addons Available for your Licenses";

// Product/Service Labels
$_LANG['clientareaproductdetails'] = "License Details";
$_LANG['clientareaproductusagebilling'] = "Usage Billing";
$_LANG['clientareaviewdetails'] = "View License Details";
$_LANG['clientareacancelproduct'] = "Cancel License";
$_LANG['clientareacancelrequest'] = "License Cancellation Request";
$_LANG['clientareacancelreason'] = "Reason for Cancellation";

// Upgrade/Downgrade
$_LANG['upgradedowngradepackage'] = "Upgrade/Downgrade License";
$_LANG['upgradedowngradeshort'] = "Upgrade";
$_LANG['upgradechoosepackage'] = "Choose New License";
$_LANG['upgradenewconfig'] = "New License Configuration";

// Remove domain-related messages
$_LANG['cartdomainshashosting'] = "";
$_LANG['cartdomainsnohosting'] = "";
$_LANG['cartconfigdomainextras'] = "";

// Dashboard/Home Labels
$_LANG['clientHomePanels']['activeProductsServices'] = "Your Active Licenses";
$_LANG['clientHomePanels']['activeProductsServicesNone'] = "You don't have any active licenses yet. <a href=\"cart.php\">Purchase a license</a> to get started.";
$_LANG['clientHomePanels']['serviceRenewingSoon'] = "Licenses Renewing Soon";
$_LANG['clientHomePanels']['serviceRenewingSoonMsg'] = "You have :numberOfServices license(s) that are available for renewal soon.";

// Stats
$_LANG['statsnumproducts'] = "Number of Licenses";
$_LANG['statsnumdomains'] = ""; // Hide

// Module Actions
$_LANG['serverchangepassword'] = "Change License Password";
$_LANG['serverstatusdescription'] = "View license server status";

// Invoices - keep but adjust context
$_LANG['clientareahostingdomain'] = "License ID";
$_LANG['clientareahostingnextduedate'] = "Next Due Date";

// General
$_LANG['globalsystemname'] = "VENOM DRM Portal";
$_LANG['headertext'] = "Welcome to VENOM DRM — Your Software Licensing Portal";
$_LANG['clientareaheader'] = "Welcome to your VENOM DRM client portal. Manage your software licenses, view invoices, and get support.";

// Search
$_LANG['clientHomeSearchKb'] = "Search our knowledgebase for answers...";

// Footer disclaimer
$_LANG['footerDisclaimer'] = "Software Only · No Content Included";

<?php
/**
 * VENOM Solutions — Guest Homepage Redirect Hook
 *
 * Redirects unauthenticated visitors who land on clientarea.php with no action
 * to the product landing page (/landing.php).
 *
 * IMPORTANT: The original WHMCS index.php must remain in place as the front
 * controller for all WHMCS routing. This hook only redirects guests from the
 * clientarea.php "home" page to the marketing landing page.
 *
 * Why a hook instead of .htaccess:
 *   The production stack uses nginx as the frontend server. nginx does not
 *   process .htaccess files, so mod_rewrite rules have no effect. This WHMCS
 *   hook fires before any template output and issues a proper HTTP 302 redirect.
 *
 * Scope: guest (non-logged-in) visitors only.
 *   Logged-in clients are not affected; their client portal is at /clientarea.php.
 *
 * @package VENOM_Solutions
 * @location includes/hooks/venom_homepage_redirect.php
 */

if (!defined('WHMCS')) {
    die('This file cannot be accessed directly');
}

add_hook('ClientAreaPage', 1, function (array $vars) {
    // Determine the script being executed (SCRIPT_NAME or PHP_SELF).
    // ClientAreaPage fires for index.php / clientarea.php routes only, but
    // it can also fire for other WHMCS front-end scripts (cart.php, etc.).
    // Restrict to the home route by checking the entry script and action.
    $script = basename($_SERVER['SCRIPT_NAME'] ?? '');

    // Only redirect when on clientarea.php home (index.php handles WHMCS routing)
    if ($script !== 'clientarea.php') {
        return;
    }

    // Determine the current page action (empty = WHMCS home page)
    $action = isset($_REQUEST['action']) ? trim($_REQUEST['action']) : '';

    // WHMCS pretty-URL routing uses the 'rp' parameter (e.g. /store/licenses).
    // If 'rp' is set, this is a routed page (cart, store, KB, etc.), not the home.
    $rp = isset($_REQUEST['rp']) ? trim($_REQUEST['rp']) : '';

    // Only intercept the home page (no action, no rp, or action explicitly 'home')
    if (!empty($rp)) {
        return;
    }
    if (!empty($action) && $action !== 'home') {
        return;
    }

    // Detect if the visitor is logged in via the active WHMCS session
    $loggedIn = !empty($_SESSION['uid']) && (int) $_SESSION['uid'] > 0;

    if (!$loggedIn) {
        // Guest: send to the product landing page
        header('Location: /landing.php', true, 302);
        exit();
    }

    // Logged-in clients: leave clientarea.php home page untouched
    // (clientareahome-venom.tpl will render the SaaS portal widgets)
});

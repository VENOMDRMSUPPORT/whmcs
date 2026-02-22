<?php
/**
 * VENOM Solutions — Front Controller Router
 *
 * This file routes requests to either:
 *   - landing.php (for root "/" with no params) → marketing landing page
 *   - index-whmcs.php (for all other requests) → WHMCS routing
 *
 * This keeps the URL clean while preserving all WHMCS functionality.
 */

// Check if this is a root request with no routing parameters
$rp = isset($_GET['rp']) ? trim($_GET['rp']) : '';
$action = isset($_GET['action']) ? trim($_GET['action']) : '';
$queryString = $_SERVER['QUERY_STRING'] ?? '';

// If no rp, no action, and no query string → show landing page
if (empty($rp) && empty($action) && empty($queryString)) {
    require __DIR__ . '/landing.php';
    exit;
}

// Otherwise, let WHMCS handle the request
require __DIR__ . '/index-whmcs.php';

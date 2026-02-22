<?php
/**
 * VENOM DRM - Suppress System Health Warnings
 *
 * Hides specific health check warnings on the System Health page:
 * 1. nginx Web Server Support Check - when nginx is properly configured
 * 2. Update Available - when intentionally staying on current version (no upgrade)
 * 3. Automatic Update Requirements - when not using automatic updates
 * 4. Website SSL (CA verified) - when using local/self-signed certificate
 *
 * @package VENOM_DRM
 * @location includes/hooks/venom_nginx_health_suppress.php
 */

if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

add_hook('AdminAreaFooterOutput', 1, function ($vars) {
    $filename = $vars['filename'] ?? '';
    $pagetemplate = $vars['pagetemplate'] ?? '';
    $templatefile = $vars['templatefile'] ?? '';

    $isHealthPage = (
        $filename === 'systemhealthandupdates' ||
        $pagetemplate === 'systemhealthandupdates' ||
        $templatefile === 'systemhealthandupdates' ||
        strpos($_SERVER['REQUEST_URI'] ?? '', 'systemhealthandupdates') !== false
    );

    if (!$isHealthPage) {
        return '';
    }

    return <<<'HTML'
<script type="text/javascript">
(function() {
    var SUPPRESS_WARNING = [
        'webserverSupportCheck', 'WebserverSupportCheck',
        'updateAvailable', 'UpdateAvailable',
        'updaterTempSet', 'updaterTempWriteable',
        'updaterRequirements',
        'UpdaterTempSet', 'UpdaterTempWriteable',
        'caSslNotDetected', 'CaSslNotDetected'
    ];

    var UPDATER_WARNING_TEXTS = [
        'writeable directory for staging',
        'Updater Configuration',
        'temporary path that is set currently cannot be written',
        'Please upgrade to the latest version',
        'updates are available',
        'learn about performing an upgrade',
        'Certificate Authority verified SSL certificate was not detected',
        'Purchase an SSL Certificate here'
    ];

    function suppressHealthWarnings() {
        var hiddenCount = { warning: 0, danger: 0 };

        SUPPRESS_WARNING.forEach(function(id) {
            var panel = document.getElementById(id);
            if (panel) {
                var isDanger = panel.closest('.health-status-col-danger');
                panel.style.display = 'none';
                if (isDanger) {
                    hiddenCount.danger++;
                } else {
                    hiddenCount.warning++;
                }
            }
        });

        var panels = document.querySelectorAll('.health-status-col .panel-body .panel[id]');
        panels.forEach(function(panel) {
            var text = (panel.textContent || '').toLowerCase();
            if (UPDATER_WARNING_TEXTS.some(function(t) { return text.indexOf(t.toLowerCase()) >= 0; })) {
                var isDanger = panel.closest('.health-status-col-danger');
                if (panel.style.display !== 'none') {
                    panel.style.display = 'none';
                    if (isDanger) {
                        hiddenCount.danger++;
                    } else {
                        hiddenCount.warning++;
                    }
                }
            }
        });

        if (hiddenCount.warning > 0) {
            var warnEl = document.querySelector('.health-status-block-warning .count');
            if (warnEl) {
                var n = parseInt(warnEl.textContent, 10);
                if (!isNaN(n) && n > 0) {
                    warnEl.textContent = Math.max(0, n - hiddenCount.warning);
                }
            }
        }
        if (hiddenCount.danger > 0) {
            var dangerEl = document.querySelector('.health-status-block-danger .count');
            if (dangerEl) {
                var n = parseInt(dangerEl.textContent, 10);
                if (!isNaN(n) && n > 0) {
                    dangerEl.textContent = Math.max(0, n - hiddenCount.danger);
                }
            }
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', suppressHealthWarnings);
    } else {
        suppressHealthWarnings();
    }
    setTimeout(suppressHealthWarnings, 500);
})();
</script>
HTML;
});

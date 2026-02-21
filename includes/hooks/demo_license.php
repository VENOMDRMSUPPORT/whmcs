<?php
/**
 * Demo License Hooks
 * File: includes/hooks/demo_license.php
 *
 * (1) AfterModuleCreate  – sets nextduedate = regdate + 7 days for pid=3
 * (2) DailyCronJob       – sends 48-hour warnings + suspends expired demos
 */

if (!defined('WHMCS')) {
    die('This file cannot be accessed directly');
}

use WHMCS\Database\Capsule;

/**
 * Ensure warning log table exists to avoid duplicate warning sends.
 */
function venomEnsureDemoWarningTable()
{
    Capsule::statement(
        "CREATE TABLE IF NOT EXISTS mod_demo_warning_logs (
            id INT UNSIGNED NOT NULL AUTO_INCREMENT,
            service_id INT UNSIGNED NOT NULL,
            due_date DATE NOT NULL,
            warned_at DATETIME NOT NULL,
            created_at DATETIME NOT NULL,
            updated_at DATETIME NOT NULL,
            PRIMARY KEY (id),
            UNIQUE KEY uniq_service_id (service_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8"
    );
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
        ]);

    logActivity("Demo License Hook: Service #$serviceId — nextduedate set to $expireDate (7-day trial)");
});

// ─────────────────────────────────────────────────────────────
// HOOK 2: DailyCronJob – expire overdue demo services
// ─────────────────────────────────────────────────────────────
add_hook('DailyCronJob', 1, function ($vars) {
    try {
        $today = date('Y-m-d');
        $warningDate = date('Y-m-d', strtotime($today . ' +2 days'));

        venomEnsureDemoWarningTable();

        $activeDemoCount = Capsule::table('tblhosting')
            ->where('packageid', 3)
            ->where('domainstatus', 'Active')
            ->count();

        // Send one-time 48-hour warning for active demos.
        $warningCandidates = Capsule::table('tblhosting')
            ->where('packageid', 3)
            ->where('domainstatus', 'Active')
            ->where('nextduedate', '=', $warningDate)
            ->get(['id', 'userid', 'nextduedate']);

        $warningSent = 0;
        $warningSkipped = 0;
        $warningErrors = 0;

        foreach ($warningCandidates as $service) {
            $serviceId = (int) $service->id;

            $alreadyWarned = Capsule::table('mod_demo_warning_logs')
                ->where('service_id', $serviceId)
                ->exists();

            if ($alreadyWarned) {
                $warningSkipped++;
                continue;
            }

            try {
                $emailResult = localAPI('SendEmail', [
                    'messagename' => 'Demo Expiry Warning',
                    'id'          => $serviceId,
                ]);

                if (($emailResult['result'] ?? 'error') === 'success') {
                    Capsule::table('mod_demo_warning_logs')->insert([
                        'service_id' => $serviceId,
                        'due_date'   => $service->nextduedate,
                        'warned_at'  => date('Y-m-d H:i:s'),
                        'created_at' => date('Y-m-d H:i:s'),
                        'updated_at' => date('Y-m-d H:i:s'),
                    ]);

                    $warningSent++;
                    logActivity("Demo Expiry Warning sent for Service #$serviceId (due {$service->nextduedate})");
                } else {
                    $warningErrors++;
                    $apiMessage = $emailResult['message'] ?? 'Unknown SendEmail error';
                    logActivity("Demo Expiry Warning failed for Service #$serviceId: $apiMessage");
                }
            } catch (\Exception $e) {
                $warningErrors++;
                logActivity("Demo Expiry Warning exception for Service #$serviceId: " . $e->getMessage());
            }
        }

        // Find all Active demo services that are past their due date
        $expired = Capsule::table('tblhosting')
            ->where('packageid', 3)
            ->where('domainstatus', 'Active')
            ->where('nextduedate', '<', $today)
            ->get();

        $expiredCount = $expired->count();
        $suspendSuccess = 0;
        $suspendFallback = 0;
        $suspendErrors = 0;

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
                    $suspendSuccess++;
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
                        ]);

                    $suspendFallback++;
                    logActivity("Demo License Expired (DB fallback): Service #$serviceId suspended on $today");
                }
            } catch (\Exception $e) {
                $suspendErrors++;
                logActivity("Demo License Hook ERROR: Service #$serviceId — " . $e->getMessage());
            }
        }

        logActivity(
            sprintf(
                'Demo DailyCronJob ran at %s | activeEvaluated=%d | warningDate=%s | warningCandidates=%d | warningSent=%d | warningSkipped=%d | warningErrors=%d | expiredEvaluated=%d | suspended=%d | fallback=%d | suspendErrors=%d',
                date('Y-m-d H:i:s'),
                $activeDemoCount,
                $warningDate,
                $warningCandidates->count(),
                $warningSent,
                $warningSkipped,
                $warningErrors,
                $expiredCount,
                $suspendSuccess,
                $suspendFallback,
                $suspendErrors
            )
        );
    } catch (\Throwable $e) {
        logActivity('Demo DailyCronJob hook exception: ' . $e->getMessage());
    }
});

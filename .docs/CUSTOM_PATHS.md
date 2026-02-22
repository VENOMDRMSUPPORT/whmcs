# Custom Paths Configuration

WHMCS default paths have been customized for security (per "Customising Default Paths" health check).

## Changes Made

| Default Path | Custom Path |
|--------------|-------------|
| `templates_c` | `storage/compiled_templates` |
| `crons` | `whmcs_crons` |

## Cron Job Update Required

Update your system crontab to use the new cron path:

**Old:**
```
*/5 * * * * php -q /home/venom/workspace/venom-drm.test/crons/cron.php all
```

**New:**
```
*/5 * * * * php -q /home/venom/workspace/venom-drm.test/whmcs_crons/cron.php all
```

Or with full PHP path:
```
*/5 * * * * /home/venom/bin/php8.1 -q /home/venom/workspace/venom-drm.test/whmcs_crons/cron.php all
```

## WHMCS Upgrades

When upgrading WHMCS, copy any updated files from the default `crons/` directory to `whmcs_crons/`.

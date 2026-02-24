# AGENTS.md

## Cursor Cloud specific instructions

### Codebase overview

This is a **WHMCS 9.0.1** installation with a custom **Venom Solutions** client-facing template. The development work targets:

- `templates/venom-solutions/` — Smarty `.tpl` templates, CSS (`css/venom-main.css`), JS (`js/venom-main.js`)
- `includes/hooks/` — PHP hooks (e.g., `venom_disable_hosting_domains_servers.php`)
- `modules/addons/ai_copilot/` — custom addon module
- `seed_venom_solutions.php` — database seeder for Venom Solutions products/config

Core WHMCS PHP files are **ionCube-encoded** and must not be edited.

### Services and how to start them

| Service | Start command | Port |
|---------|--------------|------|
| MariaDB | `sudo mysqld_safe &` | 3306 |
| Apache | `sudo apachectl start` | 8080 |

Both must be running for WHMCS to serve pages. MariaDB must start before Apache.

### Known environment limitations

**Incomplete vendor directory:** The git repository has `vendor/` in `.gitignore`, meaning many proprietary WHMCS vendor files (especially from `whmcs/whmcs-foundation`) were never committed. The application cannot fully boot without the complete WHMCS 9.0.1 distribution files. A stub autoloader at `vendor/whmcs/whmcs-foundation/lib/stub_autoloader.php` (loaded via `vendor/autoload.php`) generates placeholder stubs for missing classes, but this is insufficient for full operation since the encoded core code expects specific constants, methods, and class hierarchies.

**WHMCS license key:** `configuration.php` has a placeholder license key (`dev-mode`). A valid WHMCS license key is required for the application to pass license validation.

### Database

- **Engine:** MariaDB 10.11
- **Database:** `whmcs` / **User:** `whmcs` / **Password:** `whmcs_dev_pass`
- **Host:** `127.0.0.1:3306`
- **Schema:** 170 tables imported from `resources/sql/install/*.schema.sql` and `*.data.sql`
- **Admin user:** `admin` / password `admin123` (role: Full Administrator)

### PHP setup

- **Version:** PHP 8.2 (required — ionCube-encoded files specify PHP 8.2–8.3 compatibility range)
- **ionCube Loader:** v15.0 installed at `/usr/lib/php/20220829/ioncube_loader_lin_8.2.so`
- **Extensions:** mysql, curl, gd, mbstring, xml, zip, intl, soap, imap, bcmath, gmp
- **Default PHP binary:** `/usr/bin/php8.2` (symlinked to `/usr/local/bin/php`)

### Linting and syntax checking

- **PHP syntax:** `php -l <file>` for custom PHP files
- **Template files:** Smarty `.tpl` files can be reviewed for syntax but require a running WHMCS instance for full rendering validation
- No ESLint/Prettier/phpcs configuration exists in the repo

### Testing

- No automated test framework is configured in this repo
- Template changes require a running WHMCS instance to visually verify
- The `seed_venom_solutions.php` script requires a fully booted WHMCS instance (it calls `localAPI`)

### Configuration file

`configuration.php` is gitignored. It must be created from `configuration.sample.php` with database credentials, license key, and encryption hash. The current dev setup has this file already in place at `/workspace/configuration.php`.

### Apache configuration

Virtual host at `/etc/apache2/sites-available/whmcs.conf` serves from `/workspace` on port 8080 with `AllowOverride All` for `.htaccess` URL rewriting.

### Vendor dependency gaps

Missing vendor files were partially patched by downloading from public repos. Files created/added outside git tracking:
- `vendor/symfony/polyfill-*/bootstrap80.php` (and other polyfill files)
- `vendor/illuminate/collections/helpers.php`, `vendor/illuminate/events/functions.php`
- Various other autoload-referenced files from public packages

Refer to `vendor/composer/autoload_files.php` to verify all referenced files exist.

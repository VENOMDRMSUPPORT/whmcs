# VENOM SOLUTIONS - CLAUDE CODE STRICT INSTRUCTIONS

> **CRITICAL:** Read and follow these instructions in EVERY session. This file contains non-negotiable rules for the Venom Solutions project.

---

## PROJECT IDENTITY

**Project Name:** Venom Solutions
**User Name:** venom (address the user as "venom")
**Project Type:** Licensing Portal for Third-Party IPTV Panel
**Primary Domain:** `https://venom-drm.test`
**Project Root:** `/home/venom/workspace/venom-drm.test/`

---

## WHAT WE ARE BUILDING (AND WHAT WE ARE NOT)

### WE ARE BUILDING:
- A licensing portal that sells and manages licenses for a third-party IPTV panel
- Public pages (Landing, Pricing, FAQ, Terms, Contact)
- Client authentication and area (Dashboard, Licenses, Billing, Profile, Settings)
- Admin panel (Dashboard, Clients, Licenses, Orders, Plans, Settings, Maintenance)
- License credential issuance (URL + Username + Password format)
- Theme system (Light/Dark + 7 accent colors)

### WE ARE NOT BUILDING:
- The IPTV panel itself
- Third-party panel integration (FULLY DEFERRED to future phase)
- Real license generation/encryption (placeholder only)
- Payment gateway integration (placeholder only)

---

## NON-NEGOTIABLE RULES (VIOLATION = FAILURE)

### 1. LANGUAGE POLICY
- **In-chat conversations:** Arabic is allowed
- **Any Prompt to Agent/Cursor:** English ONLY
- **Inside project files (Code/Docs/Configs/Comments/Strings):** English ONLY - Arabic is strictly forbidden

### 2. LOCALSTORAGE IS FORBIDDEN
- **DO NOT** use localStorage for theme/accent preferences
- **DO NOT** install `next-themes`, `theme-change`, `use-dark-mode` or similar libraries
- **ALL** preferences must be stored in the database (`users.theme`, `users.accent_color`). Toast (position, duration) is a **global** setting for all users (admin-only).
- Theme class and accent data attribute are set from Inertia shared props (server → client)

### 3. UI INVARIANTS
- **Landing + Auth pages:** Always dark theme
- **Sidebar:** Always dark (never changes with theme toggle)
- **Header + Footer:** Sticky/Fixed at all times during scrolling
- **Accent colors:** Exactly 7 colors (Cyan, Red, Ocean Blue, Orange, Green, Magenta, Purple)
- **Default theme for panels:** Light
- **Default accent color:** Cyan

### 4. USER MODEL
- **Only ONE admin** (enforced at multiple levels: seeder, model, command, UI)
- **NO Resellers/Distributors**
- All non-admin users are **Clients**

### 5. SERVER ENVIRONMENT (STRICT)
- **Domain:** Access via `https://venom-drm.test` ONLY
- **FORBIDDEN:** `php artisan serve` - Nginx is the ONLY web server
- **Binary Paths (MUST USE):**
  - PHP: `/home/venom/bin/php`
  - Composer: `/home/venom/bin/composer`
  - Nginx: `/home/venom/bin/nginx`
  - PHP-FPM: `/home/venom/bin/php-fpm`
- **Service Manager:**
  - Start: `/home/venom/service start`
  - Stop: `/home/venom/service stop`
  - Restart: `/home/venom/service restart`
  - Reload: `/home/venom/service reload`
  - Status: `/home/venom/service status`
- **File Ownership:** All files must be `venom:venom`
- **NO sudo commands** - services run as venom user

### 6. REPO HYGIENE
- **DO NOT** add random files to project root
- **DO NOT** create files with names: `*_new`, `*_test`, `*_old`, `*_copy`, `temp_*`, `draft_*`
- Edit original files directly
- Documentation goes in `.docs/` folder:
  - `.docs/CHANGELOG.md` - Main changelog
  - `.docs/tasks/` - Detailed task documentation

### 7. AUTH SYSTEM
- Fortify has been removed
- Use Laravel Breeze (Inertia + React) as base
- Registration creates **client** role only (admin via seeder/command only)
- Login redirects based on role (admin→/admin/dashboard, client→/client/dashboard)
- Check `is_active` status on login

---

## TECHNOLOGY STACK

### Backend
- **Framework:** Laravel 11
- **Database:** MySQL 8.0+ or PostgreSQL 16+
- **Cache/Queue:** Redis
- **Auth:** Laravel Breeze (Inertia + React)

### Frontend
- **Framework:** Inertia.js + React 18
- **Language:** TypeScript
- **Styling:** Tailwind CSS 3.4+ (DO NOT upgrade to v4)
- **Components:** shadcn/ui (Radix primitives)
- **Build Tool:** Vite

### Testing
- **Backend:** PHPUnit + Pest
- **Frontend:** Vitest

### Dev Tools (Development Only)
- Laravel Debugbar
- Laravel Telescope

---

## CRITICAL FILE STRUCTURE

```
/home/venom/workspace/venom-drm.test/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── Admin/      # Admin panel controllers
│   │   │   ├── Client/     # Client area controllers
│   │   │   └── Public/     # Public page controllers
│   │   ├── Middleware/
│   │   └── Requests/
│   ├── Models/
│   ├── Services/           # Business logic layer
│   ├── Events/
│   ├── Listeners/
│   ├── Observers/
│   ├── Policies/
│   └── Enums/              # PHP 8.1 enums
├── database/
│   ├── migrations/
│   ├── seeders/
│   └── factories/
├── resources/
│   ├── js/
│   │   ├── Components/
│   │   │   ├── ui/         # shadcn/ui components
│   │   │   ├── Layout/     # Sidebar, Header, Footer
│   │   │   └── Shared/     # Shared components
│   │   ├── Layouts/        # Page layouts
│   │   ├── Pages/
│   │   │   ├── Admin/
│   │   │   ├── Client/
│   │   │   ├── Auth/
│   │   │   └── Public/
│   │   ├── Hooks/
│   │   ├── Lib/
│   │   └── Types/
│   └── css/
│       └── app.css         # Tailwind + theme variables
├── routes/
│   ├── web.php
│   └── auth.php
├── .docs/                  # Documentation
│   ├── CHANGELOG.md
│   └── tasks/
├── plan/                   # Planning documents
└── tests/
```

---

## DATABASE SCHEMA (CORE TABLES)

### users
- `id`, `name`, `email`, `password`
- `role` ENUM('admin', 'client') - DEFAULT 'client'
- `theme` ENUM('light', 'dark') - DEFAULT 'light'
- `accent_color` VARCHAR(20) - DEFAULT 'cyan'
- `is_active` BOOLEAN - DEFAULT TRUE
- `email_verified_at`, `remember_token`
- `created_at`, `updated_at`

### plans
- `id`, `name`, `slug` (unique)
- `description`, `price`, `currency`
- `duration_days`, `features` (JSON)
- `is_active`, `sort_order`
- `created_at`, `updated_at`

### orders
- `id`, `user_id`, `plan_id`
- `order_number` (unique), `amount`, `currency`
- `status` ENUM('pending', 'processing', 'paid', 'failed', 'cancelled', 'refunded')
- `payment_method`, `payment_ref`
- `paid_at`, `notes`
- `created_at`, `updated_at`

### licenses
- `id`, `user_id`, `order_id`, `plan_id`
- `license_url`, `token` (unique)
- `username` (unique, format: venom_XXXXXX)
- `password_encrypted` (TEXT)
- `status` ENUM('active', 'expired', 'suspended', 'revoked')
- `issued_at`, `activated_at` (reserved for future), `expires_at`
- `suspended_at`, `notes`
- `created_at`, `updated_at`

### settings
- `id`, `key` (unique), `value`, `group`, `type`
- `created_at`, `updated_at`

### audit_logs
- `id`, `user_id`, `action`, `description`
- `ip_address`, `user_agent`, `metadata` (JSON)
- `created_at`

---

## LICENSE CREDENTIALS FORMAT

### License URL Format
```
https://venom-drm.test/lc/venom/{token}
```
- `{token}` = random value (e.g., `2f4d9b8c`)

### Username Format
- Format: `venom_` + 6 random digits
- Example: `venom_483920`
- Must be verified as unique before saving

### Password
- Random strong password (e.g., `Wv!9kQ2@pR8`)
- Encrypted at rest using `Crypt::encryptString()`

### Placeholder Page
- Shows: "Welcome" + client name
- Message: Integration coming soon
- Button: "Return to My Account"

---

## CUSTOM MIDDLEWARE TO CREATE

1. **EnsureIsAdmin** - Check `role === 'admin'`, apply to `/admin/*`
2. **EnsureIsActive** - Check `is_active === true`, logout if false
3. **CheckMaintenanceMode** - Check `Setting::isMaintenanceMode()`, bypass for admin
4. **ShareUserPreferences** - Share theme/accent via Inertia

---

## PHP ENUMS TO CREATE

```php
// UserRole
enum UserRole: string
{
    case Admin = 'admin';
    case Client = 'client';
}

// OrderStatus
enum OrderStatus: string
{
    case Pending = 'pending';
    case Processing = 'processing';
    case Paid = 'paid';
    case Failed = 'failed';
    case Cancelled = 'cancelled';
    case Refunded = 'refunded';
}

// LicenseStatus
enum LicenseStatus: string
{
    case Active = 'active';
    case Expired = 'expired';
    case Suspended = 'suspended';
    case Revoked = 'revoked';
}

// AccentColor
enum AccentColor: string
{
    case Cyan = 'cyan';
    case Red = 'red';
    case OceanBlue = 'ocean-blue';
    case Orange = 'orange';
    case Green = 'green';
    case Magenta = 'magenta';
    case Purple = 'purple';
}

// ThemePreference
enum ThemePreference: string
{
    case Light = 'light';
    case Dark = 'dark';
}
```

---

## THEME SYSTEM IMPLEMENTATION

### CSS Custom Properties (resources/css/app.css)

```css
@layer base {
  /* LIGHT THEME (Default for panels) */
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: var(--accent);
    --primary-foreground: var(--accent-foreground);
    --sidebar-background: 222.2 84% 4.9%; /* ALWAYS dark */
    /* ... other variables */
  }

  /* DARK THEME */
  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    /* ... other variables */
  }

  /* ACCENT COLORS */
  [data-accent="cyan"] {
    --accent: 187 85% 53%;
    --accent-foreground: 222.2 84% 4.9%;
  }

  [data-accent="red"] {
    --accent: 0 72% 51%;
    --accent-foreground: 0 0% 100%;
  }

  /* ... other 5 accent colors */
}
```

### Theme Flow
1. User logs in → Server loads `user.theme` + `user.accent_color`
2. HandleInertiaRequests shares auth.user and global toast_position/toast_duration
3. Root React component reads preferences from props
4. Sets `<html class="dark" data-accent="cyan">`
5. CSS variables cascade to all components

### Theme Change
1. User clicks toggle → PATCH `profile.appearance.update` { theme: 'dark', accent_color }
2. Server updates DB
3. Inertia redirects back
4. React reads new props → updates `<html>` class
5. UI updates via CSS variables

---

## WORKFLOW RULES

1. **Discuss then Prompt** - No Agent Prompt written before agreeing on details
2. **Work in small phases** - Not "build entire project at once"
3. **Report-Only first** - When missing info/ambiguity, produce report before code
4. **Minimize new files** - After structure established, prefer editing existing files
5. **Always use TodoWrite** - Track tasks and progress

---

## SINGLE ADMIN ENFORCEMENT (MULTI-LAYER)

1. **Seeder/Command:** Check `User::where('role', 'admin')->exists()` before creating
2. **Model Level:** Add `creating` and `updating` boot hooks on User model
3. **Admin Panel UI:** NO button/form to create/promote admin
4. **Database (optional):** Unique partial index on `role` where `role = 'admin'`

```php
// In User model
protected static function booted(): void
{
    static::creating(function (User $user) {
        if ($user->role === UserRole::Admin && User::where('role', 'admin')->exists()) {
            throw new \RuntimeException('Only one admin account is allowed.');
        }
    });

    static::updating(function (User $user) {
        if ($user->isDirty('role') && $user->role === UserRole::Admin
            && User::where('role', 'admin')->where('id', '!=', $user->id)->exists()) {
            throw new \RuntimeException('Only one admin account is allowed.');
        }
    });
}
```

---

## EMAIL CONFIGURATION

- Support: `support@venom-drm.com`
- Admin/From: `admin@venom-drm.com`
- Mail Provider: **Resend** (API-based)

---

## SECURITY REQUIREMENTS

- CSRF protection (built into Laravel)
- Rate limiting on auth endpoints
- Password: Min 8 characters, use `Password::min(8)->uncompromised()`
- Session: secure, http_only, same_site='lax'
- No XSS vulnerabilities
- No SQL injection vulnerabilities
- No auth bypass vulnerabilities

---

## GLASSMORPHISM STYLES

```css
.glass {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.glass-card {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: var(--radius);
}

.dark .glass {
  background: rgba(0, 0, 0, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.08);
}

.dark .glass-card {
  background: rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
}
```

---

## DOCUMENTATION POLICY

### .docs/CHANGELOG.md
After EACH task, add:
- Summary of changes
- Files modified
- Important notes/limitations

### .docs/tasks/
Detailed information for each task (can be cleaned up later)

---

## BEFORE STARTING ANY WORK

1. Read the relevant plan file in `/plan/` folder
2. Verify constraints from this file
3. Use TodoWrite to track tasks
4. Discuss approach with user before coding

---

## VERIFICATION CHECKLISTS

After implementation, verify:

### Theme System
- [ ] Toggle light/dark updates all components
- [ ] Change accent updates all accent-colored elements
- [ ] Sidebar stays dark regardless of theme
- [ ] Auth pages stay dark
- [ ] No localStorage usage
- [ ] Preferences stored in DB

### Auth System
- [ ] Registration creates client only
- [ ] Login redirects by role
- [ ] is_active check works
- [ ] Only one admin can exist
- [ ] Rate limiting active

### Layout
- [ ] Sidebar: always dark, responsive
- [ ] Header: sticky, theme toggle, accent picker
- [ ] Footer: sticky
- [ ] All layouts responsive

---

## PLAN DOCUMENTS REFERENCE

| File | Content |
|------|---------|
| `plan/00-master-plan.md` | Master implementation plan |
| `plan/01-environment-setup.md` | Dev environment, Laravel install |
| `plan/02-database-design.md` | Full schema, migrations, models |
| `plan/03-authentication.md` | Auth system, guards, middleware |
| `plan/04-ui-foundation.md` | Theme system, layouts, components |
| `plan/05-public-pages.md` | Landing, Pricing, FAQ, Terms |
| `plan/06-admin-panel.md` | Admin dashboard, CRUD |
| `plan/07-client-area.md` | Client dashboard, licenses |
| `plan/08-license-system.md` | License generation, credentials |
| `plan/09-payment-system.md` | Payment flow, orders |
| `plan/10-settings-maintenance.md` | Global settings, maintenance |
| `plan/11-testing-strategy.md` | Unit, feature, E2E testing |
| `plan/12-deployment.md` | Production config, optimization |
| `plan/13-risks-mitigations.md` | Risk register, contingency |

---

## FINAL REMINDERS

1. **Address user as "venom"**
2. **Use `/home/venom/bin/` for PHP and Composer**
3. **NEVER use `php artisan serve`**
4. **NO localStorage for preferences**
5. **NO Arabic in project files**
6. **Sidebar ALWAYS dark**
7. **Only ONE admin**
8. **Integration with third-party panel is DEFERRED**
9. **Edit existing files, don't create duplicates**
10. **Use TodoWrite for task tracking**

---

*Last Updated: 2026-02-08*
*Version: 1.0*

# Antigravity Strict Instructions - Venom Solutions

## 1. STRICT: Template Scope
All UI and frontend modifications MUST be implemented in the `venom-solutions` template only.
- **Target Path**: `templates/venom-solutions/`
- **Subdirectories**: `css/`, `js/`, `includes/`
- **Prohibition**: Never modify `twenty-one`, `nexus`, or other built-in templates.
- **Inheritance**: If a file is missing in `venom-solutions`, copy it from `twenty-one` to `venom-solutions` and edit it there.

## 2. STRICT: Page Context Separation
The theme handles two distinct contexts using `$useClientHeader` and `$useClientFooter`.

### Landing & Auth Context
- **Condition**: `$useClientHeader = false`
- **Pages**: `index`, `login`, `register`, `pwreset`, `pwresetvalidation`
- **Body class**: `landing`
- **Header**: Marketing nav (`venom-header`)
- **Footer**: Full marketing footer (`venom-footer`)
- **Content**: Hero sections, pricing, marketing links, brand info.

### Client Area Context
- **Condition**: `$useClientHeader = true` (Usually `$loggedin` is true and not on an auth page)
- **Pages**: Dashboard, services, invoices, tickets, account settings, etc.
- **Body class**: `client-area`
- **Header**: Client nav (`venom-header venom-header-client`) with notifications, cart, and sidebar toggle.
- **Footer**: Compact footer (`venom-client-footer`) with locale picker and back-to-top.

## 3. WHMCS Implementation Rules
- **Links**: Always use `{$WEB_ROOT}` for paths.
- **Includes**: Always use `{$template}` (e.g., `{include file="$template/includes/logo.tpl"}`).
- **Logic**: Use `assign` for complex page detection in `header.tpl`.
- **Hooks**: Use `includes/hooks/` for backend logic; avoid modifying core files.
- **Styling**: Use `templates/venom-solutions/css/venom-main.css` for shared styles. Use CSS variables.

## 4. Operational Rules
- **Language**: Core files, comments, and commit messages must be in **English only**. Arabic is allowed only in chat/replies.
- **Edit vs Add**: Prefer refactoring existing files over adding new ones to keep the structure clean.
- **Checklist**: Before any modification, verify the target path and page context.

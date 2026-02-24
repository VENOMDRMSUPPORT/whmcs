---
description: WHMCS Venom Solutions customization workflow
---

This workflow ensures all customizations to the Venom Solutions WHMCS theme follow the strict scope and context rules.

### 1. Identify Target
Prior to editing, determine if the change is user-facing.
- If it's a template, header, footer, or asset, it MUST be in `templates/venom-solutions/`.
- If it's backend logic, use `includes/hooks/`.

### 2. Determine Page Context
Check if the page belongs to **Landing/Auth** or **Client Area**.
- **Landing/Auth**: Homepage, Login, Register, PW Reset.
- **Client Area**: Dashboard, Services, etc. (Logged in).

### 3. Implement Changes
- **CSS**: Add to `templates/venom-solutions/css/venom-main.css`.
- **Templates**: Edit `.tpl` files in `templates/venom-solutions/`.
- **Structure**:
  - Use `{$WEB_ROOT}` for links.
  - Use `{$template}` for includes.
  - Keep logic in `header.tpl` clean using the provided Smarty assignments.

### 4. Verification Checklist
- [ ] Is the path `templates/venom-solutions/`?
- [ ] Is the correct header/footer context applied?
- [ ] Are all strings in English?
- [ ] Is the design responsive and premium?

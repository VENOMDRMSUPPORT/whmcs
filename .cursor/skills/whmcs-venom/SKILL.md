---
name: whmcs-venom
description: WHMCS customization for the venom-solutions theme. Use when editing templates, hooks, client area, order flows, or Smarty logic. Enforces venom-solutions scope, page context separation (landing/auth vs client area), and WHMCS best practices.
---

# WHMCS Venom Solutions

## Scope

All user-facing changes must target `templates/venom-solutions/`. Never modify twenty-one, nexus, or core WHMCS templates for frontend changes.

## Page Context

### Landing & Auth
- Pages: `index`, `login`, `register`, `pwreset`, `pwresetvalidation`
- Header: `venom-header` (marketing nav)
- Footer: `venom-footer` (full marketing footer)
- Body: `class="landing"`

### Client Area
- Pages: All when `$loggedin` is true
- Header: `venom-header venom-header-client`
- Footer: `venom-client-footer`
- Body: `class="client-area"`

Use `$useClientHeader` and `$useClientFooter` in header.tpl/footer.tpl. Do not mix landing and client-area UI.

## Smarty Best Practices

- Keep template logic minimal; move heavy logic to PHP hooks.
- Use `{$WEB_ROOT}` for all links.
- Use `{$template}` for includes: `{include file="$template/includes/logo.tpl"}`.
- Avoid `{php}` and ASP-style tags; WHMCS 9 uses Smarty 4.
- Use `{$filename}` and `$templatefile` for page detection.

## Hooks

- Use `includes/hooks/` with clear priority and scoped conditions.
- Avoid hidden side effects; document any change to core behavior.
- Prefer `ClientAreaPage` and `ClientAreaHeadOutput` for client-area customizations.
- Use `ClientAreaFooterOutput` for footer scripts.
- Validate compatibility with order forms and clientarea routing.

## Styling

- Shared styles: `templates/venom-solutions/css/venom-main.css`
- Page-specific: inline in template only when necessary.
- Use CSS variables for tokens; keep mobile-first responsive.

## File Structure

| Type | Location |
|------|----------|
| Templates | `templates/venom-solutions/*.tpl` |
| Includes | `templates/venom-solutions/includes/` |
| CSS | `templates/venom-solutions/css/venom-main.css` |
| JS | `templates/venom-solutions/js/venom-main.js` |
| Hooks | `includes/hooks/` |
| Lang overrides | `lang/overrides/` |

## Upgrade Safety

- Do not edit core WHMCS files outside templates.
- Document any change touching WHMCS core behavior.
- Prefer child-theme style overrides and minimal divergence.

## Checklist Before Editing

- [ ] Target is `templates/venom-solutions/` (or hooks/lang)
- [ ] Correct page context (landing vs client area)
- [ ] No edits to twenty-one/nexus templates
- [ ] Links use `{$WEB_ROOT}` and `{$template}`

## Additional Resources

- For hooks, Smarty variables, and template logic details, see [reference.md](reference.md)

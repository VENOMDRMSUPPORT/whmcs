# Venom Solutions Theme Structure

## Core Layout
- `header.tpl`: global header, navigation, logo include
- `footer.tpl`: global footer, legal links, support info
- `includes/logo.tpl`: unified animated V logo + brand text

## Styling
- `css/venom-main.css`: shared tokens, components, responsive behavior

## Scripts
- `js/venom-main.js`: mobile navigation, anchor smooth-scroll, copy helpers

## Auth Pages
- `login.tpl`
- `clientregister.tpl`
- `pwreset.tpl`
- `pwresetvalidation.tpl`
- `clientareachangepw.tpl`

## Client Area Pages
- `clientareahome.tpl`
- `clientareadetails.tpl`
- `clientareaproducts.tpl`
- `clientareaproductdetails.tpl`
- `clientarearenewals.tpl`
- `upgrade.tpl`

## Billing Pages
- `clientareainvoices.tpl`
- `viewinvoice.tpl`
- `clientareaaddfunds.tpl`
- `clientareacreditcard.tpl`

## Support Pages
- `supportticketslist.tpl`
- `supportticketsubmit.tpl`
- `viewticket.tpl`
- `contact.tpl`

## Error/Status Pages
- `404.tpl`
- `maintenance.tpl`

## Development Notes
- Keep new shared styles in `css/venom-main.css`.
- Keep page-specific styles inside page templates only when necessary.
- Reuse `includes/logo.tpl` for all brand placements.
- Prefer `{$WEB_ROOT}` links to keep paths portable.

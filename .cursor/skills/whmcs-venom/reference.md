# WHMCS Venom Reference

## Common Hooks for Client Area

| Hook | Use Case |
|------|----------|
| `ClientAreaPage` | Inject variables, modify page output |
| `ClientAreaHeadOutput` | Add CSS/JS to head |
| `ClientAreaFooterOutput` | Add scripts before `</body>` |
| `ClientAreaPrimarySidebar` | Modify sidebar content |
| `ClientAreaSecondarySidebar` | Modify secondary sidebar |
| `ClientAreaProductDetailsOutput` | Product-specific output |

## Smarty Variables

| Variable | Description |
|----------|-------------|
| `$filename` | Current page (index, login, clientarea, etc.) |
| `$templatefile` | Template name (clientareahome, viewinvoice, etc.) |
| `$loggedin` | User authenticated |
| `$client` | Client data when logged in |
| `$WEB_ROOT` | Base URL path |
| `$template` | Active template name (venom-solutions) |

## Venom-Solutions Logic

```smarty
{* Page context *}
{assign var=isAuthPage value=($filename eq 'login' or $filename eq 'register' or $filename eq 'pwreset')}
{assign var=isLandingPage value=($filename eq 'index')}
{assign var=useClientHeader value=($loggedin and not $isAuthPage and not $isLandingPage)}

{* Conditional header/footer *}
{if $useClientHeader}
    {* Client area header content *}
{else}
    {* Landing/auth header content *}
{/if}
```

## Template Inheritance

venom-solutions extends twenty-one. Missing files fall back to twenty-one. To customize a page, copy from twenty-one into venom-solutions and edit there.

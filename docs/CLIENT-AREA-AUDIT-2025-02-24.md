# Venom Solutions – Client Area Audit Report
**Date:** February 24, 2025
**Scope:** Client area pages only (logged-in user experience)
**Template:** `templates/venom-solutions/`
---
## Executive Summary
The venom-solutions template has a solid foundation for core client area pages with a
consistent `client-unified-page` layout (sidebar + main content). However, **many clie
nt area pages are missing** and fall back to twenty-one/nexus, causing a jarring style
 mismatch. Several existing pages have **hardcoded values**, **non-functional UI**, or
 **inconsistencies** that affect usability.
---
## 1. Missing Pages (Fallback to twenty-one/nexus)
When a template file does not exist in venom-solutions, WHMCS uses the default theme (
twenty-one or nexus). These pages will look completely different from the venom-soluti
ons design.
### High Priority (Commonly Used)
| Template | Purpose | User Impact |
|----------|---------|-------------|
| `clientareadomains.tpl` | My Domains list | Domains page uses different theme |
| `clientareasecurity.tpl` | 2FA, security settings | Security page inconsistent |
| `affiliates.tpl` | Affiliate dashboard | Linked from header nav – different look |
| `announcements.tpl` | Announcements list | Linked from Support nav – different look
|
| `knowledgebase.tpl` | KB home | Linked from Support nav – different look |
| `knowledgebasecat.tpl` | KB category | Different look |
| `knowledgebasearticle.tpl` | KB article view | Different look |
| `downloads.tpl` | Downloads list | Different look |
| `downloadscat.tpl` | Download category | Different look |
| `viewquote.tpl` | View quote | Different look |
### Account & Billing
| Template | Purpose |
|----------|---------|
| `clientareaemails.tpl` | Email history |
| `clientareaquotes.tpl` | Quotes list |
| `clientareacancelrequest.tpl` | Cancel request |
| `account-paymentmethods.tpl` | Payment methods (new layout) |
| `account-paymentmethods-billing-contacts.tpl` | Billing contacts |
| `account-paymentmethods-manage.tpl` | Manage payment method |
| `account-contacts-manage.tpl` | Manage contact |
| `account-contacts-new.tpl` | New contact |
### User Management (WHMCS 9+)
| Template | Purpose |
|----------|---------|
| `user-profile.tpl` | User profile |
| `user-password.tpl` | User password |
| `user-security.tpl` | User security |
| `user-verify-email.tpl` | Verify email |
| `user-switch-account.tpl` | Switch account |
| `user-switch-account-forced.tpl` | Forced account switch |
| `user-invite-accept.tpl` | Accept invite |
| `account-user-management.tpl` | User management |
| `account-user-permissions.tpl` | User permissions |
### Domain Management
| Template | Purpose |
|----------|---------|
| `clientareadomaindetails.tpl` | Domain details |
| `clientareadomainemailforwarding.tpl` | Email forwarding |
| `clientareadomaincontactinfo.tpl` | Domain contact |
| `clientareadomaindns.tpl` | DNS management |
| `clientareadomainaddons.tpl` | Domain addons |
| `clientareadomainregisterns.tpl` | Nameservers |
| `clientareadomaingetepp.tpl` | EPP code |
| `bulkdomainmanagement.tpl` | Bulk domain management |
### Other
| Template | Purpose |
|----------|---------|
| `viewannouncement.tpl` | Single announcement |
| `serverstatus.tpl` | Server status |
| `affiliatessignup.tpl` | Affiliate signup |
| `configuressl-stepone.tpl` | SSL config step 1 |
| `configuressl-steptwo.tpl` | SSL config step 2 |
| `configuressl-complete.tpl` | SSL config complete |
| `clientareaproductusagebilling.tpl` | Usage/billing (included in product details) |
---
## 2. Pages with Issues or Inconsistencies
### 2.1 `clientareaproductdetails.tpl`
**Problems:**
- **Hardcoded credentials:** Access URL `https://venom-drm.test/`, License Key `VNM-{$
serviceId}-XXXX-XXXX`, Username `client-{$serviceId}` are static. These should come fr
om WHMCS module output (`$moduleoutput`, `$servicedata`, or product-specific variables
).
- **Hardcoded "Open Panel" link:** Points to `https://venom-drm.test/` instead of dyna
mic service URL.
- **Generic layout:** Designed for a single product type (license/DRM). Hosting, domai
ns, and other product types need module-specific output via `{if $moduleoutput}{$modul
eoutput}{/if}` or similar.
- **Auto-Renew:** Shows "Enabled" statically; should use `$autorenew` or equivalent.
**Recommendation:** Use WHMCS `$moduleoutput` for product-specific content and only sh
ow credential blocks when real data exists.
---
### 2.2 `clientareaproducts.tpl`
**Problems:**
- **Non-functional filter tabs:** "All Services", "Active", "Suspended", "Expired" are
 plain buttons with no filtering. They do not filter the `$services` list.
- **No pagination:** If there are many services, all are shown at once.
- **Renew link:** Uses `action=renew` – verify this matches WHMCS routing (may need `c
art.php?a=confproduct&...` for renewal flow).
**Recommendation:** Either implement client-side filtering with data attributes, or us
e server-side filtering via URL params and pass filtered `$services` from controller.
---
### 2.3 `clientareaaddfunds.tpl`
**Problems:**
- **Hardcoded payment methods:** PayPal, Credit Card, Crypto are hardcoded. WHMCS prov
ides `$gateways` or similar – the form should iterate over available gateways.
- **Form action:** Posts to `clientarea.php?action=addfunds` but the actual payment fl
ow usually redirects to a gateway. Ensure `paymentmethod` and `amount` match WHMCS exp
ectations.
- **Currency symbol:** Uses `$` – should use `{$currency.prefix}` or `{$currency.code}
`.
**Recommendation:** Use `{foreach $gateways as $gateway}` (or equivalent) and `{$curre
ncy.prefix}` for amounts.
---
### 2.4 `clientareacreditcard.tpl`
**Problems:**
- **Raw card input:** Form collects card number, expiry, CVV directly. Most gateways u
se tokenization (Stripe, etc.) – raw card storage is often disabled for PCI compliance
.
- **Delete flow:** `?action=creditcard&delete=` may not match WHMCS API. Verify correc
t delete endpoint.
- **No gateway selection:** If multiple card gateways exist, user cannot choose.
**Recommendation:** Check WHMCS credit card flow – if tokenization is used, show gatew
ay-specific iframe/component instead of raw inputs.
---
### 2.5 `contact.tpl`
**Problems:**
- **Different layout:** Uses `contact-page` / `contact-shell` instead of `client-unifi
ed-page`. When a logged-in user visits Contact, the page does not match other client a
rea pages (no sidebar, different structure).
- **Hardcoded email:** `support@venom-solutions.com` – should use `{$companyemail}` or
 config variable.
**Recommendation:** For logged-in users, consider wrapping contact in `client-unified-
page` for consistency, or document that Contact is intentionally a hybrid page.
---
### 2.6 `viewinvoice.tpl`
**Problems:**
- **Hardcoded "From" block:** "Venom Solutions" and "support@venom-solutions.com" – sh
ould use `{$companyname}` and `{$companyemail}`.
- **Announcements URL:** `announcements.php/view/{$item.id}` – verify WHMCS routing (m
ay be `announcements.php?id=` or similar).
---
### 2.7 `supportticketsubmit.tpl`
**Problems:**
- **Form action:** Uses `supporttickets.php?action=open`. WHMCS may use `submitticket.
php` for the submit page – verify which file handles the POST.
- **"Client Dashboard" link:** Uses "Client Dashboard" instead of `{$LANG.clientareada
shboard}` or similar for i18n.
---
### 2.8 `supportticketslist.tpl`
**Problems:**
- **Open ticket link:** Uses `supporttickets.php?action=open`. Some setups use `submit
ticket.php` – ensure both work or standardize.
- **Ticket link:** Uses `viewticket.php?tid=` – verify WHMCS uses `tid` or `id`.
---
### 2.9 `clientareahome.tpl` (Dashboard)
**Problems:**
- **Announcements URL:** `announcements.php/view/{$item.id}` – confirm correct URL for
mat.
- **Dashboard layout:** Uses custom `client-dashboard-page` layout (no sidebar) – diff
erent from `client-unified-page`. This is intentional for dashboard but creates two la
yout patterns: dashboard vs. other pages.
---
## 3. Style & UX Inconsistencies
### 3.1 Layout Patterns
| Pattern | Used In | Notes |
|---------|---------|-------|
| `client-dashboard-page` | clientareahome | No sidebar, custom grid |
| `client-unified-page` | Most other pages | Sidebar + main |
| `contact-page` | contact | No sidebar, centered form |
**Recommendation:** Document when to use each. Dashboard can stay unique; Contact coul
d optionally use `client-unified-page` when logged in.
---
### 3.2 Status Badge Styling
Status badges are defined locally in multiple templates with slight variations:
- `clientareahome.tpl`: `.status-badge.active`, `.suspended`, `.terminated`
- `clientareaproducts.tpl`: `.status-badge.active`, `.suspended`, `.expired`, `.termin
ated`
- `clientareainvoices.tpl`: `.status-badge.Paid`, `.Unpaid`, etc.
- `viewinvoice.tpl`: Similar
- `clientarearenewals.tpl`: `.status-badge.Pending`, `.Paid`
- `viewticket.tpl`: Different badge set
**Recommendation:** Move common status-badge styles to `venom-main.css` and reuse. Ens
ure consistent colors (e.g. green=active/paid, yellow=pending/suspended, red=terminate
d/expired).
---
### 3.3 Empty State Styling
Empty states vary:
- Some use `.empty-state` with SVG + h2 + p + CTA
- Some use `.empty-inline` for minimal text
- Padding and structure differ
**Recommendation:** Create a shared `.empty-state` component in CSS and use it consist
ently.
---
### 3.4 Form Styling
Forms use different structures:
- `clientareadetails.tpl`: `.form-section`, `.form-row`, `.form-group`
- `clientareachangepw.tpl`: `.password-form`, `.form-row`, `.form-group`
- `supportticketsubmit.tpl`: `.form-row`, `.form-group`
- `clientareacreditcard.tpl`: `.form-row`, `.form-group`
Input styling is mostly consistent but could be centralized in `venom-main.css` for `.
form-group`, `.form-row`, etc.
---
## 4. Sidebar Usage
The `includes/sidebar.tpl` exists but is **not used** in venom-solutions client area p
ages. Instead, each page has its own `client-unified-side` with custom "Quick Actions"
 and context cards. This is fine for customization but means:
- Sidebar content is duplicated across templates
- WHMCS sidebar menu (from `PrimarySidebar` hook) is not shown
**Recommendation:** Either integrate `{include file="$template/includes/sidebar.tpl"}`
 for WHMCS-driven sidebar, or keep custom sidebars but ensure they stay consistent.
---
## 5. Header Menu Gaps
The header links to:
- **Affiliates** (`affiliates.php`) – no venom-solutions template
- **Announcements** (`announcements.php`) – no venom-solutions template
- **Knowledgebase** (`knowledgebase.php`) – no venom-solutions template
Users clicking these see a different theme.
---
## 6. Recommendations Summary
### Immediate (High Impact)
1. **Create missing high-traffic templates:** `affiliates.tpl`, `announcements.tpl`, `
knowledgebase.tpl`, `knowledgebasearticle.tpl`, `downloads.tpl`, `clientareadomains.tp
l`, `clientareasecurity.tpl`, `viewquote.tpl`.
2. **Fix hardcoded values** in `clientareaproductdetails.tpl`, `viewinvoice.tpl`, `con
tact.tpl` (company name, email, URLs).
3. **Fix clientareaaddfunds.tpl** to use WHMCS gateways and currency.
4. **Review clientareacreditcard.tpl** for PCI/tokenization compliance.
### Medium Term
5. **Unify status badge styles** in `venom-main.css`.
6. **Implement or remove** filter tabs in `clientareaproducts.tpl`.
7. **Standardize empty states** across pages.
8. **Add contact.tpl** to `client-unified-page` when user is logged in (optional).
### Lower Priority
9. Add remaining missing templates (domain management, user management, SSL config, et
c.) as needed.
10. Consider integrating WHMCS sidebar or documenting the custom sidebar approach.
---
## 7. Page-by-Page Quick Reference
| Page | Template | Status | Notes |
|------|----------|--------|-------|
| Dashboard | clientareahome.tpl | ✅ Good | Custom layout, no sidebar |
| My Services | clientareaproducts.tpl | ⚠ Issues | Filter tabs non-functional |
| Service Details | clientareaproductdetails.tpl | ⚠ Issues | Hardcoded credentials |
| Renewals | clientarearenewals.tpl | ✅ Good | |
| Invoices | clientareainvoices.tpl | ✅ Good | |
| View Invoice | viewinvoice.tpl | ⚠ Minor | Hardcoded company info |
| Add Funds | clientareaaddfunds.tpl | ⚠ Issues | Hardcoded gateways |
| Payment Methods | clientareacreditcard.tpl | ⚠ Issues | Raw card input |
| Profile | clientareadetails.tpl | ✅ Good | |
| Change Password | clientareachangepw.tpl | ✅ Good | |
| Upgrade | upgrade.tpl | ✅ Good | |
| Support Tickets | supportticketslist.tpl | ✅ Good | |
| Submit Ticket | supportticketsubmit.tpl | ✅ Good | Verify form action |
| View Ticket | viewticket.tpl | ✅ Good | |
| Contact | contact.tpl | ⚠ Minor | Different layout, hardcoded email |
| Domains | — | ❌ Missing | |
| Security | — | ❌ Missing | |
| Affiliates | — | ❌ Missing | |
| Announcements | — | ❌ Missing | |
| Knowledgebase | — | ❌ Missing | |
| Downloads | — | ❌ Missing | |
| Quotes | — | ❌ Missing | |
---
*End of audit report.*

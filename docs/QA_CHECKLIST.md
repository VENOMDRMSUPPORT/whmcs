# QA Checklist — WHMCS Stabilization Pack

Scope: WHMCS only. No third-party panel changes.

---

## UI Gate — Fix Pack (2026-02-21)

Verify all items below pass before considering the UI Fix Pack merged to production.

### A. Public Homepage
- [ ] `GET /` returns HTTP 302 redirect to `/landing.php`
- [ ] `GET /index.php` returns HTTP 302 redirect to `/landing.php`
- [ ] `/landing.php` loads without PHP errors
- [ ] Hero headline reads "Streaming Infrastructure Management Software"
- [ ] "What You Receive" section is visible with 4 tiles: Portal URL, License Key, Username & Password, Load Balancer
- [ ] "No content included" disclaimer is visible in the "What You Receive" section
- [ ] CTA "Start 7-Day Demo — $50" links to `/cart.php?a=add&pid=3`
- [ ] CTA "Buy Main License — $100/mo" links to `/cart.php?a=add&pid=1`
- [ ] Pricing cards show: Demo $50 one-time / Main $100/mo with billing cycle table
- [ ] FAQ contains at least 6 entries including "Software Only / No Content" and portal availability
- [ ] Footer links: Terms of Service, Privacy Policy, Refund Policy, Acceptable Use
- [ ] No mention of IPTV anywhere on the page

### B. Logged-in Client Home
- [ ] `GET /clientarea.php` (logged in) renders without errors
- [ ] Client home shows exactly 4 tiles: Licenses, Support Tickets, Invoices, Knowledgebase
- [ ] No "Network Status" tile visible
- [ ] No "Downloads" tile visible
- [ ] No "Domains" tile visible
- [ ] KB search bar is present below the tiles

### C. Store Page
- [ ] `GET /cart.php?gid=1` or `/cart.php` shows the Licenses product group
- [ ] Only 2 products visible: Demo License (pid=3) and Main Server License (pid=1)
- [ ] No domain registration or transfer options present

### Verification URLs
| Page | URL | Expected |
|------|-----|----------|
| Guest homepage | `http://venom-drm.test/` | Redirects to `/landing.php` |
| Landing page | `http://venom-drm.test/landing.php` | Product landing, dark theme |
| Client area | `http://venom-drm.test/clientarea.php` | WHMCS client area (login or home) |
| Store | `http://venom-drm.test/cart.php?gid=1` | Licenses product group |

---

## Task #5 — WHMCS De-Hosting Cleanup Verification

### Branding + Global UI
- [ ] Company name displays as "VENOM Solutions" throughout client area
- [ ] Navigation shows only: Home, Pricing (Store), Knowledgebase, Support, Client Area
- [ ] Domains menu is hidden/removed
- [ ] Affiliates menu is hidden/removed
- [ ] Network Status menu is hidden/removed
- [ ] Downloads menu is hidden/removed
- [ ] "Services" renamed to "Licenses" in navigation
- [ ] Footer includes links to: Terms, Privacy, Refund Policy, Acceptable Use
- [ ] Footer includes "Software Only · No Content Included" disclaimer

### Order Flow Simplification
- [ ] Store shows only "Licenses" product group
- [ ] Only 2 products visible: Demo License (pid=3) and Main License (pid=1)
- [ ] No domain registration/transfer options appear during checkout
- [ ] Product descriptions are accurate:
  - Main: $100/mo includes 1 free Load Balancer; additional LBs $10/mo each
  - Demo: $50 one-time, valid 7 days, upgrade available

### Legal/Trust Pages
- [ ] /terms-of-service.php loads and displays Terms of Service
- [ ] /privacy-policy.php loads and displays Privacy Policy
- [ ] /refund-policy.php loads and displays Refund Policy
- [ ] /acceptable-use.php loads and displays Acceptable Use Policy
- [ ] All legal pages use consistent WHMCS template styling
- [ ] Footer links to all legal pages work correctly

### Client Area Home (Portal)
- [ ] Portal home shows only: Licenses, Support Tickets, Invoices, Knowledgebase tiles
- [ ] Domain-related widgets are removed
- [ ] "My Services" displays as "My Licenses"
- [ ] No Network Status or Downloads widgets appear

### Landing Page Integration
- [ ] /landing.php loads correctly
- [ ] Landing page has consistent dark theme with WHMCS
- [ ] CTA "Start Demo" links to /cart.php?a=add&pid=3
- [ ] CTA "Buy Main License" links to /cart.php?a=add&pid=1
- [ ] Trust content blocks are present (Software Only, Abuse Policy, Independent Portal)
- [ ] Footer includes legal page links
- [ ] Footer includes software-only disclaimer

---

## Functional Checklist

- [ ] Demo purchase (`pid=3`) sets `nextduedate = activation/regdate + 7 days`
- [ ] Demo expires -> service becomes `Suspended` via `DailyCronJob` hook
- [ ] Main purchase (`pid=1`) Monthly total = `$100`
- [ ] Main + `3` Additional LBs total = `$130/month`
- [ ] Billing cycles: Quarterly = `285`, Semi-Annually = `540`, Annually = `1020`
- [ ] Upgrade Demo (`pid=3`) -> Main (`pid=1`) completes without errors (invoice + service state)

## Cron & Hook Verification Checklist

- [ ] WHMCS cron is configured
- [ ] WHMCS cron runs successfully
- [ ] `DailyCronJob` writes log with timestamp and demo evaluation count
- [ ] Demo expiry warning (48h) sends once per eligible service

## Email Templates Checklist

- [ ] Demo Purchase Confirmation (`pid=3`)
- [ ] Demo Expiry Warning (48h before `nextduedate`)
- [ ] Main Welcome Email (`pid=1`)
- [ ] Payment Received / Invoice Paid confirmation

## Email Delivery Verification (Task #2)

- [ ] Email transport configured and test email delivered successfully
- [ ] Demo Expiry Warning email delivered via cron for a qualifying service

## Stripe Integration Verification (Task #3)

### Gateway Setup
- [ ] Stripe gateway enabled in WHMCS
- [ ] Stripe configured in TEST mode
- [ ] Test API credentials (publishable key, secret key) configured
- [ ] Webhook signing secret configured
- [ ] Store Pay Method enabled for tokenization

### Stripe Checkout Success
- [ ] New purchase (pid=1) with Stripe test card `4242424242424242` completes
- [ ] Invoice status = `Paid`
- [ ] Service status = `Active`
- [ ] Client has saved payment method token in `tblpay_methods`
- [ ] Activity Log shows successful Stripe payment

### Payment Method Stored
- [ ] `tblpay_methods` contains entry for client after checkout
- [ ] Payment method shows correct card last four digits
- [ ] Payment method gateway = `stripe`

### Auto-Renewal Success
- [ ] Service `nextduedate` set to today triggers invoice generation
- [ ] Cron runs and attempts auto-charge via stored payment method
- [ ] Renewal invoice status = `Paid` after cron
- [ ] Service `nextduedate` advanced by billing cycle
- [ ] Activity Log shows auto-charge success

### Failed Renewal Handling
- [ ] Test with failing card `4000000000000002` or simulated failure
- [ ] Invoice remains `Unpaid` after failed charge attempt
- [ ] Retry policy executes per WHMCS automation settings
- [ ] Service suspension triggers after grace period (3 days in DEV)
- [ ] Activity Log shows payment failure entry

## 2Checkout (Verifone) Integration Verification (Task #4)

### Gateway Setup
- [ ] 2Checkout gateway enabled in WHMCS (gateway = 'tco')
- [ ] 2Checkout configured in TEST mode
- [ ] Sandbox account number configured
- [ ] Secret word configured (matches 2Checkout dashboard)
- [ ] Checkout method selected (Standard/Inline)

### Tunnel Setup for IPN
- [ ] Cloudflared or ngrok tunnel running
- [ ] Public tunnel URL obtained and documented
- [ ] IPN URL configured in 2Checkout sandbox dashboard
- [ ] IPN URL format: `{TUNNEL_URL}/modules/gateways/callback/tco.php`

### 2Checkout Checkout Success
- [ ] New purchase (pid=1) with 2Checkout test card completes
- [ ] Redirect to 2Checkout hosted page works (Standard mode)
- [ ] Redirect back to WHMCS after payment works
- [ ] Invoice status = `Paid`
- [ ] Service status = `Active`
- [ ] Activity Log shows successful 2Checkout payment
- [ ] Transaction record exists in `tblaccounts` with gateway='tco'

### Recurring Payment Handling
- [ ] 2Checkout subscription created for recurring product
- [ ] IPN callback received for recurring installment success
- [ ] Renewal invoice status updated to `Paid` after IPN
- [ ] Service `nextduedate` advanced by billing cycle
- [ ] Activity Log shows renewal payment success

### Failed Payment Handling
- [ ] Test with failing card or simulated failed IPN
- [ ] Invoice remains `Unpaid` after failed charge attempt
- [ ] Service suspension triggers after grace period (3 days in DEV)
- [ ] Activity Log shows payment failure entry

### IPN Callback Evidence
- [ ] IPN received logged in WHMCS Activity Log
- [ ] Transaction ID from 2Checkout recorded in `tblaccounts.transid`
- [ ] Payment amount matches invoice total

## Evidence Collection

- [ ] SQL output for cron last run and activity log hook execution captured
- [ ] WHMCS Activity Log evidence captured for email send success
- [ ] SMTP/MTA capture evidence stored (mail log or caught message output)
- [ ] Test send results captured for all required templates
- [ ] Stripe payment activity log IDs captured for test transactions
- [ ] DB evidence for invoice status and gateway transaction records captured
- [ ] 2Checkout payment activity log IDs captured for test transactions
- [ ] Tunnel URL documented and IPN callback evidence captured
- [ ] TCO gateway transaction records from `tblaccounts` captured

---

## Login/Reset Regression Re-Audit (2026-02-22)

### Scope
- [x] `templates/twenty-one/login.tpl` has `rememberme` checkbox inside POST form
- [x] `templates/twenty-one/login.tpl` uses native captcha include with login form mapping
- [x] `templates/twenty-one/password-reset-email-prompt.tpl` uses native captcha include with reset form mapping

### Post-Fix Audit Table
| Check | Result | Evidence |
|---|---|---|
| Remember Me present and posted as `rememberme` | PASS | Source: `templates/twenty-one/login.tpl` + rendered HTML grep (shows `name="rememberme"`) |
| Login captcha visible when enabled | PASS | Screenshot: `audit/login-captcha-visible.png`; rendered HTML includes `#default-captcha-domainchecker` |
| Reset captcha visible when enabled | PASS | Screenshot: `audit/reset-captcha-visible.png`; rendered HTML includes `#default-captcha-domainchecker` |
| Successful login redirect chain | PASS | `POST /index.php?rp=/login` -> `302 Location: clientarea.php`; follow-up `GET /clientarea.php` -> `200` |
| Successful login Activity Log ID | FAIL (not emitted in this environment) | No new `tblactivitylog` row created by successful login flow |
| Captcha failure validation event log ID | FAIL (not emitted in this environment) | Captcha mismatch validated on contact flow UI; no `tblactivitylog` row emitted for captcha mismatch |

### Evidence IDs / Artifacts
- Activity log (mail failure during reset request): IDs `421`, `422`, `423`, `424`
- Login success transport evidence: `/tmp/venom_test_headers.txt` and `/tmp/venom_login_resp_headers.txt`
- Captcha mismatch UI evidence: `/tmp/contact_resp.html` contains: `The characters you entered didn't match the image shown. Please try again.`

### CAPTCHA UI Cleanup (2026-02-22)
- [x] Login captcha wrapped in scoped block container (`.venom-captcha-block`) while keeping native include.
- [x] Reset captcha wrapped in scoped block container (`.venom-captcha-block`) while keeping native include.
- [x] Scoped CSS overrides added only under `.venom-captcha-block` (no global captcha override).
- [x] Desktop layout normalized to aligned two-column captcha row (image + input).
- [x] Mobile layout stacks captcha image/input under 480px.
- [x] Form invariants preserved:
  - Login action/method unchanged (`POST` to `/index.php?rp=/login`)
  - Reset action/method unchanged (`POST` to `/index.php?rp=/password/reset`)
  - Token fields unchanged
  - Field names unchanged: `username`, `password`, `rememberme`, `email`, `action=reset`

### CAPTCHA UI Artifacts
- Login themed screenshot: `audit/login-captcha-themed-after.png`
- Reset themed screenshot: `audit/reset-captcha-themed-after.png`

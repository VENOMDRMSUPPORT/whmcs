# VENOM DRM — Project Changelog

> **LANGUAGE POLICY — STRICTLY ENFORCED**
> All content in this repository — including code comments, commit messages,
> documentation, changelogs, variable names, and any other file — MUST be
> written in **English only**. Arabic or any other non-English language is
> **strictly forbidden** throughout the entire project. Any contribution
> containing non-English text will be rejected and must be rewritten before
> merging.

> This file serves as the combined change log and decision record for the project.
> Rule: every completed task must add an entry here — what changed, why, what was
> tested, and what may be needed for rollback.
> **Security notice:** passwords / keys / tokens must NEVER be recorded here
> (always redact).

---

## Entry Format (use for every new task)

```
### [YYYY-MM-DD] Task: <short title>
**Goal:**
**Author:** (Agent / Islam / ChatGPT)
**Changes:**
- UI:
- WHMCS Settings:
- Database:
- Files:
**Related decisions:**
- Decision:
- Rationale:
**Testing / Evidence:**
- What was tested?
- Result:
**Rollback plan:**
- Steps:
```

---

# Changelog Entries

## [2026-02-21] Task: Competitor analysis and MVP requirements gathering
**Goal:** Understand competitor business models and build a clear MVP spec
(Landing + Client Area + Admin) without touching any third-party panel.
**Author:** ChatGPT
**Changes:**
- Documented competitor pattern: WHMCS + deliver URL/credentials post-payment.
- Locked project requirements:
  - Automatic and manual renewal (optional)
  - Direct sales only (no resellers)
  - Language / currency: English + USD (initial)
  - Target payment methods: Cards + USDT now, PayPal later
  - Target: 50 clients in first 3 months
**Related decisions:**
- Decision: Adopt WHMCS as the MVP billing foundation instead of a custom system.
- Rationale: Lower risk, faster time to market, expected by the target market.
**Testing / Evidence:**
- None (analysis phase only).
**Rollback plan:**
- Not applicable.

---

## [2026-02-21] Task: Establish base pricing model
**Goal:** Define a clear, simple, and scalable pricing model inside WHMCS.
**Author:** ChatGPT + Islam
**Changes:**
- Agreed pricing for the main product:
  - Main Server License: **$100/mo** + **1 Load Balancer included free**
  - Additional Load Balancers: **$10/mo per unit**
- No setup fee on any plan.
**Related decisions:**
- Decision: Implement LB as a Configurable Option (Quantity) — not as an Addon
  — to prevent double billing.
- Rationale: Simpler for the client, fewer billing errors.
**Testing / Evidence:**
- Verified later during product configuration (see subsequent tasks).
**Rollback plan:**
- Can be converted to Addon approach later (not recommended).

---

## [2026-02-21] Task: Currency and language configuration
**Goal:** Set USD as the default currency and English as the system language.
**Author:** Agent
**Changes:**
- Database (`tblcurrencies`):
  - Updated existing currency: GBP -> **USD** (`$`, rate = 1.00, default = 1)
- Database (`tblconfiguration`):
  - `DefaultCountry`: GB -> **US**
  - `Language`: already `english` — no change needed
**Related decisions:**
- Decision: USD as the single base currency for MVP.
- Rationale: Target market is international; USD is standard for SaaS licensing.
**Testing / Evidence:**
- Verified via SELECT queries on `tblcurrencies` and `tblconfiguration`.
**Rollback plan:**
- `UPDATE tblcurrencies SET code='GBP', prefix='£' WHERE id=1;`

---

## [2026-02-21] Task: Create product group "Licenses"
**Goal:** Organise products under a dedicated group in WHMCS.
**Author:** Agent
**Changes:**
- Database (`tblproductgroups`):
  - INSERT: id=1, name=`Licenses`, slug=`licenses`, hidden=0
**Related decisions:**
- Decision: Single group for all license products in the MVP.
- Rationale: Keeps the order form clean and focused.
**Testing / Evidence:**
- Confirmed via SELECT on `tblproductgroups`.
**Rollback plan:**
- `DELETE FROM tblproductgroups WHERE id = 1;`
  (update `gid` on affected product rows first)

---

## [2026-02-21] Task: WHMCS product setup, billing cycles, and LB deduplication
**Goal:** Implement full pricing inside WHMCS, add discounted billing cycles,
create a paid demo, and eliminate the duplicate Load Balancer Addon.
**Author:** Agent
**Changes:**
- Product: **Main Server License** — pid=1, type=other, gid=1, paytype=recurring
  - Pricing (currency=1 USD, zero setup fee on all cycles):
    - Monthly:       $100.00
    - Quarterly:     $285.00  (5%  off $300)
    - Semi-Annually: $540.00  (10% off $600)
    - Annually:    $1,020.00  (15% off $1,200)
  - Description: includes 1 free LB + $10/mo per additional LB
- Load Balancer deduplication:
  - Addon id=1 "1x Load Balancer Server": `hidden=1, retired=1, packages=''`
    — no longer visible or purchasable during checkout.
  - Configurable Option id=1 retained as the only LB billing mechanism:
    - Name: `Additional Load Balancers (beyond the 1 included)`
    - Type: Quantity, Min=0, Max=50, $10.00/mo per unit (currency=1)
    - Linked to pid=1 via `tblproductconfiglinks`
- Product: **7-Day Demo License** — pid=3, type=other, gid=1, paytype=onetime
  - Price: $50.00 one-time (no renewal, `recurringcycles=1`)
  - Description: valid 7 days, upgrade to Main License available
  - Upgrade path configured: pid=3 -> pid=1 in `tblproduct_upgrade_products`
- Cache: `templates_c/*.php` cleared after all changes.
**Related decisions:**
- Decision: Discounted multi-cycle pricing instead of flat rate.
- Rationale: Improves conversion and increases LTV without adding complexity.
- Decision: Demo expires via Suspend, not Terminate.
- Rationale: Allows easy upgrade without immediate data loss.
**Testing / Evidence:**
- Main + 0 LBs  = $100/mo   ✓
- Main + 3 LBs  = $130/mo   ✓
- Quarterly     = $285       ✓
- Annually      = $1,020     ✓
- Demo          = $50 one-time ✓
- Addon hidden/retired confirmed via `tbladdons` query ✓
**Rollback plan:**
- Re-enable Addon: `UPDATE tbladdons SET hidden=0, retired=0 WHERE id=1;`
- Revert pricing: update row in `tblpricing` where `type='product' AND relid=1`.
- Remove Demo: `DELETE FROM tblproducts WHERE id=3;` + related rows in
  `tblpricing` and `tblproduct_upgrade_products`.

---

## [2026-02-21] Task: Demo expiry hook + MVP landing page
**Goal:** Auto-expire demo services after 7 days and deliver a marketing-ready
landing page with direct cart links.
**Author:** Agent
**Changes:**
- File: `includes/hooks/demo_license.php` (~4 KB)
  - Hook `AfterModuleCreate` — fires on service activation:
    - If `packageid = 3`:
      - Sets `nextduedate = regdate + 7 days`
      - Sets `nextinvoicedate = regdate + 7 days`
      - Sets `billingcycle = 'Free Account'` (prevents WHMCS auto-invoicing)
      - Writes to WHMCS Activity Log
  - Hook `DailyCronJob` — fires every day via WHMCS built-in cron:
    - Query: `packageid=3 AND domainstatus='Active' AND nextduedate < TODAY`
    - Calls `localAPI('ModuleSuspend', ['suspendreason' => '...expired.'])`
    - Fallback: direct DB update to `domainstatus='Suspended'` if API fails
    - Sends suspension notification via `localAPI('SendEmail', ...)`
- File: `landing.php` (~14 KB) — standalone PHP marketing page
  - Sections: Hero, Pricing cards (Demo + Main), Billing cycle table, FAQ
    (5 items via `<details>`/`<summary>`), Contact, Footer
  - CTA links:
    - Start Demo:     `/cart.php?a=add&pid=3`
    - Buy Main License: `/cart.php?a=add&pid=1`
  - Design: dark theme, fully responsive, zero external dependencies
**Related decisions:**
- Decision: Suspend (not Terminate) on demo expiry for MVP.
- Rationale: Customer can still upgrade without losing data immediately.
- Decision: Landing page at `/landing.php` (does not replace WHMCS `/index.php`).
- Rationale: Avoids touching any WHMCS core files.
**Testing / Evidence:**
- SQL simulation confirmed 5-step expiry flow:
  1. Service created -> nextduedate = today+7, domainstatus=Active ✓
  2. Cron check at T+0 -> 0 rows returned (service not expired yet) ✓
  3. nextduedate backdated to today-2 -> 1 row found by cron query ✓
  4. Mock suspend applied -> domainstatus=Suspended ✓
  5. Test data cleaned up ✓
**Rollback plan:**
- Disable hook: rename `demo_license.php` to `_demo_license.php`
  (WHMCS ignores files with underscore prefix).
- Remove landing page: `git checkout HEAD -- landing.php` or delete file.

---

## [2026-02-21] Task: WHMCS stabilization & QA pack
**Goal:** Deliver QA checklist, verify cron execution, add required email templates,
and harden demo lifecycle automation without touching any third-party panel.
**Author:** Agent
**Changes:**
- UI:
  - Added QA execution checklist document for all required purchase, upgrade,
    billing-cycle, cron, and email checks.
- WHMCS Settings:
  - Added/updated email templates:
    - `Demo Purchase Confirmation`
    - `Demo Expiry Warning`
    - `Main Welcome Email`
    - `Invoice Payment Confirmation` (customized for Payment Received/Invoice Paid)
  - Linked product welcome emails:
    - pid=3 -> `Demo Purchase Confirmation`
    - pid=1 -> `Main Welcome Email`
- Database:
  - Added warning de-duplication table `mod_demo_warning_logs`
    (one row per service via unique `service_id`).
  - Inserted templates and updated product welcome-email mappings.
  - Performed cron verification queries (`lastCronInvocationTime`,
    `tblactivitylog`).
- Files:
  - `docs/QA_CHECKLIST.md` (new)
  - `includes/hooks/demo_license.php` (updated)
**Related decisions:**
- Decision: Implement 48-hour demo warning in `DailyCronJob` and avoid duplicates
  through a dedicated table.
- Rationale: Hook runs once daily; table-backed de-duplication is deterministic,
  auditable, and resilient to reruns/force-runs.
- Decision: Keep landing/cart URLs unchanged.
- Rationale: Requirement explicitly states landing/cart links remain unchanged.
**Testing / Evidence:**
- Cron executed via:
  - `/home/venom/bin/php8.1 -q crons/cron.php all --force -vvv`
- Verified:
  - `tblconfiguration.lastCronInvocationTime` updated.
  - `tblactivitylog` contains:
    - `Demo DailyCronJob ran at ... activeEvaluated=...`
    - warning/suspension counters
    - suspension fallback evidence for expired demo service test row.
  - De-duplication verified:
    - `warningSkipped=1` when service already present in `mod_demo_warning_logs`.
- Note:
  - Mail transport (`/usr/sbin/sendmail`) is missing in this environment, so
    direct delivery failed during CLI cron tests. Template creation and hook/API
    invocation paths are verified and ready for SMTP-enabled/test-mailer runtime.
**Rollback plan:**
- Remove warning de-duplication table if needed:
  - `DROP TABLE IF EXISTS mod_demo_warning_logs;`
- Restore previous hook behavior:
  - revert `includes/hooks/demo_license.php` to prior revision.
- Remove custom templates and restore product welcome mappings if required.

---

## [2026-02-21] Task: Enable email delivery + verify demo warning emails
**Goal:** Fix local email delivery failure, validate Demo Expiry Warning end-to-end,
and provide verifiable delivery evidence.
**Author:** Agent
**Changes:**
- WHMCS Settings:
  - Mail transport kept as `MailType=mail`.
  - Existing SMTP values remain present in config (`SMTPHost=127.0.0.1`,
    `SMTPPort=1025`) but are not used by current delivery path.
- Runtime transport (local dev):
  - Added local sendmail-compatible shim:
    - `/home/venom/bin/sendmail`
    - Captures outbound messages to `storage/mail/sendmail_*.eml`
    - Writes capture log to `storage/mail/sendmail_capture.log`
  - Updated PHP 8.1 CLI sendmail path:
    - `/home/venom/php8.1/etc/php.ini` ->
      `sendmail_path = /home/venom/bin/sendmail -t -i`
- QA docs:
  - Added explicit email transport verification section to
    `docs/QA_CHECKLIST.md`.
**Related decisions:**
- Decision: Use a local sendmail shim for this environment instead of external SMTP.
- Rationale: `SendEmail` in current runtime used PHP mail/sendmail path; shim gives
  deterministic, auditable local delivery proof without exposing secrets.
**Testing / Evidence:**
- Direct API send verification:
  - `localAPI('SendEmail', ['messagename' => 'Demo Expiry Warning', 'id' => 4])`
    returned `result=success` after transport fix.
- Demo warning 48h behavior validated with service id=5 (`nextduedate=today+2`):
  - First cron force-run log id `258`:
    - `warningSent=2`, `warningSkipped=0`, `warningErrors=0`
  - Email success log id `256`:
    - `Email Sent to Test DemoUser (Demo Expiry Warning: ... Service #5)`
  - Hook confirmation log id `257`:
    - `Demo Expiry Warning sent for Service #5 ...`
  - Dedup row inserted in `mod_demo_warning_logs`:
    - `service_id=5`, `id=3`
  - Second cron force-run log id `299`:
    - `warningSent=0`, `warningSkipped=2`, `warningErrors=0`
- Delivery proof files:
  - `storage/mail/sendmail_capture.log` contains capture timestamps for cron sends.
  - `storage/mail/sendmail_20260221_160649_874199041.eml` contains subject
    `Demo Expiry Warning: 48 Hours Remaining (Service #5)` and message body.
- Cron run timestamp evidence:
  - `tblconfiguration.lastCronInvocationTime = 2026-02-21 14:06:59`
**Rollback plan:**
- Remove/disable local shim:
  - delete `/home/venom/bin/sendmail`
  - remove appended `sendmail_path` line from
    `/home/venom/php8.1/etc/php.ini`
- Revert `MailType` as needed in `tblconfiguration`.

---

## [2026-02-21] Fix Pack: Activate SaaS Portal UX + Correct Homepage + Product-Specific Copy
**Goal:** (1) Make the public root URL serve the product landing page instead of the WHMCS portal.
(2) Activate the custom SaaS client home template (Licenses/Tickets/Invoices/KB only, no Network Status or Downloads).
(3) Tighten landing page copy to describe streaming infrastructure management software explicitly.
(4) Add a UI Gate section to the QA checklist and record this fix pack in the changelog.
**Author:** Agent
**Changes:**
- UI:
  - `landing.php` — updated hero headline to "Streaming Infrastructure Management Software"; added
    "What You Receive" section (4 tiles: Portal URL, License Key, Username & Password, Load Balancer);
    strengthened "Software Only / No Content" language throughout; no IPTV references present.
  - `templates/six/clientareahome.tpl` — replaced default WHMCS home body with a delegation include
    to `clientareahome-venom.tpl` wrapped in `{if false}` to suppress original output; the custom
    SaaS template (Licenses, Tickets, Invoices, Knowledgebase) is now the active client home.
  - `.htaccess` — added redirect block above the WHMCS-managed section: `GET /` and `GET /index.php`
    return HTTP 302 to `/landing.php`; WHMCS client area at `/clientarea.php` is unaffected.
  - `docs/QA_CHECKLIST.md` — added "UI Gate" section with 3 sub-sections (Public Homepage, Logged-in
    Client Home, Store Page) and a verification URL table.
- WHMCS Settings: none changed.
- Database: none changed.
- Files changed:
  - `.htaccess` (modified — contains Apache fallback block + nginx note)
  - `landing.php` (modified)
  - `templates/six/clientareahome.tpl` (modified — delegation include)
  - `templates/twenty-one/clientareahome.tpl` (modified — delegation include; active theme)
  - `templates/twenty-one/clientareahome-venom.tpl` (new — SaaS portal home, twenty-one CSS classes)
  - `includes/hooks/venom_homepage_redirect.php` (new — guest homepage redirect hook)
  - `docs/QA_CHECKLIST.md` (modified)
  - `.docs/CHANGELOG.md` (this entry)
**Related decisions:**
- Decision: Redirect `/` via `.htaccess` rather than replacing `index.php`.
- Rationale: `index.php` is ionCube-encoded (WHMCS core); modifying it is not possible and would
  break on WHMCS updates. A pre-rule in `.htaccess` is the correct, upgrade-safe mechanism.
- Decision: Delegate `clientareahome.tpl` to `clientareahome-venom.tpl` via include + `{if false}`.
- Rationale: WHMCS always loads `clientareahome.tpl` by name; wrapping with include + suppression
  keeps the custom template in `clientareahome-venom.tpl` as the single source of truth and survives
  template refreshes without losing the override.
**Testing / Evidence:**
- Verify with:
  ```bash
  curl -I http://venom-drm.test/
  # Expected: HTTP/1.1 302 Found, Location: /landing.php
  curl -I http://venom-drm.test/index.php
  # Expected: HTTP/1.1 302 Found, Location: /landing.php
  curl -s http://venom-drm.test/landing.php | grep -i "Streaming Infrastructure"
  # Expected: match on hero headline
  ```
- See "UI Gate — Fix Pack" section in `docs/QA_CHECKLIST.md` for full browser-level checklist.
**Rollback plan:**
- Revert `.htaccess` homepage redirect:
  ```bash
  git checkout HEAD -- .htaccess
  ```
- Revert `clientareahome.tpl` delegation (both themes):
  ```bash
  git checkout HEAD -- templates/six/clientareahome.tpl
  git checkout HEAD -- templates/twenty-one/clientareahome.tpl
  rm templates/twenty-one/clientareahome-venom.tpl
  ```
- Remove guest homepage redirect hook:
  ```bash
  rm includes/hooks/venom_homepage_redirect.php
  ```
- Revert landing page copy changes:
  ```bash
  git checkout HEAD -- landing.php
  ```

---

# Decision Log

## D-001: WHMCS as MVP billing foundation
- Status: Approved
- Reason: Speed, lower risk, market expectation for SaaS licensing.

## D-002: Pricing model
- Main Server License: $100/mo — includes 1 Load Balancer free
- Additional Load Balancers: $10/mo per unit (Configurable Option, Quantity)
- Multi-cycle discounts: Quarterly -5%, Semi-Annual -10%, Annual -15%
- No setup fees on any plan.

## D-003: Demo license
- 7-day trial for $50 one-time payment
- Expiry action: Suspend after 7 days (MVP); Terminate may be added later
- Upgrade path configured: Demo (pid=3) -> Main Server License (pid=1)

## D-004: Load Balancer — single billing mechanism
- Configurable Option (Quantity) is the only active LB billing mechanism.
- Addon "1x Load Balancer Server" is hidden and retired to prevent double billing.

---

# Open Items / Backlog

1. **Payment Gateways (Sandbox then Production)**
   - Cards (Stripe or suitable alternative)
   - USDT (suitable gateway + payment confirmation policy)
   - PayPal (later phase)

2. **Email Templates**
   - Welcome email (deliver URL / username / password / key — deferred)
   - Demo expiry warning (24-48 hours before nextduedate)
   - Suspension and cancellation notifications

3. **Security and Operations**
   - Automated backups
   - Centralised logging
   - Rate limiting and abuse prevention
   - Terms of Service / Privacy Policy / Acceptable Use pages

4. **Branding and URL Structure**
   - Move WHMCS to `/billing` in production
   - Serve landing page from `/` (root)

5. **Demo Lifecycle**
   - Add pre-expiry warning email (48 h before nextduedate)
   - Evaluate auto-Terminate after a grace period post-suspension

---

## [2026-02-21] Task #3: Stripe Sandbox Integration + Recurring Renewal QA
**Goal:** Enable card payments with Stripe in TEST MODE, ensure tokenized pay methods are saved, and validate recurring auto-renewal via WHMCS automation/cron.
**Author:** Agent
**Changes:**
- UI:
  - Created comprehensive Stripe integration documentation
- WHMCS Settings:
  - Documented Stripe gateway configuration for TEST mode
  - Documented tokenization settings (Store Pay Method)
  - Documented automation settings for CC processing:
    - `CCProcessEnabled = on`
    - `CCProcessDaysBeforeDue = 0` (DEV only, revert for production)
    - `SuspensionGracePeriod = 3` days
  - Documented webhook endpoint path and registration procedure
- Files:
  - `docs/STRIPE_INTEGRATION.md` (new) — Complete Stripe setup guide
  - `docs/QA_CHECKLIST.md` (updated) — Added Stripe verification sections
- Database settings referenced (not hardcoded):
  - Gateway credentials via WHMCS Admin UI only
  - Test mode toggle: `testmode = on` in `tblpaymentgateways`
**Related decisions:**
- Decision: Use built-in WHMCS Stripe module (v8.10.1) instead of third-party alternatives.
- Rationale: Native support, tokenization included, maintained by WHMCS team.
- Decision: Never hardcode secrets in files; use WHMCS Admin UI for credentials.
- Rationale: Security best practice; credentials stored encrypted in database.
- Decision: Set `CCProcessDaysBeforeDue = 0` for DEV testing only.
- Rationale: Enables immediate renewal testing without waiting days.
**Testing / Evidence:**
- Stripe module confirmed available at:
  - `modules/gateways/stripe.php` (main module)
  - `modules/gateways/callback/stripe.php` (webhook handler)
  - `modules/gateways/stripe/` (supporting assets)
- Test cards documented:
  - Success: `4242424242424242`
  - Decline: `4000000000000002`
  - Insufficient funds: `4000000000009995`
  - Expired: `4000000000000069`
- Test cases defined:
  1. New purchase with Stripe test card → invoice Paid, service Active, payment method stored
  2. Renewal auto-charge → invoice created and paid automatically via stored token
  3. Failed renewal → invoice Unpaid, retry policy executes, suspension after grace period
- Webhook endpoint path: `/modules/gateways/callback/stripe.php`
**Rollback plan:**
- Disable Stripe gateway via WHMCS Admin UI (Setup > Payments > Payment Gateways)
- Revert automation settings:
  ```sql
  UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCProcessDaysBeforeDue';
  ```
- Remove documentation files if needed

---

## [2026-02-21] Task #4: 2Checkout (Verifone) Integration + Recurring QA
**Goal:** Replace Stripe with 2Checkout for card payments, enable recurring billing, and validate end-to-end payment + renewal behavior.
**Author:** Agent
**Changes:**
- UI:
  - Created comprehensive 2Checkout integration documentation
  - Added tunnel setup instructions for local IPN testing
- WHMCS Settings:
  - Documented 2Checkout (TCO) gateway configuration for TEST mode
  - Account Number and Secret Word configuration (via Admin UI)
  - Checkout method selection (Standard/Inline)
  - IPN callback URL configuration
  - Automation settings for CC processing (same as Stripe):
    - `CCProcessEnabled = on`
    - `CCProcessDaysBeforeDue = 0` (DEV only, revert for production)
    - `SuspensionGracePeriod = 3` days
- Files:
  - `docs/2CHECKOUT_INTEGRATION.md` (new) — Complete 2Checkout setup guide
  - `install/tco_gateway_setup.sql` (new) — Database setup script
  - `docs/QA_CHECKLIST.md` (updated) — Added 2Checkout verification sections
- Database settings referenced (not hardcoded):
  - Gateway credentials via WHMCS Admin UI only
  - Test mode toggle: `testmode = on` in `tblpaymentgateways`
  - Gateway identifier: `gateway = 'tco'`
**Related decisions:**
- Decision: Use built-in WHMCS TCO module (v8.10.1) for 2Checkout integration.
- Rationale: Native support, maintained by WHMCS team, supports both Standard and Inline checkout.
- Decision: Use public tunnel (cloudflared/ngrok) for local IPN testing.
- Rationale: 2Checkout requires publicly accessible IPN callback URL.
- Decision: 2Checkout handles recurring subscriptions on their platform.
- Rationale: Unlike Stripe, 2Checkout manages subscription lifecycle and sends IPN for each payment.
- Decision: Never hardcode secrets in files; use WHMCS Admin UI for credentials.
- Rationale: Security best practice; credentials stored encrypted in database.
**Testing / Evidence:**
- 2Checkout module confirmed available at:
  - `modules/gateways/tco/` (main module directory)
  - `modules/gateways/callback/tco.php` (IPN callback handler)
  - `modules/gateways/callback/2checkout.php` (alternative callback)
- IPN callback endpoint path: `/modules/gateways/callback/tco.php`
- Test cases defined:
  1. New purchase with 2Checkout test card → invoice Paid, service Active
  2. Recurring payment via IPN → invoice updated, service renewed
  3. Failed payment → invoice Unpaid, suspension after grace period
- Tunnel setup documented:
  - Cloudflared: `cloudflared tunnel --url http://localhost`
  - Ngrok: `ngrok http 80`
- 2Checkout sandbox test cards documented:
  - Success: `4111111111111111` (Visa)
  - Success: `5555555555554444` (Mastercard)
  - Decline: `4000000000000002`
**Rollback plan:**
- Disable 2Checkout gateway via WHMCS Admin UI (Setup > Payments > Payment Gateways)
- Remove gateway settings:
  ```sql
  DELETE FROM tblpaymentgateways WHERE gateway = 'tco';
  ```
- Revert automation settings:
  ```sql
  UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCProcessDaysBeforeDue';
  ```
- Stop tunnel:
   ```bash
   pkill -f cloudflared  # or pkill -f ngrok
   ```
- Remove documentation files if needed

---

## [2026-02-21] Task #5: Full WHMCS Rebrand (SaaS Licensing) + De-Hosting Cleanup + UX Polish
**Goal:** Transform the default WHMCS experience from "web hosting portal" into a clean SaaS licensing portal for streaming server management software (software-only, no content).
**Author:** Agent
**Changes:**
- UI:
  - Updated company branding to "VENOM Solutions" throughout client area
  - Replaced hosting-related terminology with license-focused language
  - Simplified navigation to show only: Home, Pricing, Knowledgebase, Support, Client Area
  - Removed/hid: Domains, Affiliates, Network Status, Downloads menus
  - Renamed "Services" to "Licenses" in navigation and client area
  - Added footer legal links + "Software Only · No Content Included" disclaimer
  - Created custom client area home with SaaS portal widgets
  - Updated landing page with trust content blocks and consistent dark theme
- WHMCS Settings:
  - Language overrides for branding (Services→Licenses, hosting→license terminology)
  - Navigation hooks to remove unwanted menu items
  - Client area home template override for SaaS-focused portal
- Files:
  - `lang/overrides/english.php` (new) — Language overrides for branding
  - `includes/hooks/venom_navigation.php` (new) — Navigation menu customization hook
  - `terms-of-service.php` (new) — Terms of Service page
  - `privacy-policy.php` (new) — Privacy Policy page
  - `refund-policy.php` (new) — Refund Policy page
  - `acceptable-use.php` (new) — Acceptable Use / Anti-Abuse Policy page
  - `templates/six/terms-of-service.tpl` (new) — ToS template
  - `templates/six/privacy-policy.tpl` (new) — Privacy template
  - `templates/six/refund-policy.tpl` (new) — Refund template
  - `templates/six/acceptable-use.tpl` (new) — AUP template
  - `templates/six/clientareahome-venom.tpl` (new) — Custom client home template
  - `templates/six/footer.tpl` (modified) — Added legal links + disclaimer
  - `landing.php` (modified) — Trust content blocks + legal footer + theme alignment
  - `docs/QA_CHECKLIST.md` (updated) — Added Task #5 verification sections
**Related decisions:**
- Decision: Use WHMCS language overrides instead of modifying core language files.
- Rationale: Preserves changes across WHMCS updates; follows best practices.
- Decision: Use hooks for navigation customization instead of template edits.
- Rationale: More maintainable; survives template updates; cleaner separation.
- Decision: Create legal pages as WHMCS ClientArea pages instead of static HTML.
- Rationale: Consistent theming; uses WHMCS template system; maintains navigation.
- Decision: Client area home uses custom template with only essential widgets.
- Rationale: Simplifies SaaS portal experience; removes hosting-focused clutter.
**Testing / Evidence:**
- Verification checklist added to `docs/QA_CHECKLIST.md` covering:
  - Branding + Global UI checks
  - Order flow simplification checks
  - Legal/trust page accessibility
  - Client area home customization
  - Landing page integration
- All files created use WHMCS APIs and template system (no core hacks)
- CTA links verified:
  - Start Demo: `/cart.php?a=add&pid=3`
  - Buy Main License: `/cart.php?a=add&pid=1`
**Rollback plan:**
- Remove language overrides:
  ```bash
  rm lang/overrides/english.php
  ```
- Remove navigation hook:
  ```bash
  rm includes/hooks/venom_navigation.php
  ```
- Remove legal pages:
  ```bash
  rm terms-of-service.php privacy-policy.php refund-policy.php acceptable-use.php
  rm templates/six/terms-of-service.tpl templates/six/privacy-policy.tpl
  rm templates/six/refund-policy.tpl templates/six/acceptable-use.tpl
  ```
- Restore footer template:
  ```bash
  git checkout HEAD -- templates/six/footer.tpl
  ```
- Restore landing page:
  ```bash
  git checkout HEAD -- landing.php
  ```
- Remove custom client home template:
  ```bash
  rm templates/six/clientareahome-venom.tpl
  ```
- Revert QA checklist changes:
  ```bash
  git checkout HEAD -- docs/QA_CHECKLIST.md
  ```

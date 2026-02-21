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

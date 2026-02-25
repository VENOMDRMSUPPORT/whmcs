# Venom Solutions Client Area - Final Implementation Plan v2

> **Scope:** Client Area pages only (post-login experience)
> **Template:** `templates/venom-solutions/`
> **Date:** February 25, 2026
> **Language:** English (all code, comments, commits)
> **Sources:** Merged from antigravity + cursor plans (best of both)

---

## CONSTRAINTS & EXCLUSIONS

### MUST NOT Touch
- Landing page: `index.tpl`
- Authentication pages: `login.tpl`, `register.tpl`, `pwreset.tpl`, `pwresetvalidation.tpl`
- Logo and site name (animated logo must be preserved)
- Existing theme system (light/dark + 5 accents - already implemented)

### WILL NOT Create (Non-Hosting Scope)
- Domain management templates: `clientareadomains.tpl`, `clientareadomaindetails.tpl`, `clientareadomaindns.tpl`, `clientareadomainepp.tpl`, `clientareadomaingetepp.tpl`, `bulkdomainmanagement.tpl`, `domain-pricing.tpl`, `domainchecker.tpl`
- SSL configuration templates: `configuressl-stepone.tpl`, `configuressl-steptwo.tpl`, `configuressl-complete.tpl`, `managessl.tpl`
- Server status: `serverstatus.tpl`

**Note:** The site uses HTTPS normally (`https://venom-drm.test`) - SSL templates are for selling SSL certificates, which is not in scope.

### Key Principles
1. **Preserve** animated logo and branding
2. **Maintain** existing theme system (light/dark + accents)
3. **Use** WHMCS variables instead of hardcoded values
4. **Ensure** localStorage theme settings don't affect landing page
5. **Skip** domain/SSL/server pages (not relevant to project)

---

## TABLE OF CONTENTS

1. [Current State Analysis](#1-current-state-analysis)
2. [Critical Issues Summary](#2-critical-issues-summary)
3. [Phase 0: Foundation & Design System](#3-phase-0-foundation--design-system)
4. [Phase 1: Fix Existing Pages](#4-phase-1-fix-existing-pages)
5. [Phase 2: Layout Unification](#5-phase-2-layout-unification)
6. [Phase 3: Missing High-Priority Pages](#6-phase-3-missing-high-priority-pages)
7. [Phase 4: Account & User Management Pages](#7-phase-4-account--user-management-pages)
8. [Phase 5: Header & Navigation Refinement](#8-phase-5-header--navigation-refinement)
9. [Phase 6: Theme System Hardening](#9-phase-6-theme-system-hardening)
10. [Phase 7: Responsive & Accessibility QA](#10-phase-7-responsive--accessibility-qa)
11. [Phase 8: Documentation & Handoff](#11-phase-8-documentation--handoff)
12. [WHMCS Integration Compliance](#12-whmcs-integration-compliance)
13. [Component Library Reference](#13-component-library-reference)
14. [Definition of Done](#14-definition-of-done)


---

## 1. CURRENT STATE ANALYSIS

### 1.1 Existing Template Inventory (15 files)

| File | Status | Issues | Priority |
|------|--------|--------|----------|
| `clientareahome.tpl` | ✅ Good | 780 lines inline CSS, hardcoded "Client Area" text | Medium |
| `clientareaproducts.tpl` | ⚠️ Broken | Filter tabs non-functional, no pagination | **High** |
| `clientareaproductdetails.tpl` | ⚠️ Critical | Hardcoded credentials, URLs, license key, username | **Critical** |
| `clientarearenewals.tpl` | ✅ Good | Duplicated status styling | Low |
| `clientareainvoices.tpl` | ✅ Good | Duplicated status styling, inline CSS | Low |
| `viewinvoice.tpl` | ⚠️ Issues | Hardcoded company name/email | **High** |
| `clientareaaddfunds.tpl` | ⚠️ Critical | Hardcoded gateways, currency symbol `$` | **Critical** |
| `clientareacreditcard.tpl` | ⚠️ Issues | Raw card input (PCI concern), unverified delete route | **High** |
| `clientareadetails.tpl` | ✅ Good | Duplicated form styling | Low |
| `clientareachangepw.tpl` | ✅ Good | Duplicated form styling | Low |
| `upgrade.tpl` | ✅ Good | None major | Low |
| `supportticketslist.tpl` | ✅ Good | Link format needs verification | Low |
| `supportticketsubmit.tpl` | ✅ Good | Form action unverified, hardcoded text | Low |
| `viewticket.tpl` | ✅ Good | None major | Low |
| `contact.tpl` | ⚠️ Issues | Different layout, hardcoded email | Medium |

### 1.2 Missing Templates (P1 - High Priority)

Falling back to `twenty-one` theme, causing visual inconsistency:

| Template | Linked From | Purpose |
|----------|-------------|---------|
| `clientareasecurity.tpl` | Account menu | 2FA, security questions, login history |
| `clientareaemails.tpl` | Account menu | Email history list |
| `announcements.tpl` | Support menu | Announcements list |
| `viewannouncement.tpl` | Announcements | Single announcement view |
| `knowledgebase.tpl` | Support menu | KB home |
| `knowledgebasecat.tpl` | KB | Category view |
| `knowledgebasearticle.tpl` | KB | Article view |
| `downloads.tpl` | Support menu | Downloads list |
| `downloadscat.tpl` | Downloads | Category view |
| `viewquote.tpl` | Billing | Quote details |
| `clientareaquotes.tpl` | Billing | Quotes list |
| `clientareacancelrequest.tpl` | Services | Cancellation form |
| `affiliates.tpl` | Affiliates | Affiliate dashboard |
| `affiliatessignup.tpl` | Affiliates | Signup form |

### 1.3 Missing Templates (P2 - Medium Priority)

| Template | Purpose |
|----------|---------|
| `account-paymentmethods.tpl` | Payment methods list |
| `account-paymentmethods-manage.tpl` | Manage payment method |
| `account-paymentmethods-billing-contacts.tpl` | Billing contacts |
| `account-contacts-manage.tpl` | Edit contact |
| `account-contacts-new.tpl` | New contact |
| `account-user-management.tpl` | User list (WHMCS 9+) |
| `account-user-permissions.tpl` | User permissions |

### 1.4 Missing Templates (P3 - WHMCS 9+ User Management)

| Template | Purpose |
|----------|---------|
| `user-profile.tpl` | User profile |
| `user-password.tpl` | User password |
| `user-security.tpl` | User security |
| `user-verify-email.tpl` | Email verification |
| `user-switch-account.tpl` | Account switching |
| `user-switch-account-forced.tpl` | Forced account switch |
| `user-invite-accept.tpl` | Accept user invite |

### 1.5 Critical Issues Found Across All Files

1. **3 different layout patterns** - `client-dashboard-page`, `client-unified-page`, `contact-page`
2. **Status badges duplicated** across 6+ templates with inconsistent class names
3. **Inline `<style>` blocks** in almost every template (duplicated CSS, hard to maintain)
4. **Hardcoded values** in 4 critical templates (URLs, company name, email, gateways, currency)
5. **~40 missing templates** falling back to default theme
6. **Theme system incomplete** - CSS variables defined but not consistently used
7. **Non-functional UI elements** - Filter tabs in services list don't work
8. **PCI compliance concern** - Raw credit card input without tokenization check


---

## 2. CRITICAL ISSUES SUMMARY

### 2.1 Hardcoded Values Locations

| File | Line Reference | Hardcoded Value | Should Be |
|------|----------------|-----------------|-----------|
| `clientareaproductdetails.tpl` | Multiple | `https://venom-drm.test/` | `{$service.server}` or module output |
| `clientareaproductdetails.tpl` | License Key | `VNM-{$serviceId}-XXXX-XXXX` | `{$customfields.License_Key}` |
| `clientareaproductdetails.tpl` | Username | `client-{$serviceId}` | `{$service.username}` |
| `clientareaproductdetails.tpl` | Password | `••••••••` (static) | `{$service.password}` |
| `clientareaproductdetails.tpl` | Auto-Renew | "Enabled" (static) | `{if $autorenew}Enabled{else}Disabled{/if}` |
| `viewinvoice.tpl` | From block | "Venom Solutions" | `{$companyname}` |
| `viewinvoice.tpl` | From block | "support@venom-solutions.com" | `{$companyemail}` |
| `clientareaaddfunds.tpl` | Gateway options | PayPal, Card, Crypto | `{foreach $gateways}` |
| `clientareaaddfunds.tpl` | Currency | `$` | `{$currency.prefix}` |
| `contact.tpl` | Email | `support@venom-solutions.com` | `{$companyemail}` |

### 2.2 Non-Functional Elements

| Element | Location | Issue | Fix Required |
|---------|----------|-------|--------------|
| Filter tabs | `clientareaproducts.tpl` | No JavaScript handler | Add click event + `data-status` attributes |
| Theme switcher | `header.tpl` | May not persist correctly | Verify localStorage scope |
| Active states | `header.tpl` | Incomplete page coverage | Add all pages to `currentClientMenu` assignments |


---

## 3. PHASE 0: FOUNDATION & DESIGN SYSTEM

**Duration:** 2-3 days
**Goal:** Create unified component library, eliminate duplication, complete theme system, establish design tokens

---

### 3.1 Design System Setup (🆕 from cursor)

**Files:** `css/venom-main.css`, `css/venom-components.css` (new)

#### 3.1.1 CSS Design Tokens

Add unified spacing, typography, shadow, and radius scales:

```css
/* ============================================================
   DESIGN SYSTEM TOKENS
   ============================================================ */

:root {
    /* Spacing Scale */
    --space-xs: 4px;
    --space-sm: 8px;
    --space-md: 16px;
    --space-lg: 24px;
    --space-xl: 32px;
    --space-2xl: 48px;
    --space-3xl: 64px;

    /* Typography Scale */
    --text-xs: 0.75rem;      /* 12px - captions */
    --text-sm: 0.875rem;     /* 14px - small text */
    --text-base: 1rem;       /* 16px - body */
    --text-lg: 1.125rem;     /* 18px - large body */
    --text-xl: 1.25rem;      /* 20px - h4 */
    --text-2xl: 1.5rem;      /* 24px - h3 */
    --text-3xl: 1.75rem;     /* 28px - h2 */
    --text-4xl: 2.25rem;     /* 36px - h1 */

    /* Font Weights */
    --font-normal: 400;
    --font-medium: 500;
    --font-semibold: 600;
    --font-bold: 700;

    /* Shadow System */
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
    --shadow-glow: 0 0 15px hsla(var(--accent), 0.3);

    /* Border Radius */
    --radius-sm: 6px;
    --radius-md: 8px;
    --radius-lg: 12px;
    --radius-xl: 16px;
    --radius-full: 9999px;

    /* Transitions */
    --transition-fast: 150ms ease;
    --transition-base: 200ms ease;
    --transition-slow: 300ms ease;
}
```

#### 3.1.2 Required CSS Variables (must work in BOTH themes)

```css
/* Must exist and work in both light and dark themes */
--background, --foreground
--card, --card-foreground
--border, --input
--primary, --primary-foreground
--secondary, --secondary-foreground
--accent, --accent-foreground, --accent-light
--muted, --muted-foreground, --muted-light
--success, --success-light
--warning, --warning-light
--danger, --danger-light
--info, --info-light
```

---

### 3.2 Smarty Component Includes (🆕 from cursor)

**Directory:** `templates/venom-solutions/includes/components/` (NEW)

Create reusable Smarty component templates:

- [ ] `includes/components/status-badge.tpl`
- [ ] `includes/components/empty-state.tpl`
- [ ] `includes/components/page-header.tpl`
- [ ] `includes/components/stat-card.tpl`
- [ ] `includes/components/data-table.tpl`
- [ ] `includes/components/pagination.tpl`
- [ ] `includes/components/breadcrumb.tpl`
- [ ] `includes/components/form-section.tpl`
- [ ] `includes/components/modal.tpl`

---

### 3.3 Create Unified CSS Components

**File:** `templates/venom-solutions/css/venom-main.css`

**Action:** Add the following unified component classes at the END of the file (after existing styles):

---

#### Component: Unified Status Badges

**Problem:** Currently duplicated across 6+ templates with inconsistent class names:
- `.active`, `.Active`, `.suspended`, `.Suspended`, `.terminated`, `.Terminated`
- `.Paid`, `.Unpaid`, `.Cancelled`, `.Overdue`, `.Refunded`
- `.Answered`, `.Open`, `.Closed`, `.Customer-Reply`

**Solution:** Add to `venom-main.css`:

```css
/* ============================================================
   UNIFIED STATUS BADGES
   ============================================================ */

.status-badge {
    display: inline-flex;
    align-items: center;
    padding: var(--space-xs) var(--space-md);
    border-radius: var(--radius-lg);
    font-size: var(--text-xs);
    font-weight: var(--font-semibold);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all var(--transition-base);
}

/* Service Status */
.status-badge.active, .status-badge.Active { background: hsl(var(--success-light)); color: hsl(var(--success)); }
.status-badge.suspended, .status-badge.Suspended { background: hsl(var(--warning-light)); color: hsl(var(--warning)); }
.status-badge.pending, .status-badge.Pending { background: hsl(var(--warning-light)); color: hsl(var(--warning)); }
.status-badge.terminated, .status-badge.Terminated,
.status-badge.expired, .status-badge.Expired,
.status-badge.cancelled, .status-badge.Cancelled { background: hsl(var(--danger-light)); color: hsl(var(--danger)); }

/* Invoice Status */
.status-badge.paid, .status-badge.Paid { background: hsl(var(--success-light)); color: hsl(var(--success)); }
.status-badge.unpaid, .status-badge.Unpaid { background: hsl(var(--warning-light)); color: hsl(var(--warning)); }
.status-badge.overdue, .status-badge.Overdue { background: hsl(var(--danger-light)); color: hsl(var(--danger)); }
.status-badge.refunded, .status-badge.Refunded { background: hsl(var(--muted-light)); color: hsl(var(--muted)); }

/* Ticket Status */
.status-badge.open, .status-badge.Open { background: hsl(var(--success-light)); color: hsl(var(--success)); }
.status-badge.answered, .status-badge.Answered { background: hsl(var(--info-light)); color: hsl(var(--info)); }
.status-badge.closed, .status-badge.Closed { background: hsl(var(--muted-light)); color: hsl(var(--muted)); }
.status-badge.customer-reply, .status-badge.Customer-Reply { background: hsl(var(--accent-light)); color: hsl(var(--accent)); }

/* Dark theme overrides */
body.theme-dark .status-badge.active, body.theme-dark .status-badge.Active,
body.theme-dark .status-badge.paid, body.theme-dark .status-badge.Paid {
    background: hsla(var(--success), 0.2); color: hsl(var(--success));
}
body.theme-dark .status-badge.suspended, body.theme-dark .status-badge.Suspended,
body.theme-dark .status-badge.pending, body.theme-dark .status-badge.Pending,
body.theme-dark .status-badge.unpaid, body.theme-dark .status-badge.Unpaid {
    background: hsla(var(--warning), 0.2); color: hsl(var(--warning));
}
body.theme-dark .status-badge.terminated, body.theme-dark .status-badge.Terminated,
body.theme-dark .status-badge.expired, body.theme-dark .status-badge.Expired,
body.theme-dark .status-badge.overdue, body.theme-dark .status-badge.Overdue {
    background: hsla(var(--danger), 0.2); color: hsl(var(--danger));
}
```

---

#### Component: Unified Empty States

```css
/* ============================================================
   UNIFIED EMPTY STATES
   ============================================================ */

.empty-state {
    display: flex; flex-direction: column; align-items: center;
    justify-content: center; padding: var(--space-2xl) var(--space-lg);
    text-align: center; gap: var(--space-md);
}
.empty-state.compact { padding: var(--space-lg) var(--space-md); gap: var(--space-sm); }
.empty-state.inline { display: inline-flex; flex-direction: row; padding: var(--space-sm) var(--space-md); gap: var(--space-sm); }
.empty-state-icon { width: 64px; height: 64px; opacity: 0.5; color: hsl(var(--muted)); }
.empty-state.compact .empty-state-icon { width: 48px; height: 48px; }
.empty-state h2, .empty-state h3, .empty-state h4 { margin: 0; color: hsl(var(--foreground)); }
.empty-state p { margin: 0; max-width: 320px; color: hsl(var(--muted-foreground)); }
.empty-state .btn { margin-top: var(--space-sm); }
```

---

#### Component: Unified Form Components

```css
/* ============================================================
   UNIFIED FORM COMPONENTS
   ============================================================ */

.form-section { margin-bottom: var(--space-xl); }
.form-section:last-child { margin-bottom: 0; }
.form-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: var(--space-md); margin-bottom: var(--space-md); }
.form-row.single { grid-template-columns: 1fr; }
.form-row.half { grid-template-columns: 1fr 1fr; }
.form-row.triple { grid-template-columns: repeat(3, 1fr); }
.form-group { display: flex; flex-direction: column; gap: 6px; }
.form-label { font-weight: var(--font-medium); color: hsl(var(--foreground)); font-size: var(--text-sm); }
.form-label.required::after { content: " *"; color: hsl(var(--danger)); }

.form-control, .form-select, .form-textarea {
    padding: 10px 14px; border: 1px solid hsl(var(--border)); border-radius: var(--radius-md);
    background: hsl(var(--background)); color: hsl(var(--foreground));
    font-size: var(--text-sm); transition: border-color var(--transition-base), box-shadow var(--transition-base);
}
.form-control:focus, .form-select:focus, .form-textarea:focus {
    outline: none; border-color: hsl(var(--accent)); box-shadow: 0 0 0 3px hsla(var(--accent), 0.15);
}
.form-control.is-invalid { border-color: hsl(var(--danger)); }
.form-control.is-valid { border-color: hsl(var(--success)); }
.form-control:disabled { opacity: 0.5; cursor: not-allowed; }
.form-textarea { min-height: 100px; resize: vertical; }
.form-hint { font-size: var(--text-xs); color: hsl(var(--muted-foreground)); margin-top: 4px; }
.form-error { font-size: var(--text-xs); color: hsl(var(--danger)); margin-top: 4px; }

/* Input with icon wrapper */
.input-shell { position: relative; display: flex; align-items: center; }
.input-shell .form-control { padding-left: 40px; }
.input-shell-icon { position: absolute; left: 12px; color: hsl(var(--muted)); pointer-events: none; }
.input-shell .form-control:focus + .input-shell-icon { color: hsl(var(--accent)); }
```

---

#### Component: Unified Page Header & Breadcrumb

```css
/* ============================================================
   UNIFIED PAGE HEADER & BREADCRUMB
   ============================================================ */

.page-header { margin-bottom: var(--space-lg); }
.page-header-title { margin: 0 0 4px 0; font-size: var(--text-3xl); font-weight: var(--font-bold); color: hsl(var(--foreground)); }
.page-header-subtitle { margin: 0; font-size: var(--text-sm); color: hsl(var(--muted-foreground)); }
.page-header-actions { display: flex; gap: var(--space-sm); margin-top: var(--space-md); }

.page-breadcrumb { display: flex; align-items: center; gap: var(--space-sm); padding: 12px 0; margin-bottom: var(--space-md); font-size: var(--text-sm); }
.breadcrumb-item { color: hsl(var(--muted-foreground)); }
.breadcrumb-item a { color: hsl(var(--accent)); text-decoration: none; }
.breadcrumb-item a:hover { text-decoration: underline; }
.breadcrumb-separator { color: hsl(var(--muted)); }
.breadcrumb-item.current { color: hsl(var(--foreground)); }
```

---

#### Component: Unified Table Styles

```css
/* ============================================================
   UNIFIED TABLE STYLES
   ============================================================ */

.venom-table { width: 100%; border-collapse: collapse; background: hsl(var(--card)); border-radius: var(--radius-lg); overflow: hidden; }
.venom-table thead { background: hsl(var(--muted-light)); }
.venom-table th { padding: 12px 16px; text-align: left; font-weight: var(--font-semibold); font-size: var(--text-xs); text-transform: uppercase; letter-spacing: 0.5px; color: hsl(var(--muted-foreground)); border-bottom: 1px solid hsl(var(--border)); }
.venom-table td { padding: 14px 16px; border-bottom: 1px solid hsl(var(--border)); }
.venom-table tbody tr:last-child td { border-bottom: none; }
.venom-table tbody tr:hover { background: hsl(var(--muted-light)); }
.venom-table_wrapper { overflow-x: auto; }

@media (max-width: 760px) {
    .venom-table_wrapper { border-radius: var(--radius-lg); border: 1px solid hsl(var(--border)); }
    .venom-table th, .venom-table td { padding: 10px 12px; font-size: 0.8125rem; }
}
```

---

#### Component: Unified Card Patterns

```css
/* ============================================================
   UNIFIED CARD PATTERNS
   ============================================================ */

.info-card { background: hsl(var(--card)); border: 1px solid hsl(var(--border)); border-radius: var(--radius-lg); padding: 20px; }
.info-card-title { margin: 0 0 12px 0; font-size: var(--text-base); font-weight: var(--font-semibold); color: hsl(var(--foreground)); }
.info-card-content { color: hsl(var(--muted-foreground)); }

.stat-card { background: hsl(var(--card)); border: 1px solid hsl(var(--border)); border-radius: var(--radius-lg); padding: 20px; display: flex; flex-direction: column; gap: var(--space-sm); }
.stat-card-label { font-size: var(--text-xs); text-transform: uppercase; letter-spacing: 0.5px; color: hsl(var(--muted-foreground)); }
.stat-card-value { font-size: var(--text-3xl); font-weight: var(--font-bold); color: hsl(var(--foreground)); }
.stat-card-change { font-size: var(--text-xs); }
.stat-card-change.positive { color: hsl(var(--success)); }
.stat-card-change.negative { color: hsl(var(--danger)); }

.detail-card { background: hsl(var(--card)); border: 1px solid hsl(var(--border)); border-radius: var(--radius-lg); overflow: hidden; }
.detail-card-header { padding: 16px 20px; border-bottom: 1px solid hsl(var(--border)); display: flex; align-items: center; justify-content: space-between; }
.detail-card-title { margin: 0; font-size: var(--text-base); font-weight: var(--font-semibold); color: hsl(var(--foreground)); }
.detail-card-body { padding: 20px; }
.detail-card-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid hsl(var(--border)); }
.detail-card-row:last-child { border-bottom: none; }
.detail-card-label { color: hsl(var(--muted-foreground)); }
.detail-card-value { font-weight: var(--font-medium); color: hsl(var(--foreground)); }
```

---

#### Component: Unified Pagination

```css
/* ============================================================
   UNIFIED PAGINATION
   ============================================================ */

.venom-pagination { display: flex; align-items: center; justify-content: center; gap: var(--space-sm); margin-top: var(--space-lg); }
.pagination-item { display: flex; align-items: center; justify-content: center; min-width: 36px; height: 36px; padding: 0 10px; border: 1px solid hsl(var(--border)); border-radius: var(--radius-md); background: hsl(var(--card)); color: hsl(var(--foreground)); font-size: var(--text-sm); text-decoration: none; transition: all var(--transition-base); }
.pagination-item:hover { border-color: hsl(var(--accent)); color: hsl(var(--accent)); }
.pagination-item.active { background: hsl(var(--accent)); border-color: hsl(var(--accent)); color: white; }
.pagination-item.disabled { opacity: 0.5; pointer-events: none; }
```


---

### 3.4 Theme System Completion

**File:** `templates/venom-solutions/js/venom-main.js`

**Action:** Verify existing code includes anti-FOUC script:

```javascript
// Theme initialization - must run immediately to prevent FOUC
(function() {
    'use strict';
    if (document.body.classList.contains('client-area')) {
        const theme = localStorage.getItem('venom-theme') || 'light';
        const accent = localStorage.getItem('venom-accent') || 'blue';
        document.body.classList.add('theme-' + theme, 'accent-' + accent);
        document.documentElement.style.setProperty('--theme-transition', 'none');
    }
})();
```

**File:** `templates/venom-solutions/header.tpl` — Add early theme script in `<head>`:

```smarty
<script>
(function() {
    if (document.body.classList.contains('client-area')) {
        var theme = localStorage.getItem('venom-theme') || 'light';
        var accent = localStorage.getItem('venom-accent') || 'blue';
        document.body.classList.add('theme-' + theme, 'accent-' + accent);
    }
})();
</script>
```

**Add smooth theme transitions:**
```css
body.client-area *, body.client-area *::before, body.client-area *::after {
    transition-property: background, color, border-color, box-shadow;
    transition-duration: 0.3s;
    transition-timing-function: ease;
}
```

---

### 3.5 Extract Inline CSS from Templates

**Action:** Move ALL inline `<style>` blocks to `venom-main.css`

**Files affected (14 templates):**
1. `clientareahome.tpl` - ~780 lines of inline CSS
2. `clientareaproducts.tpl` - filter tabs styles
3. `clientareaproductdetails.tpl` - credential display styles
4. `clientareainvoices.tpl` - table styles
5. `viewinvoice.tpl` - invoice print styles
6. `clientareaaddfunds.tpl` - payment method cards
7. `clientareacreditcard.tpl` - form styles
8. `clientareadetails.tpl` - profile form styles
9. `clientareachangepw.tpl` - password form styles
10. `upgrade.tpl` - upgrade options
11. `supportticketslist.tpl` - ticket list styles
12. `supportticketsubmit.tpl` - ticket form styles
13. `viewticket.tpl` - ticket thread styles
14. `contact.tpl` - contact form styles

**Process for each file:**
1. Copy content between `<style>` and `</style>`
2. Paste into `venom-main.css` with descriptive section comment
3. Remove `<style>` block from template
4. Verify functionality preserved

## 4. PHASE 1: FIX EXISTING PAGES

**Duration:** 3-4 days
**Goal:** Fix all hardcoded values, broken UI elements, WHMCS compliance issues

---

### 4.1 Fix `clientareaproductdetails.tpl` - CRITICAL

**File:** `templates/venom-solutions/clientareaproductdetails.tpl`

**Issues:**
1. Hardcoded Access URL: `https://venom-drm.test/`
2. Hardcoded License Key: `VNM-{$serviceId}-XXXX-XXXX`
3. Hardcoded Username: `client-{$serviceId}`
4. Hardcoded Password: `••••••••` (static)
5. Hardcoded "Open Panel" link
6. Static "Auto-Renew: Enabled"

**Fixes:**

#### Issue 1-5: Replace Hardcoded Credentials

**BEFORE (Wrong):**
```html
<div class="credential-label">Access URL</div>
<div class="credential-value">https://venom-drm.test/</div>

<div class="credential-label">License Key</div>
<div class="credential-value">VNM-{$serviceId}-XXXX-XXXX</div>

<div class="credential-label">Username</div>
<div class="credential-value">client-{$serviceId}</div>

<div class="credential-label">Password</div>
<div class="credential-value">••••••••</div>

<a href="https://venom-drm.test/" class="btn-open-panel">Open Panel</a>
```

**AFTER (Correct):**
```html
<div class="credential-label">Access URL</div>
<div class="credential-value">
    {if $moduleoutput}
        {$moduleoutput}
    {elseif $service.server}
        {$service.server}
    {else}
        <span class="text-muted">--</span>
    {/if}
</div>

<div class="credential-label">License Key</div>
<div class="credential-value">
    {if $customfields.License_Key}
        {$customfields.License_Key}
    {else}
        <span class="text-muted">--</span>
    {/if}
</div>

<div class="credential-label">Username</div>
<div class="credential-value">
    {if $service.username}
        {$service.username}
    {else}
        <span class="text-muted">--</span>
    {/if}
</div>

<div class="credential-label">Password</div>
<div class="credential-value">
    {if $service.password}
        <span class="password-masked">••••••••</span>
        <button type="button" class="btn-reveal-password" data-password="{$service.password}">Show</button>
    {else}
        <span class="text-muted">--</span>
    {/if}
</div>

{if $service.urltarget || $customfields.Panel_URL}
<a href="{$service.urltarget|default:$customfields.Panel_URL}" class="btn btn-primary" target="_blank">
    Open Panel
</a>
{/if}
```

#### Issue 6: Fix Static Auto-Renew

**BEFORE (Wrong):**
```html
<div class="auto-renew-status">
    <span class="label">Auto-Renew</span>
    <span class="value">Enabled</span>
</div>
```

**AFTER (Correct):**
```html
<div class="auto-renew-status">
    <span class="label">Auto-Renew</span>
    <span class="value status-badge {if $autorenew}active{else}expired{/if}">
        {if $autorenew}Enabled{else}Disabled{/if}
    </span>
</div>
```

#### Additional: Move Inline CSS to venom-main.css

**Extract all styles between `<style>` and `</style>` tags and move to `venom-main.css` with section:

```css
/* ============================================================
   CLIENT AREA - SERVICE DETAILS
   ============================================================ */

/* Paste extracted styles here */

.credential-label {
    /* ... */
}

.credential-value {
    /* ... */
}
```

---

### 4.2 Fix `viewinvoice.tpl` - HIGH PRIORITY

**File:** `templates/venom-solutions/viewinvoice.tpl`

**Issues:**
1. Hardcoded "Venom Solutions"
2. Hardcoded "support@venom-solutions.com"

**Fixes:**

**BEFORE (Wrong):**
```html
<div class="invoice-from">
    <h3>From</h3>
    <p>
        <strong>Venom Solutions</strong><br>
        <a href="mailto:support@venom-solutions.com">support@venom-solutions.com</a>
    </p>
</div>
```

**AFTER (Correct):**
```html
<div class="invoice-from">
    <h3>{$LANG.invoicesfrom}</h3>
    <p>
        <strong>{$companyname}</strong><br>
        {if $companyemail}
            <a href="mailto:{$companyemail}">{$companyemail}</a>
        {/if}
    </p>
</div>
```

---

### 4.3 Fix `clientareaaddfunds.tpl` - CRITICAL

**File:** `templates/venom-solutions/clientareaaddfunds.tpl`

**Issues:**
1. Hardcoded payment methods (PayPal, Credit Card, Crypto)
2. Hardcoded `$` currency symbol

**Fixes:**

**BEFORE (Wrong):**
```html
<select name="gateway" class="form-select">
    <option value="paypal">PayPal</option>
    <option value="creditcard">Credit Card</option>
    <option value="crypto">Cryptocurrency</option>
</select>

<div class="amount-display">
    Amount: $<input type="number" name="amount" value="10.00">
</div>
```

**AFTER (Correct):**
```html
<select name="gateway" class="form-select">
    {foreach from=$gateways item=gateway}
        <option value="{$gateway.sysname}"{if $gateway.sysname eq $selectedgateway} selected{/if}>
            {$gateway.name}
        </option>
    {foreachelse}
        <option value="">No payment gateways available</option>
    {/foreach}
</select>

<div class="amount-display">
    {if $currency.prefix}{$currency.prefix}{/if}
    <input type="number" name="amount" value="{$minimumamount|default:10.00}" min="{$minimumamount|default:10.00}" step="0.01">
    {if $currency.suffix}{$currency.suffix}{/if}
</div>
```

---

### 4.4 Fix `contact.tpl` - MEDIUM PRIORITY

**File:** `templates/venom-solutions/contact.tpl`

**Issues:**
1. Hardcoded `support@venom-solutions.com`
2. Uses different layout (`contact-page` instead of `client-unified-page` when logged in)

**Fixes:**

**BEFORE (Wrong):**
```html
<div class="contact-email">
    <a href="mailto:support@venom-solutions.com">support@venom-solutions.com</a>
</div>
```

**AFTER (Correct):**
```html
<div class="contact-email">
    {if $companyemail}
        <a href="mailto:{$companyemail}">{$companyemail}</a>
    {else}
        <a href="mailto:support@venom-solutions.com">support@venom-solutions.com</a>
    {/if}
</div>
```

**Layout Fix:**
```smarty
{if $loggedin}
    {include file="$template/includes/sidebar.tpl"}
    <div class="client-unified-page">
        <!-- contact content -->
    </div>
{else}
    <div class="contact-page">
        <!-- contact content for guests -->
    </div>
{/if}
```

---

### 4.5 Fix `clientareaproducts.tpl` - HIGH PRIORITY

**File:** `templates/venom-solutions/clientareaproducts.tpl`

**Issues:**
1. Non-functional filter tabs

**Fixes:**

**Step 1:** Add `data-status` attribute to each service card

**BEFORE:**
```html
<div class="service-card">
    <!-- service content -->
    <span class="status-badge {$service.status|lower}">{$service.status}</span>
</div>
```

**AFTER:**
```html
<div class="service-card" data-status="{$service.status|lower}">
    <!-- service content -->
    <span class="status-badge {$service.status|lower}">{$service.status}</span>
</div>
```

**Step 2:** Add JavaScript for filter functionality

**Add to `venom-main.js`:**
```javascript
// Service filter tabs functionality
(function() {
    const filterTabs = document.querySelectorAll('.filter-tabs .tab');

    filterTabs.forEach(function(tab) {
        tab.addEventListener('click', function() {
            // Update active state
            filterTabs.forEach(function(t) t.classList.remove('active'));
            this.classList.add('active');

            // Filter services
            const status = this.dataset.status || '';
            const serviceCards = document.querySelectorAll('.service-card');

            serviceCards.forEach(function(card) {
                const cardStatus = card.dataset.status;
                if (!status || cardStatus === status) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
})();
```

**Step 3:** Update HTML to include `data-status` on tabs

**BEFORE:**
```html
<div class="filter-tabs">
    <button class="tab active">All Services</button>
    <button class="tab">Active</button>
    <button class="tab">Suspended</button>
    <button class="tab">Expired</button>
</div>
```

**AFTER:**
```html
<div class="filter-tabs">
    <button class="tab active" data-status="">All Services</button>
    <button class="tab" data-status="active">Active</button>
    <button class="tab" data-status="suspended">Suspended</button>
    <button class="tab" data-status="expired">Expired</button>
    <button class="tab" data-status="terminated">Terminated</button>
</div>
```

---

### 4.6 Fix `clientareacreditcard.tpl` - HIGH PRIORITY

**File:** `templates/venom-solutions/clientareacreditcard.tpl`

**Issues:**
1. Raw card number/CVV inputs (PCI compliance concern)
2. Delete flow URL needs verification

**Fixes:**

**Step 1:** Check if WHMCS gateway uses tokenization

**Updated template code:**
```html
{if $gatewayparams.useiframe}
    <!-- Gateway provides iframe/tokenization -->
    {$gatewayparams.gatewayinputfields}
{else}
    <!-- Legacy: Direct input (review with payment processor) -->
    <div class="form-group">
        <label class="form-label">Card Number</label>
        <input type="text" name="ccnumber" class="form-control" placeholder="•••• •••• •••• ••••">
    </div>
    <div class="form-row half">
        <div class="form-group">
            <label class="form-label">Expiry Date</label>
            <input type="text" name="ccexpirymonth" class="form-control" placeholder="MM" maxlength="2">
            <input type="text" name="ccexpiryyear" class="form-control" placeholder="YY" maxlength="2">
        </div>
        <div class="form-group">
            <label class="form-label">CVV</label>
            <input type="text" name="cccvv" class="form-control" placeholder="•••" maxlength="4">
        </div>
    </div>
{/if}
```

**Step 2:** Verify delete URL

**Current (may be wrong):**
```html
<a href="clientarea.php?action=creditcard&delete={$id}" class="btn-delete">Delete</a>
```

**Should verify WHMCS route:**
```html
<a href="clientarea.php?action=paymentmethods&delete={$id}&token={$token}" class="btn-delete">
    Delete
</a>
```

---

### 4.7 Fix `clientareahome.tpl` - LOW PRIORITY

**File:** `templates/venom-solutions/clientareahome.tpl`

**Issues:**
1. Announcement URL format may be wrong
2. Hardcoded "Client Area" text
3. 780 lines of inline CSS

**Fixes:**

**Announcement URL:**
```html
<!-- BEFORE -->
<a href="announcements.php/view/{$item.id}">{$item.title}</a>

<!-- AFTER -->
<a href="{if $item.urlfriendly}{$item.urlfriendly}{else}announcements.php?id={$item.id}{/if}">
    {$item.title}
</a>
```

**Hardcoded text:**
```html
<!-- BEFORE -->
<h1>Client Area</h1>

<!-- AFTER -->
<h1>{$LANG.clientareatitle}</h1>
```

---

### 4.8 Move Remaining Inline CSS

**Files:** All remaining templates with inline `<style>` blocks

**Process:** For each file:
1. `clientareainvoices.tpl`
2. `clientarearenewals.tpl`
3. `clientareadetails.tpl`
4. `clientareachangepw.tpl`
5. `upgrade.tpl`
6. `viewticket.tpl`
7. `supportticketslist.tpl`
8. `supportticketsubmit.tpl`

Extract ALL styles to `venom-main.css` with appropriate section comments.

---

## 5. PHASE 2: LAYOUT UNIFICATION

**Duration:** 2 days
**Goal:** Standardize all client area pages to consistent layout structure

---

### 5.1 Layout Pattern Decision

| Layout Class | Usage | Characteristics |
|--------------|-------|-----------------|
| `client-dashboard-page` | Dashboard only (`clientareahome.tpl`) | Wider grid, profile sidebar, statistics cards |
| `client-unified-page` | All other client area pages | Sidebar (280px) + main content, breadcrumb |
| `contact-page` | Contact page (guests only) | Centered form, minimal layout |

---

### 5.2 Standard Structure for `client-unified-page`

**Every inner page should follow this structure:**

```html
<div class="client-unified-page">
    <!-- Sidebar -->
    <aside class="ca-sidebar">
        <div class="ca-sidebar-card glass-card">
            <h3 class="ca-sidebar-title">{$pagetitle}</h3>
            <p class="ca-sidebar-desc">{$pagedescription}</p>

            <div class="ca-sidebar-actions">
                <a href="{$action1url}" class="sidebar-action-link">{$action1label}</a>
                <a href="{$action2url}" class="sidebar-action-link">{$action2label}</a>
                <a href="{$action3url}" class="sidebar-action-link">{$action3label}</a>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="ca-main">
        <!-- Breadcrumb -->
        <nav class="page-breadcrumb">
            <span class="breadcrumb-item"><a href="clientarea.php">{$LANG.clientareatitle}</a></span>
            <span class="breadcrumb-separator">&rsaquo;</span>
            <span class="breadcrumb-item current">{$pagetitle}</span>
        </nav>

        <!-- Page Header -->
        <header class="page-header">
            <h1 class="page-header-title">{$pagetitle}</h1>
            {if $pagesubtitle}
                <p class="page-header-subtitle">{$pagesubtitle}</p>
            {/if}
            <div class="page-header-actions">
                <!-- Action buttons -->
            </div>
        </header>

        <!-- Page Content -->
        <div class="page-content">
            {$template_output}
        </div>
    </main>
</div>
```

---

### 5.3 Sidebar Content Per Page

**Each page type gets contextual sidebar:**

| Page Type | Sidebar Content |
|-----------|-----------------|
| Services | Quick actions: Renew, Upgrade, Cancel |
| Invoices | Quick actions: Pay, Download, View Details |
| Tickets | Quick actions: New Ticket, My Tickets, Announcements |
| Profile | Quick actions: Change Password, Security, Contacts |
| KB/Downloads | Quick actions: Search, Categories, Contact Us |

---

### 5.4 Responsive Behavior

**Breakpoints:**
- **> 1100px:** Sidebar + content side-by-side
- **760px - 1100px:** 2-column sidebar grid
- **< 760px:** Sidebar stacks below content
- **< 480px:** Compact padding, reduced font sizes

**CSS to ensure:**
```css
.client-unified-page {
    display: grid;
    grid-template-columns: 280px 1fr;
    gap: 24px;
}

@media (max-width: 1100px) {
    .client-unified-page {
        grid-template-columns: 1fr;
    }

    .ca-sidebar {
        order: 1; /* Sidebar below content on mobile */
    }

    .ca-main {
        order: 0;
    }
}
```

---

## 6. PHASE 3: MISSING HIGH-PRIORITY PAGES

**Duration:** 4-6 days
**Goal:** Create all commonly accessed pages currently falling back to default theme

---

### 6.1 Security Page (`clientareasecurity.tpl`)

**File:** `templates/venom-solutions/clientareasecurity.tpl` (NEW)

**WHMCS Variables Available:**
- `$twofaEnabled` - boolean
- `$twofa` - array of 2FA methods
- `$securityquestions` - array
- `$securityquestionid` - current question ID
- `$clientsecurityquestions` - client's questions

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/account-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.securitysettings}</h1>
        </header>

        <div class="page-content">
            <!-- Two-Factor Authentication Section -->
            <section class="info-card">
                <h2>{$LANG.twofactorauth}</h2>
                <p>{if $twofaEnabled}{$LANG.twofaenabled}{else}{$LANG.twofadisabled}{/if}</p>

                {if $twofaEnabled}
                    <a href="clientarea.php?action=security&disable2fa=true" class="btn btn-danger">
                        {$LANG.twfadisable}
                    </a>
                {else}
                    <a href="clientarea.php?action=security" class="btn btn-primary">
                        {$LANG.twfaenable}
                    </a>
                {/if}
            </section>

            <!-- Security Questions Section -->
            <section class="info-card">
                <h2>{$LANG.securityquestions}</h2>
                <form method="post" action="clientarea.php?action=security">
                    <div class="form-group">
                        <label class="form-label">{$LANG.securityquestion}</label>
                        <select name="securityquestionid" class="form-select">
                            {foreach $securityquestions as $question}
                                <option value="{$question.id}"{if $question.id eq $securityquestionid} selected{/if}>
                                    {$question.question}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">{$LANG.securityanswer}</label>
                        <input type="text" name="securityqans" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">{$LANG.clientareasavechanges}</button>
                </form>
            </section>

            <!-- Login History (if available) -->
            {if $loginhistory}
            <section class="info-card">
                <h2>{$LANG.loginhistory}</h2>
                <table class="venom-table">
                    <thead>
                        <tr>
                            <th>{$LANG.datetime}</th>
                            <th>{$LANG.ipaddress}</th>
                            <th>{$LANG.status}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $loginhistory as $login}
                        <tr>
                            <td>{$login.datetime}</td>
                            <td>{$login.ip}</td>
                            <td><span class="status-badge {$login.status|lower}">{$login.status}</span></td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </section>
            {/if}
        </div>
    </main>
</div>
```

---

### 6.2 Email History (`clientareaemails.tpl`)

**File:** `templates/venom-solutions/clientareaemails.tpl` (NEW)

**WHMCS Variables:**
- `$emails` - array of email objects

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/account-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.emails}</h1>
        </header>

        <div class="page-content">
            {if $emails}
                <div class="venom-table_wrapper">
                    <table class="venom-table">
                        <thead>
                            <tr>
                                <th>{$LANG.date}</th>
                                <th>{$LANG.subject}</th>
                                <th>{$LANG.actions}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $emails as $email}
                            <tr>
                                <td>{$email.date}</td>
                                <td>{$email.subject}</td>
                                <td>
                                    <a href="clientarea.php?action=emails&id={$email.id}" class="btn btn-sm">View</a>
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                {include file="$template/includes/pagination.tpl"}
            {else}
                <div class="empty-state">
                    <svg class="empty-state-icon"><!-- email icon --></svg>
                    <h3>{$LANG.noemails}</h3>
                    <p>You haven't received any emails yet.</p>
                </div>
            {/if}
        </div>
    </main>
</div>
```

---

### 6.3 Quotes Pages

#### 6.3.1 Quotes List (`clientareaquotes.tpl`)

**File:** `templates/venom-solutions/clientareaquotes.tpl` (NEW)

**WHMCS Variables:**
- `$quotes` - array of quotes

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/billing-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.quotes}</h1>
        </header>

        <div class="page-content">
            {if $quotes}
                <div class="venom-table_wrapper">
                    <table class="venom-table">
                        <thead>
                            <tr>
                                <th>{$LANG.quotenumber}</th>
                                <th>{$LANG.date}</th>
                                <th>{$LANG.validuntil}</th>
                                <th>{$LANG.total}</th>
                                <th>{$LANG.status}</th>
                                <th>{$LANG.actions}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $quotes as $quote}
                            <tr>
                                <td>#{$quote.id}</td>
                                <td>{$quote.date}</td>
                                <td>{$quote.validuntil}</td>
                                <td>{$quote.total}</td>
                                <td><span class="status-badge {$quote.status|lower}">{$quote.status}</span></td>
                                <td>
                                    <a href="viewquote.php?id={$quote.id}" class="btn btn-sm">View</a>
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            {else}
                <div class="empty-state">
                    <h3>No Quotes</h3>
                    <p>You don't have any quotes.</p>
                </div>
            {/if}
        </div>
    </main>
</div>
```

#### 6.3.2 View Quote (`viewquote.tpl`)

**File:** `templates/venom-solutions/viewquote.tpl` (NEW)

**Similar structure to `viewinvoice.tpl`** with Accept/Reject buttons:

```html
<div class="quote-actions">
    <form method="post" action="viewquote.php?id={$quote.id}">
        <input type="hidden" name="accept" value="1">
        <button type="submit" class="btn btn-success">Accept Quote</button>
    </form>
    <form method="post" action="viewquote.php?id={$quote.id}">
        <input type="hidden" name="reject" value="1">
        <button type="submit" class="btn btn-danger">Reject Quote</button>
    </form>
    <a href="viewquote.php?id={$quote.id}&download=1" class="btn btn-secondary">Download PDF</a>
</div>
```

---

### 6.4 Announcements

#### 6.4.1 Announcements List (`announcements.tpl`)

**File:** `templates/venom-solutions/announcements.tpl` (NEW)

**WHMCS Variables:**
- `$announcements` - array
- `$kbcategories` - for filtering

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/support-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.announcements}</h1>
        </header>

        <!-- Category Filter -->
        {if $kbcategories}
        <div class="category-filter">
            <button class="filter-btn active" data-category="">All</button>
            {foreach $kbcategories as $category}
                <button class="filter-btn" data-category="{$category.id}">{$category.name}</button>
            {/foreach}
        </div>
        {/if}

        <div class="announcements-grid">
            {foreach $announcements as $announcement}
            <article class="announcement-card glass-card" data-category="{$announcement.categoryid}">
                <div class="announcement-header">
                    <span class="announcement-category">{$announcement.category}</span>
                    <span class="announcement-date">{$announcement.date}</span>
                </div>
                <h2 class="announcement-title">
                    <a href="{if $announcement.urlfriendly}{$announcement.urlfriendly}{else}announcements.php?id={$announcement.id}{/if}">
                        {$announcement.title}
                    </a>
                </h2>
                <p class="announcement-excerpt">{$announcement.text|strip_tags|truncate:200}</p>
                <a href="{if $announcement.urlfriendly}{$announcement.urlfriendly}{else}announcements.php?id={$announcement.id}{/if}"
                   class="btn btn-secondary">Read More</a>
            </article>
            {/foreach}
        </div>

        {include file="$template/includes/pagination.tpl"}
    </main>
</div>
```

#### 6.4.2 View Announcement (`viewannouncement.tpl`)

**File:** `templates/venom-solutions/viewannouncement.tpl` (NEW)

---

### 6.5 Knowledge Base

#### 6.5.1 KB Home (`knowledgebase.tpl`)

**File:** `templates/venom-solutions/knowledgebase.tpl` (NEW)

**WHMCS Variables:**
- `$kbcategories` - array
- `$kbarticles` - popular/recent

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/support-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.knowledgebasetitle}</h1>
            <p class="page-header-subtitle">Find answers to common questions</p>
        </header>

        <!-- Search -->
        <div class="kb-search">
            <form method="get" action="knowledgebase.php">
                <input type="search" name="search" class="form-control" placeholder="Search knowledge base...">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>

        <!-- Categories Grid -->
        <div class="kb-categories-grid">
            {foreach $kbcategories as $category}
            <a href="knowledgebase.php?action=displaycategory&catid={$category.id}" class="kb-category-card glass-card">
                <div class="kb-category-icon">{$category.icon}</div>
                <h3 class="kb-category-name">{$category.name}</h3>
                <p class="kb-category-count">{$category.numarticles} articles</p>
            </a>
            {/foreach}
        </div>

        <!-- Popular Articles -->
        {if $kbarticles}
        <section class="kb-articles-section">
            <h2>Popular Articles</h2>
            <div class="kb-articles-list">
                {foreach $kbarticles as $article}
                <article class="kb-article-item">
                    <a href="knowledgebase.php?action=displayarticle&id={$article.id}" class="kb-article-link">
                        <h3>{$article.title}</h3>
                        <p class="kb-article-excerpt">{$article.text|strip_tags|truncate:150}</p>
                    </a>
                </article>
                {/foreach}
            </div>
        </section>
        {/if}
    </main>
</div>
```

#### 6.5.2 KB Category (`knowledgebasecat.tpl`)

**File:** `templates/venom-solutions/knowledgebasecat.tpl` (NEW)

#### 6.5.3 KB Article (`knowledgebasearticle.tpl`)

**File:** `templates/venom-solutions/knowledgebasearticle.tpl` (NEW)

**Features:**
- Article content with proper typography
- Breadcrumb navigation
- Related articles sidebar
- "Was this helpful?" rating
- Print/share options

---

### 6.6 Downloads

#### 6.6.1 Downloads List (`downloads.tpl`)

**File:** `templates/venom-solutions/downloads.tpl` (NEW)

**WHMCS Variables:**
- `$downloads` - array
- `$downloadcategories` - for filtering

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/support-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.downloads}</h1>
        </header>

        <!-- Category Filter -->
        {if $downloadcategories}
        <div class="category-filter">
            <button class="filter-btn active" data-category="">All</button>
            {foreach $downloadcategories as $category}
                <button class="filter-btn" data-category="{$category.id}">{$category.name}</button>
            {/foreach}
        </div>
        {/if}

        <div class="downloads-grid">
            {foreach $downloads as $download}
            <div class="download-card glass-card" data-category="{$download.categoryid}">
                <div class="download-icon">{$download.filetype}</div>
                <h3 class="download-name">{$download.title}</h3>
                <p class="download-description">{$download.description}</p>
                <div class="download-meta">
                    <span class="download-size">{$download.filesize}</span>
                    <span class="download-count">{$downloads.downloads} downloads</span>
                </div>
                <a href="download.php?id={$download.id}" class="btn btn-primary">Download</a>
            </div>
            {/foreach}
        </div>
    </main>
</div>
```

#### 6.6.2 Downloads Category (`downloadscat.tpl`)

**File:** `templates/venom-solutions/downloadscat.tpl` (NEW)

---

### 6.7 Affiliates

#### 6.7.1 Affiliate Dashboard (`affiliates.tpl`)

**File:** `templates/venom-solutions/affiliates.tpl` (NEW)

**WHMCS Variables:**
- `$affiliatedata` - array with stats
- `$affiliatevisitors` - visitors array
- `$withdrawrequests` - withdrawal history

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/affiliate-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.affiliatestitle}</h1>
        </header>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <span class="stat-card-label">Total Visitors</span>
                <span class="stat-card-value">{$affiliatedata.visitors}</span>
            </div>
            <div class="stat-card">
                <span class="stat-card-label">Signups</span>
                <span class="stat-card-value">{$affiliatedata.signups}</span>
            </div>
            <div class="stat-card">
                <span class="stat-card-label">Earnings</span>
                <span class="stat-card-value">{$affiliatedata.balance}</span>
            </div>
        </div>

        <!-- Referral Link -->
        <section class="info-card">
            <h2>Your Referral Link</h2>
            <div class="referral-link-box">
                <input type="text" value="{$affiliatedata.referralurl}" readonly class="form-control">
                <button type="button" class="btn btn-secondary" onclick="copyToClipboard('{$affiliatedata.referralurl}')">Copy</button>
            </div>
        </section>

        <!-- Commission History -->
        {if $withdrawrequests}
        <section class="info-card">
            <h2>Withdrawal History</h2>
            <table class="venom-table">
                <thead>
                    <tr>
                        <th>{$LANG.date}</th>
                        <th>{$LANG.amount}</th>
                        <th>{$LANG.status}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $withdrawrequests as $request}
                    <tr>
                        <td>{$request.date}</td>
                        <td>{$request.amount}</td>
                        <td><span class="status-badge {$request.status|lower}">{$request.status}</span></td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </section>
        {/if}
    </main>
</div>
```

#### 6.7.2 Affiliate Signup (`affiliatessignup.tpl`)

**File:** `templates/venom-solutions/affiliatessignup.tpl` (NEW)

---

### 6.8 Cancel Request (`clientareacancelrequest.tpl`)

**File:** `templates/venom-solutions/clientareacancelrequest.tpl` (NEW)

**WHMCS Variables:**
- `$serviceid` - service being cancelled
- `$reason` - cancellation reason
- `$type` - cancellation type

**Structure:**
```html
<div class="client-unified-page">
    <aside class="ca-sidebar">
        {include file="$template/includes/services-sidebar.tpl"}
    </aside>

    <main class="ca-main">
        <nav class="page-breadcrumb">...</nav>
        <header class="page-header">
            <h1>{$LANG.cancellationrequest}</h1>
        </header>

        <form method="post" action="clientarea.php?action=cancel">
            <input type="hidden" name="serviceid" value="{$serviceid}">

            <section class="info-card">
                <h2>Cancellation Reason</h2>
                <div class="form-group">
                    <label class="form-label">Reason for Cancellation</label>
                    <select name="reason" class="form-select" required>
                        <option value="">Select a reason...</option>
                        <option value="Lack of Features">Lack of Features</option>
                        <option value="Found Better Alternative">Found Better Alternative</option>
                        <option value="Technical Issues">Technical Issues</option>
                        <option value="No Longer Needed">No Longer Needed</option>
                        <option value="Cost">Cost</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Additional Details</label>
                    <textarea name="additionalinfo" class="form-textarea" rows="4"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <input type="checkbox" name="confirm" required>
                        I understand this action cannot be undone
                    </label>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-danger">Submit Cancellation Request</button>
                    <a href="clientarea.php?action=productdetails&id={$serviceid}" class="btn btn-secondary">Cancel</a>
                </div>
            </section>
        </form>
    </main>
</div>
```

---

## 7. PHASE 4: ACCOUNT & USER MANAGEMENT PAGES

**Duration:** 3-4 days
**Goal:** Create WHMCS 9+ user management and account pages

---

### 7.1 Payment Methods

#### 7.1.1 Payment Methods List (`account-paymentmethods.tpl`)

**File:** `templates/venom-solutions/account-paymentmethods.tpl` (NEW)

#### 7.1.2 Manage Payment Method (`account-paymentmethods-manage.tpl`)

**File:** `templates/venom-solutions/account-paymentmethods-manage.tpl` (NEW)

#### 7.1.3 Billing Contacts (`account-paymentmethods-billing-contacts.tpl`)

**File:** `templates/venom-solutions/account-paymentmethods-billing-contacts.tpl` (NEW)

---

### 7.2 Contacts Management

#### 7.2.1 Manage Contact (`account-contacts-manage.tpl`)

**File:** `templates/venom-solutions/account-contacts-manage.tpl` (NEW)

#### 7.2.2 New Contact (`account-contacts-new.tpl`)

**File:** `templates/venom-solutions/account-contacts-new.tpl` (NEW)

---

### 7.3 User Management (WHMCS 9+)

**Files to create:**
1. `user-profile.tpl`
2. `user-password.tpl`
3. `user-security.tpl`
4. `user-verify-email.tpl`
5. `user-switch-account.tpl`
6. `user-switch-account-forced.tpl`
7. `user-invite-accept.tpl`
8. `account-user-management.tpl`
9. `account-user-permissions.tpl`

**All follow `client-unified-page` layout with user-focused sidebar.**

---

## 8. PHASE 5: HEADER & NAVIGATION REFINEMENT

**Duration:** 1-2 days
**Goal:** Professional, polished client area header

---

### 8.1 Update Header Navigation

**File:** `templates/venom-solutions/header.tpl`

**Menu Structure:**
```
Dashboard
├── My Services
│   ├── View All
│   ├── [Service Name] -> details
│   └── Renewals
├── Billing
│   ├── My Invoices
│   ├── Quotes
│   └── Add Funds
├── Support
│   ├── My Tickets
│   ├── Submit Ticket
│   ├── Announcements
│   ├── Knowledgebase
│   └── Downloads
└── Account
    ├── Profile Details
    ├── Security Settings
    ├── Email History
    ├── Contacts
    └── User Management
```

**Active State Logic:**

```php
// In header.tpl or configuration
$currentClientMenu = [
    'clientareahome.tpl' => 'dashboard',
    'clientareaproducts.tpl' => 'services',
    'clientareaproductdetails.tpl' => 'services',
    'clientarearenewals.tpl' => 'services',
    'clientareainvoices.tpl' => 'billing',
    'viewinvoice.tpl' => 'billing',
    'clientareaquotes.tpl' => 'billing',
    'viewquote.tpl' => 'billing',
    'clientareaaddfunds.tpl' => 'billing',
    'supportticketslist.tpl' => 'support',
    'supportticketsubmit.tpl' => 'support',
    'viewticket.tpl' => 'support',
    'announcements.tpl' => 'support',
    'viewannouncement.tpl' => 'support',
    'knowledgebase.tpl' => 'support',
    'knowledgebasecat.tpl' => 'support',
    'knowledgebasearticle.tpl' => 'support',
    'downloads.tpl' => 'support',
    'downloadscat.tpl' => 'support',
    'clientareadetails.tpl' => 'account',
    'clientareachangepw.tpl' => 'account',
    'clientareasecurity.tpl' => 'account',
    'clientareaemails.tpl' => 'account',
    'account-contacts-manage.tpl' => 'account',
    'account-contacts-new.tpl' => 'account',
    'account-user-management.tpl' => 'account',
    'affiliates.tpl' => 'affiliates',
    'affiliatessignup.tpl' => 'affiliates',
];
```

---

### 8.2 Remove Unused Navigation Items

**Remove from header:**
- Domains menu and sub-items (not in scope)
- Server Status link
- SSL/Certificates link

---

### 8.3 Mobile Navigation

**Implement:**
- Hamburger menu for mobile
- Slide-out drawer or bottom sheet
- Touch-friendly tap targets (min 44x44px)

---

## 9. PHASE 6: THEME SYSTEM HARDENING

**Duration:** 1-2 days
**Goal:** Stable, isolated theme system

---

### 9.1 Theme Switcher Component

**File:** `templates/venom-squares/includes/theme-switcher.tpl` (NEW)

**Structure:**
```html
<div class="theme-switcher">
    <!-- Light/Dark Toggle -->
    <button type="button" class="theme-toggle" id="themeToggle">
        <span class="theme-icon-sun">☀️</span>
        <span class="theme-icon-moon">🌙</span>
    </button>

    <!-- Accent Color Picker -->
    <div class="accent-picker">
        <button type="button" class="accent-option" data-accent="blue" style="--accent-color: #3b82f6"></button>
        <button type="button" class="accent-option" data-accent="purple" style="--accent-color: #8b5cf6"></button>
        <button type="button" class="accent-option" data-accent="green" style="--accent-color: #10b981"></button>
        <button type="button" class="accent-option" data-accent="orange" style="--accent-color: #f59e0b"></button>
        <button type="button" class="accent-option" data-accent="red" style="--accent-color: #ef4444"></button>
    </div>
</div>
```

---

### 9.2 Theme Switcher JavaScript

**File:** `templates/venom-solutions/js/venom-main.js`

**Add:**
```javascript
// Theme switcher functionality (client area only)
(function() {
    'use strict';

    // Only run on client area pages
    if (!document.body.classList.contains('client-area')) {
        return;
    }

    // Theme toggle
    const themeToggle = document.getElementById('themeToggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', function() {
            const body = document.body;
            const isDark = body.classList.contains('theme-dark');

            if (isDark) {
                body.classList.remove('theme-dark');
                body.classList.add('theme-light');
                localStorage.setItem('venom-theme', 'light');
            } else {
                body.classList.remove('theme-light');
                body.classList.add('theme-dark');
                localStorage.setItem('venom-theme', 'dark');
            }
        });
    }

    // Accent color picker
    const accentOptions = document.querySelectorAll('.accent-option');
    accentOptions.forEach(function(option) {
        option.addEventListener('click', function() {
            const accent = this.dataset.accent;
            const body = document.body;

            // Remove old accent
            body.classList.remove('accent-blue', 'accent-purple', 'accent-green', 'accent-orange', 'accent-red');

            // Add new accent
            body.classList.add('accent-' + accent);
            localStorage.setItem('venom-accent', accent);

            // Update active state
            accentOptions.forEach(function(opt) opt.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Set initial state from localStorage
    (function() {
        const theme = localStorage.getItem('venom-theme') || 'light';
        const accent = localStorage.getItem('venom-accent') || 'blue';

        document.body.classList.add('theme-' + theme, 'accent-' + accent);

        // Update accent picker active state
        accentOptions.forEach(function(option) {
            if (option.dataset.accent === accent) {
                option.classList.add('active');
            }
        });
    })();
})();
```

---

### 9.3 Verify Theme Isolation

**Ensure:**
1. Theme classes only apply to `body.client-area`
2. Landing page never receives theme classes
3. Auth pages never receive theme classes
4. localStorage keys are scoped: `venom-theme`, `venom-accent`

---

## 10. PHASE 7: RESPONSIVE & ACCESSIBILITY QA

**Duration:** 2-3 days
**Goal:** Full responsive coverage, accessibility compliance

---

### 10.1 Responsive Testing Matrix

| Breakpoint | Target | Test Actions |
|------------|--------|--------------|
| 1400px+ | Desktop | Full layout, hover states |
| 1100px | Laptop | Sidebar stacking trigger |
| 768px | Tablet | Compact sidebar, hamburger menu |
| 480px | Mobile | Single column, compact padding |
| 320px | Small Mobile | Minimum viable view |

**Test on each breakpoint:**
- Header/navigation behavior
- Sidebar behavior
- Table horizontal scroll
- Form field usability
- Button tap targets (min 44x44px)
- Font size legibility

---

### 10.2 Accessibility Checklist

- [ ] All images have alt text
- [ ] Form inputs have associated labels
- [ ] Focus states visible on all interactive elements
- [ ] Keyboard navigation works (Tab, Enter, Escape)
- [ ] Color contrast ratio >= 4.5:1 for text
- [ ] ARIA labels on icon-only buttons
- [ ] Skip to main content link
- [ ] Form error messages properly announced
- [ ] Modal focus trap (if any modals)

---

### 10.3 Cross-Browser Testing

Test on:
- Chrome/Edge (Chromium)
- Firefox
- Safari (if Mac available)
- Mobile Safari (iOS)
- Chrome Mobile (Android)

---

## 11. PHASE 8: DOCUMENTATION & HANDOFF

**Duration:** 1-2 days
**Goal:** Clear documentation for maintenance

---

### 11.1 Create Component Documentation

**File:** `templates/venom-solutions/README.md` (NEW)

**Contents:**
1. Template structure
2. Component library reference
3. Theme system usage
4. Customization guide
5. Known limitations

---

### 11.2 Template Inventory

**File:** `templates/venom-solutions/TEMPLATE_INVENTORY.md` (NEW)

**List all templates with:**
- Status (Complete/Partial/Needs Work)
- WHMCS version compatibility
- Dependencies
- Notes

---

### 11.3 Changelog

**File:** `templates/venom-solutions/CHANGELOG.md` (NEW)

**Record all changes:**
```markdown
# Changelog

## [Unreleased]

### Added
- Client area theme system (light/dark + 5 accents)
- 15+ missing templates
- Unified component library
- ...

### Changed
- Extracted inline CSS to venom-main.css
- Fixed hardcoded values in templates
- ...

### Fixed
- Service filter tabs functionality
- Hardcoded credentials in service details
- ...
```

---

## 12. WHMCS INTEGRATION COMPLIANCE (🆕 from cursor)

### 12.1 WHMCS Variables Reference

**Always use these variables instead of hardcoded values:**

| Variable | Purpose |
|----------|---------|
| `$companyname` | Company name |
| `$companyemail` | Company email |
| `$WEB_ROOT` | Base URL |
| `$currency.prefix` / `$currency.code` | Currency display |
| `$currency.suffix` | Currency suffix |
| `$gateways` | Payment gateways array |
| `$LANG.*` | Language strings for i18n |
| `$clientsdetails.*` | Client information |
| `$clientsstats.*` | Client statistics |
| `$headeroutput` | Header hook output |
| `$footeroutput` | Footer hook output |
| `$template` | Current template path |
| `$token` | CSRF token for forms |
| `$loggedin` | Whether user is logged in |
| `$pagetitle` | Current page title |

### 12.2 Module Output Handling

```smarty
{if $moduleoutput}
    {$moduleoutput}
{else}
    {* Fallback content *}
{/if}
```

### 12.3 Hook Compatibility

- Ensure `$headeroutput` and `$footeroutput` are preserved in layout
- Support WHMCS sidebar hooks if needed
- Maintain breadcrumb compatibility
- Always include `{$token}` in form actions for CSRF protection

---

## 13. COMPONENT LIBRARY REFERENCE (🆕 from cursor)

### 13.1 Smarty Component Usage Examples

#### Status Badge
```smarty
{include file="$template/includes/components/status-badge.tpl"
    status=$service.status
}
```

#### Card Component
```smarty
{include file="$template/includes/components/card.tpl"
    title="Card Title"
    icon="svg-icon-name"
    badge="Active"
    badgeStatus="active"
}
    Content here
{/include}
```

#### Data Table
```smarty
{include file="$template/includes/components/data-table.tpl"
    columns=["Service", "Status", "Amount", "Actions"]
    data=$services
    emptyMessage="No services found"
}
```

#### Empty State
```smarty
{include file="$template/includes/components/empty-state.tpl"
    icon="inbox"
    title="No Services Found"
    message="You don't have any active services."
    actionUrl="cart.php"
    actionLabel="Browse Products"
}
```

#### Page Header
```smarty
{include file="$template/includes/components/page-header.tpl"
    title=$pagetitle
    subtitle="Manage your account settings"
}
```

#### Breadcrumb
```smarty
{include file="$template/includes/components/breadcrumb.tpl"
    items=[
        ["label" => $LANG.clientareatitle, "url" => "clientarea.php"],
        ["label" => $pagetitle, "url" => ""]
    ]
}
```

### 13.2 Forms
- Unified form sections with `.form-section`, `.form-row`, `.form-group`
- Consistent validation styling (`.is-invalid`, `.is-valid`)
- Error/success message components
- Input shell for icon inputs

### 13.3 Modals
- Standardized modal component
- Confirmation dialogs (delete, cancel, etc.)
- Form modals (inline editing)


---

## 14. DEFINITION OF DONE

**The implementation is complete when:**

### Functional Requirements
- [ ] All P1 missing templates created and functional
- [ ] All hardcoded values replaced with WHMCS variables
- [ ] Filter tabs in services list work correctly
- [ ] Theme system persists choices across page loads
- [ ] Theme system does NOT affect landing/auth pages
- [ ] All forms have CSRF tokens (`{$token}`)
- [ ] Module output handling in service details

### Visual/UX Requirements
- [ ] All client area pages use unified layout (`client-unified-page` or `client-dashboard-page`)
- [ ] Status badges consistent across all pages (unified `.status-badge`)
- [ ] Empty states consistent across all pages (unified `.empty-state`)
- [ ] All tables responsive with horizontal scroll
- [ ] All forms use unified form components
- [ ] Touch-friendly interactions: **min 44px tap targets** (🆕 from cursor)
- [ ] Swipe gestures for sidebar on mobile (🆕 from cursor)

### Code Quality Requirements
- [ ] No inline `<style>` blocks in templates
- [ ] All CSS uses HSL variables from design system
- [ ] All CSS uses design tokens (`--space-*`, `--text-*`, `--radius-*`, etc.)
- [ ] All hardcoded values removed
- [ ] All comments and text in English
- [ ] No duplicate CSS/JS code
- [ ] Smarty component includes used for reusable elements (🆕 from cursor)

### Responsive Requirements (🆕 enhanced from cursor)
- [ ] **Breakpoint Strategy:**
  - Desktop: > 1024px — Full sidebar + content
  - Tablet: 768-1024px — Collapsed sidebar + content
  - Mobile: < 768px — Drawer sidebar + stacked content
- [ ] Tested on 320px, 480px, 768px, 1024px, 1280px, 1440px
- [ ] Touch tap targets minimum 44x44px
- [ ] Tables convert to cards or scroll on mobile

### Testing Requirements
- [ ] Tested light and dark themes on all pages
- [ ] Tested all 5 accent colors
- [ ] Keyboard navigation works
- [ ] Form validation works
- [ ] Cross-browser: Chrome, Firefox, Safari, Edge, Mobile browsers

### Documentation Requirements
- [ ] `README.md` created with component usage guide
- [ ] `TEMPLATE_INVENTORY.md` created with status per template
- [ ] `CHANGELOG.md` created
- [ ] CSS variables reference documented
- [ ] Smarty include patterns documented

---

## EXECUTION SUMMARY

### Estimated Timeline

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| Phase 0: Foundation & Design System | 2-3 days | None |
| Phase 1: Fix Existing Pages | 3-4 days | Phase 0 |
| Phase 2: Layout Unification | 2 days | Phase 0 |
| Phase 3: P1 Missing Pages | 4-6 days | Phase 0, 2 |
| Phase 4: User Management | 3-4 days | Phase 0, 2 |
| Phase 5: Header Refinement | 1-2 days | Phase 0 |
| Phase 6: Theme Hardening | 1-2 days | Phase 0 |
| Phase 7: QA (Responsive + Accessibility) | 2-3 days | All phases |
| Phase 8: Documentation & Handoff | 1-2 days | All phases |

**Total:** 19-32 days

### File Impact Summary

| Category | Count | Action |
|----------|-------|--------|
| Existing templates to fix | 15 | Modify |
| P1 missing templates | 14 | Create |
| P2 missing templates | 8 | Create |
| P3 missing templates | 9 | Create |
| CSS files | 2 | Major expansion (`venom-main.css` + new `venom-components.css`) |
| JS files | 1 | Add theme + filter logic |
| Include templates | ~5 | Create sidebars |
| Smarty components (🆕) | ~9 | Create (`includes/components/`) |
| Documentation | 3 | Create |

**Total:** ~65 files

### Files Created/Modified Complete List

**CSS:**
- `templates/venom-solutions/css/venom-main.css` — Enhanced (design tokens + all extracted inline CSS)
- `templates/venom-solutions/css/venom-components.css` — NEW

**JavaScript:**
- `templates/venom-solutions/js/venom-main.js` — Enhanced (theme + filters)

**Templates (Modify):**
`header.tpl`, `footer.tpl`, `clientareahome.tpl`, `clientareaproducts.tpl`, `clientareaproductdetails.tpl`, `clientareainvoices.tpl`, `viewinvoice.tpl`, `clientarearenewals.tpl`, `clientareaaddfunds.tpl`, `clientareacreditcard.tpl`, `clientareadetails.tpl`, `clientareachangepw.tpl`, `supportticketslist.tpl`, `supportticketsubmit.tpl`, `viewticket.tpl`, `upgrade.tpl`, `contact.tpl`

**Templates (New - Pages):**
`clientareasecurity.tpl`, `clientareaemails.tpl`, `clientareaquotes.tpl`, `announcements.tpl`, `viewannouncement.tpl`, `knowledgebase.tpl`, `knowledgebasecat.tpl`, `knowledgebasearticle.tpl`, `downloads.tpl`, `downloadscat.tpl`, `viewquote.tpl`, `clientareacancelrequest.tpl`, `affiliates.tpl`, `affiliatessignup.tpl`, `account-paymentmethods.tpl`, `account-paymentmethods-manage.tpl`, `account-paymentmethods-billing-contacts.tpl`, `account-contacts-manage.tpl`, `account-contacts-new.tpl`, `user-profile.tpl`, `user-password.tpl`, `user-security.tpl`, `user-verify-email.tpl`, `user-switch-account.tpl`, `user-switch-account-forced.tpl`, `user-invite-accept.tpl`, `account-user-management.tpl`, `account-user-permissions.tpl`

**Templates (New - Includes/Components 🆕):**
`includes/client-layout.tpl`, `includes/client-sidebar.tpl`, `includes/components/status-badge.tpl`, `includes/components/empty-state.tpl`, `includes/components/page-header.tpl`, `includes/components/stat-card.tpl`, `includes/components/data-table.tpl`, `includes/components/pagination.tpl`, `includes/components/breadcrumb.tpl`, `includes/components/form-section.tpl`, `includes/components/modal.tpl`

**Documentation:**
`README.md`, `TEMPLATE_INVENTORY.md`, `CHANGELOG.md`

---

*End of Final Implementation Plan v2*
*Merged from: antigravity (detailed CSS + before/after fixes) + cursor (design tokens, Smarty components, WHMCS variables, touch UX)*


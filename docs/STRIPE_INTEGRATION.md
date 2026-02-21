# Stripe Sandbox Integration Guide — WHMCS

> **Scope:** WHMCS only. No third-party panel changes.
> **WHMCS Version:** 8.10.1
> **Stripe Module:** Built-in Stripe by WHMCS (modules/gateways/stripe.php)

---

## A) Stripe Gateway Setup (Test Mode)

### 1. Confirm Available Stripe Gateway Module

WHMCS 8.10.1 includes the built-in Stripe gateway module by WHMCS:

| File | Purpose |
|------|---------|
| `modules/gateways/stripe.php` | Main gateway module (ionCube encrypted) |
| `modules/gateways/callback/stripe.php` | Webhook callback handler |
| `modules/gateways/stripe/` | Supporting assets (JS, CSS, hooks, lib) |

The module supports:
- Tokenized payment methods (card saving for recurring)
- Test mode operation
- Webhook-based payment confirmation
- Automatic recurring billing

### 2. Enable Stripe Gateway in TEST Mode

#### Via WHMCS Admin UI:

1. Navigate to **Setup > Payments > Payment Gateways**
2. Click **All Payment Gateways** tab
3. Find **Stripe** and click **Activate**
4. Configure the following settings:

| Setting | Value (Test Mode) |
|---------|-------------------|
| **Friendly Name** | `Credit Card (Stripe)` |
| **Test Mode** | `Enabled` (checkbox) |
| **Publishable Key** | `pk_test_...` (from Stripe Dashboard) |
| **Secret Key** | `sk_test_...` (from Stripe Dashboard) |
| **Webhook Signing Secret** | `whsec_...` (from Stripe Webhook config) |
| **Store Pay Method** | `Enabled` (for tokenization) |
| **Payment Method Title** | `Credit/Debit Card` |

#### Via Database (for reference):

```sql
-- Enable Stripe gateway
INSERT INTO tblpaymentgateways (gateway, setting, value, `order`)
VALUES 
  ('stripe', 'name', 'Credit Card (Stripe)', 0),
  ('stripe', 'type', 'CC', 1),
  ('stripe', 'visible', 'on', 2),
  ('stripe', 'testmode', 'on', 3)
ON DUPLICATE KEY UPDATE value = VALUES(value);

-- Store credentials (DO NOT hardcode in files - use WHMCS Admin UI)
-- These are placeholders - replace with actual test keys from Stripe Dashboard
INSERT INTO tblpaymentgateways (gateway, setting, value, `order`)
VALUES 
  ('stripe', 'publishableKey', 'pk_test_YOUR_PUBLISHABLE_KEY_HERE', 10),
  ('stripe', 'secretKey', 'sk_test_YOUR_SECRET_KEY_HERE', 11),
  ('stripe', 'webhookSecret', 'whsec_YOUR_WEBHOOK_SECRET_HERE', 12)
ON DUPLICATE KEY UPDATE value = VALUES(value);
```

### 3. Stripe Credentials Configuration

**IMPORTANT:** Never hardcode secrets in files. Configure credentials via:

#### Option A: WHMCS Admin UI (Recommended)
1. Go to **Setup > Payments > Payment Gateways**
2. Click **Manage Existing Gateways** tab
3. Find **Stripe** and enter credentials in the fields provided

#### Option B: Environment Variables (Advanced)
WHMCS does not natively support environment variables for gateway credentials.
If you need env var support, you would need to:

1. Create a custom configuration file outside web root:
   ```
   /home/venom/.whmcs/stripe_credentials.php
   ```

2. Add to `configuration.php`:
   ```php
   // Load Stripe credentials from environment if available
   $stripeSecretKey = getenv('STRIPE_SECRET_KEY') ?: 'sk_test_...';
   $stripePublishableKey = getenv('STRIPE_PUBLISHABLE_KEY') ?: 'pk_test_...';
   $stripeWebhookSecret = getenv('STRIPE_WEBHOOK_SECRET') ?: 'whsec_...';
   ```

#### Environment Variable Names (for reference):
| Variable | Description |
|----------|-------------|
| `STRIPE_PUBLISHABLE_KEY` | Stripe publishable key (pk_test_...) |
| `STRIPE_SECRET_KEY` | Stripe secret key (sk_test_...) |
| `STRIPE_WEBHOOK_SECRET` | Webhook signing secret (whsec_...) |

### 4. Configure Stripe Webhooks

#### Webhook Endpoint URL:
```
https://your-whmcs-domain.com/modules/gateways/callback/stripe.php
```

For local development/testing:
```
http://localhost/modules/gateways/callback/stripe.php
```

#### Setup in Stripe Dashboard:

1. Go to [Stripe Dashboard > Developers > Webhooks](https://dashboard.stripe.com/test/webhooks)
2. Click **Add endpoint**
3. Enter the endpoint URL: `https://your-domain.com/modules/gateways/callback/stripe.php`
4. Select these events to listen to:
   - `checkout.session.completed`
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `charge.succeeded`
   - `charge.failed`
   - `customer.source.expedited`
   - `invoice.payment_succeeded`
   - `invoice.payment_action_required`
5. Click **Add endpoint**
6. Copy the **Signing secret** (starts with `whsec_`) and add it to WHMCS Stripe settings

---

## B) WHMCS Settings for Recurring (Tokenization)

### 1. Enable Tokenized Payment Methods

The WHMCS Stripe module automatically tokenizes cards when:
- **Store Pay Method** is enabled in gateway settings
- Client completes a successful checkout

To verify/enable via WHMCS Admin UI:
1. Go to **Setup > Payments > Payment Gateways**
2. Click **Manage Existing Gateways**
3. Find **Stripe** section
4. Ensure **Store Pay Method** is checked/enabled

### 2. Enable Automatic Credit Card Processing

Via WHMCS Admin UI:
1. Go to **Setup > Automation Settings**
2. Find **Invoice & Late Payment Automation** section
3. Configure:

| Setting | Recommended Value (DEV) | Production Value |
|---------|------------------------|------------------|
| **Process Credit Card Payments** | `Enabled` | `Enabled` |
| **Days Before Due Date** | `0` | `7` |
| **Send Reminders** | `Enabled` | `Enabled` |
| **First Reminder** | `0` days | `3` days |
| **Second Reminder** | `1` day | `7` days |
| **Third Reminder** | `2` days | `14` days |

### 3. Automation Settings for Fast Testing (DEV ONLY)

For rapid testing of recurring billing, adjust these settings:

```sql
-- DEV ONLY: Enable aggressive CC processing for testing
UPDATE tblconfiguration SET value = '0' WHERE setting = 'CCProcessDaysBeforeDue';
UPDATE tblconfiguration SET value = '0' WHERE setting = 'CCDaySendFirstReminder';
UPDATE tblconfiguration SET value = '1' WHERE setting = 'CCDaySendSecondReminder';
UPDATE tblconfiguration SET value = '2' WHERE setting = 'CCDaySendThirdReminder';

-- Enable automatic CC processing
UPDATE tblconfiguration SET value = 'on' WHERE setting = 'CCProcessEnabled';

-- Set suspension grace period (days after due date)
UPDATE tblconfiguration SET value = '3' WHERE setting = 'SuspensionGracePeriod';
```

**IMPORTANT:** Revert these values for production!

---

## C) Test Plan + Evidence

### Test Cards (Stripe Test Mode)

| Card Number | Scenario |
|-------------|----------|
| `4242424242424242` | Success (Visa) |
| `4000000000000002` | Decline (generic) |
| `4000000000009995` | Insufficient funds |
| `4000000000000069` | Expired card |
| `4000000000000119` | Processing error |

Use any future expiry date and any 3-digit CVC.

### Test Case 1: New Purchase (pid=1) Monthly

**Steps:**
1. Add product pid=1 to cart: `/cart.php?a=add&pid=1`
2. Complete checkout using Stripe test card `4242424242424242`
3. Verify results

**Expected Results:**
- [ ] Invoice status = `Paid`
- [ ] Service status = `Active`
- [ ] Client has saved payment method (tokenized card)
- [ ] Activity Log shows payment success

**SQL Evidence Queries:**
```sql
-- Check invoice status
SELECT id, status, total, paymentmethod, datepaid 
FROM tblinvoices 
WHERE userid = CLIENT_ID 
ORDER BY id DESC LIMIT 1;

-- Check service status
SELECT id, domainstatus, nextduedate, nextinvoicedate, paymentmethod
FROM tblhosting 
WHERE userid = CLIENT_ID 
ORDER BY id DESC LIMIT 1;

-- Check saved payment method (token)
SELECT id, gateway, card_last_four, card_expiry, created_at
FROM tblpay_methods
WHERE userid = CLIENT_ID;

-- Check transaction record
SELECT id, invoiceid, amount, gateway, date, transid
FROM tblaccounts
WHERE gateway = 'stripe'
ORDER BY id DESC LIMIT 1;
```

### Test Case 2: Renewal Auto-Charge

**Steps:**
1. Identify a Stripe-paid service (from Test Case 1)
2. Set `nextduedate` to today or tomorrow:
   ```sql
   UPDATE tblhosting 
   SET nextduedate = CURDATE(), nextinvoicedate = CURDATE()
   WHERE id = SERVICE_ID;
   ```
3. Run WHMCS cron:
   ```bash
   /home/venom/bin/php8.1 -q /home/venom/workspace/venom-drm.test/crons/cron.php all --force -vvv
   ```
4. Verify results

**Expected Results:**
- [ ] Renewal invoice created automatically
- [ ] Invoice paid automatically via stored payment method
- [ ] Service `nextduedate` advanced by billing cycle
- [ ] Activity Log shows auto-charge success

**SQL Evidence Queries:**
```sql
-- Check for new invoice
SELECT id, status, total, datecreated, datepaid, paymentmethod
FROM tblinvoices
WHERE userid = CLIENT_ID
ORDER BY id DESC LIMIT 2;

-- Check service updated due date
SELECT id, nextduedate, nextinvoicedate, domainstatus
FROM tblhosting
WHERE id = SERVICE_ID;

-- Check activity log for payment
SELECT id, date, description, user
FROM tblactivitylog
WHERE description LIKE '%stripe%' OR description LIKE '%payment%'
ORDER BY id DESC LIMIT 5;
```

### Test Case 3: Failed Renewal Behavior

**Steps:**
1. Use Stripe test card that fails: `4000000000000002`
2. Complete a new purchase with this card
3. Set service `nextduedate` to today
4. Run WHMCS cron
5. Verify failure handling

**Alternative:** Temporarily disable capture and rerun:
```sql
-- Temporarily mark payment method as failed
UPDATE tblpay_methods SET card_last_four = '0002' WHERE userid = CLIENT_ID;
```

**Expected Results:**
- [ ] Invoice remains `Unpaid`
- [ ] Retry policy follows WHMCS automation settings
- [ ] Service suspension triggers after grace period
- [ ] Activity Log shows payment failure

**Current Grace Policy:**
- First reminder: 0 days (DEV setting)
- Second reminder: 1 day
- Third reminder: 2 days
- Suspension: 3 days after due date

**SQL Evidence Queries:**
```sql
-- Check invoice remains unpaid
SELECT id, status, datecreated, duedate
FROM tblinvoices
WHERE userid = CLIENT_ID
ORDER BY id DESC LIMIT 1;

-- Check activity log for failure
SELECT id, date, description
FROM tblactivitylog
WHERE description LIKE '%fail%' OR description LIKE '%decline%'
ORDER BY id DESC LIMIT 5;

-- Check service status (should eventually suspend)
SELECT id, domainstatus, nextduedate
FROM tblhosting
WHERE id = SERVICE_ID;
```

---

## D) How to Run Renewal Test in 2 Minutes

### Quick Renewal Test Procedure:

```bash
# 1. Find a Stripe-paid service
mysql -e "SELECT id, userid, nextduedate FROM tblhosting WHERE paymentmethod='stripe' LIMIT 1;" whmcs_db

# 2. Set nextduedate to today (replace SERVICE_ID)
mysql -e "UPDATE tblhosting SET nextduedate=CURDATE(), nextinvoicedate=CURDATE() WHERE id=SERVICE_ID;" whmcs_db

# 3. Run cron
/home/venom/bin/php8.1 -q /home/venom/workspace/venom-drm.test/crons/cron.php all --force -vvv

# 4. Check results (replace CLIENT_ID)
mysql -e "SELECT id, status, datepaid FROM tblinvoices WHERE userid=CLIENT_ID ORDER BY id DESC LIMIT 1;" whmcs_db
mysql -e "SELECT id, nextduedate FROM tblhosting WHERE id=SERVICE_ID;" whmcs_db
```

---

## Troubleshooting

### Common Issues:

1. **"Invalid API Key" error**
   - Verify test mode is enabled
   - Check that test keys (pk_test_*, sk_test_*) are used
   - Ensure no extra whitespace in key fields

2. **Webhook signature verification failed**
   - Verify webhook secret matches Stripe Dashboard
   - Check endpoint URL is accessible from internet
   - For local testing, use Stripe CLI: `stripe listen --forward-to localhost/modules/gateways/callback/stripe.php`

3. **Card not being saved (no tokenization)**
   - Ensure "Store Pay Method" is enabled in gateway settings
   - Check client has permission to store payment methods

4. **Recurring charge not triggering**
   - Verify `CCProcessEnabled = on` in tblconfiguration
   - Check `CCProcessDaysBeforeDue` setting
   - Ensure service has valid payment method token

---

## Files Modified/Created

| File | Purpose |
|------|---------|
| `docs/STRIPE_INTEGRATION.md` | This documentation file |
| `docs/QA_CHECKLIST.md` | Updated with Stripe test cases |
| `.docs/CHANGELOG.md` | Task #3 entry added |

---

## Webhook Endpoint Path

```
/modules/gateways/callback/stripe.php
```

**Full URL:** `https://your-domain.com/modules/gateways/callback/stripe.php`

**How to register in Stripe Dashboard:**
1. Go to https://dashboard.stripe.com/test/webhooks
2. Click "Add endpoint"
3. Enter the full URL above
4. Select required events (see Section A.4)
5. Copy signing secret to WHMCS Stripe settings

# 2Checkout (Verifone) Integration Guide — WHMCS

> **Scope:** WHMCS only. No third-party panel changes.
> **WHMCS Version:** 8.10.1
> **2Checkout Module:** Built-in TCO by WHMCS (`modules/gateways/tco/`)

---

## A) 2Checkout Gateway Setup (Test Mode)

### 1. Confirm Available 2Checkout Gateway Module

WHMCS 8.10.1 includes the built-in 2Checkout (TCO) gateway module:

| File | Purpose |
|------|---------|
| `modules/gateways/tco/` | Main gateway module directory |
| `modules/gateways/tco/lib/Standard.php` | Standard checkout integration |
| `modules/gateways/tco/lib/Inline.php` | Inline checkout integration |
| `modules/gateways/tco/lib/CallbackRequestHelper.php` | IPN callback handling |
| `modules/gateways/callback/tco.php` | Callback endpoint for IPN |
| `modules/gateways/callback/2checkout.php` | Alternative callback endpoint |

The module supports:
- Hosted payment page (Standard)
- Inline checkout (embedded)
- Test mode operation with sandbox credentials
- IPN (Instant Payment Notification) for payment confirmation
- Recurring billing via 2Checkout subscription system

### 2. Enable 2Checkout Gateway in TEST Mode

#### Via WHMCS Admin UI:

1. Navigate to **Setup > Payments > Payment Gateways**
2. Click **All Payment Gateways** tab
3. Find **2CheckOut** and click **Activate**
4. Configure the following settings:

| Setting | Value (Test Mode) |
|---------|-------------------|
| **Friendly Name** | `Credit Card (2Checkout)` |
| **Test Mode** | `Enabled` (checkbox) |
| **Account Number** | Your 2Checkout sandbox account ID |
| **Secret Word** | Secret word from 2Checkout dashboard |
| **Checkout Method** | `Standard` (hosted) or `Inline` (embedded) |
| **Payment Method Title** | `Credit/Debit Card` |

#### Via Database (for reference):

```sql
-- Enable 2Checkout gateway
INSERT INTO tblpaymentgateways (gateway, setting, value, `order`)
VALUES 
  ('tco', 'name', 'Credit Card (2Checkout)', 0),
  ('tco', 'type', 'CC', 1),
  ('tco', 'visible', 'on', 2),
  ('tco', 'testmode', 'on', 3)
ON DUPLICATE KEY UPDATE value = VALUES(value);

-- Store credentials (DO NOT hardcode in files - use WHMCS Admin UI)
-- These are placeholders - replace with actual sandbox credentials
INSERT INTO tblpaymentgateways (gateway, setting, value, `order`)
VALUES 
  ('tco', 'accountNumber', 'YOUR_SANDBOX_ACCOUNT_NUMBER', 10),
  ('tco', 'secretWord', 'YOUR_SECRET_WORD', 11)
ON DUPLICATE KEY UPDATE value = VALUES(value);
```

### 3. 2Checkout Credentials Configuration

**IMPORTANT:** Never hardcode secrets in files. Configure credentials via:

#### Option A: WHMCS Admin UI (Recommended)
1. Go to **Setup > Payments > Payment Gateways**
2. Click **Manage Existing Gateways** tab
3. Find **2CheckOut** and enter credentials in the fields provided

#### Option B: 2Checkout Sandbox Account
To get sandbox credentials:
1. Sign up at https://sandbox.2checkout.com/sandbox/
2. Navigate to **Account > Account Management**
3. Find your **Account Number** (Merchant ID)
4. Go to **Notifications > Settings**
5. Set your **Secret Word** for IPN verification

#### Environment Variable Names (for reference):
| Variable | Description |
|----------|-------------|
| `TCO_ACCOUNT_NUMBER` | 2Checkout merchant account ID |
| `TCO_SECRET_WORD` | Secret word for IPN verification |

---

## B) IPN / Notifications Setup

### 1. IPN Callback URL

The IPN callback URL for WHMCS 2Checkout module is:

```
https://your-whmcs-domain.com/modules/gateways/callback/tco.php
```

Alternative callback (legacy):
```
https://your-whmcs-domain.com/modules/gateways/callback/2checkout.php
```

### 2. Local Development Tunnel Setup

Since this environment is local, you need a public tunnel for 2Checkout to send IPN callbacks.

#### Option A: Cloudflared (Recommended)

```bash
# Install cloudflared if not already installed
# Download from: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/

# Start tunnel exposing WHMCS
cloudflared tunnel --url http://localhost

# Or if WHMCS runs on a specific port:
cloudflared tunnel --url http://localhost:8080
```

Output will show something like:
```
Your quick Tunnel has been created! Visit it at:
https://random-name-xxxx.trycloudflare.com
```

Your IPN URL becomes:
```
https://random-name-xxxx.trycloudflare.com/modules/gateways/callback/tco.php
```

#### Option B: Ngrok

```bash
# Install ngrok if not already installed
# Download from: https://ngrok.com/download

# Start tunnel
ngrok http 80

# Or with specific port:
ngrok http 8080
```

Output will show:
```
Forwarding: https://random-name-xxxx.ngrok.io -> http://localhost:80
```

Your IPN URL becomes:
```
https://random-name-xxxx.ngrok.io/modules/gateways/callback/tco.php
```

### 3. Configure IPN in 2Checkout Dashboard

1. Log in to 2Checkout Sandbox: https://sandbox.2checkout.com/sandbox/
2. Navigate to **Notifications > Settings**
3. Enable **IPN (Instant Payment Notification)**
4. Enter the IPN URL: `https://your-tunnel-url/modules/gateways/callback/tco.php`
5. Set **Secret Word** (must match WHMCS gateway settings)
6. Enable these IPN events:
   - Order Created
   - Fraud Status Changed
   - Invoice Status Changed
   - Recurring Installment Success
   - Recurring Installment Failed
7. Click **Save**

### 4. Tunnel Management Commands

```bash
# Start cloudflared tunnel (foreground)
cloudflared tunnel --url http://localhost

# Start cloudflared tunnel (background)
cloudflared tunnel --url http://localhost &

# Stop tunnel (find and kill process)
pkill -f cloudflared

# Or with ngrok
ngrok http 80

# Stop ngrok
pkill -f ngrok
```

---

## C) WHMCS Settings for Recurring Billing

### 1. 2Checkout Subscription Model

2Checkout handles recurring billing differently than Stripe:

| Feature | 2Checkout Behavior |
|---------|-------------------|
| **Recurring** | 2Checkout creates subscriptions on their side |
| **Auto-charge** | 2Checkout bills automatically per cycle |
| **IPN on renewal** | 2Checkout sends IPN for each recurring payment |
| **Tokenization** | Limited - 2Checkout stores card, not WHMCS |

**Important:** Unlike Stripe, 2Checkout manages the subscription lifecycle. WHMCS receives IPN notifications when recurring payments occur.

### 2. Configure Recurring in WHMCS

Via WHMCS Admin UI:
1. Go to **Setup > Automation Settings**
2. Find **Invoice & Late Payment Automation** section
3. Configure:

| Setting | Recommended Value (DEV) | Production Value |
|---------|------------------------|------------------|
| **Process Credit Card Payments** | `Enabled` | `Enabled` |
| **Days Before Due Date** | `0` | `7` |
| **Send Reminders** | `Enabled` | `Enabled` |

### 3. Automation Settings for Fast Testing (DEV ONLY)

```sql
-- DEV ONLY: Enable aggressive processing for testing
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

## D) Test Plan + Evidence

### Test Cards (2Checkout Sandbox)

2Checkout sandbox test cards (verify in your sandbox dashboard):

| Card Number | Scenario |
|-------------|----------|
| `4111111111111111` | Success (Visa) |
| `5555555555554444` | Success (Mastercard) |
| `4000000000000002` | Decline (generic) |

Use any future expiry date and any 3-digit CVC.

### Test Case 1: New Purchase (pid=1) Monthly

**Steps:**
1. Ensure tunnel is running and IPN URL is configured in 2Checkout
2. Add product pid=1 to cart: `/cart.php?a=add&pid=1`
3. Select 2Checkout as payment method
4. Complete checkout using 2Checkout sandbox test card
5. Verify results

**Expected Results:**
- [ ] Redirect to 2Checkout hosted page (Standard mode)
- [ ] Payment completed successfully
- [ ] Redirect back to WHMCS with success message
- [ ] Invoice status = `Paid`
- [ ] Service status = `Active`
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

-- Check transaction record
SELECT id, invoiceid, amount, gateway, date, transid
FROM tblaccounts
WHERE gateway = 'tco'
ORDER BY id DESC LIMIT 1;

-- Check activity log
SELECT id, date, description, user
FROM tblactivitylog
WHERE description LIKE '%2checkout%' OR description LIKE '%tco%'
ORDER BY id DESC LIMIT 5;
```

### Test Case 2: Renewal Behavior

**Important:** 2Checkout handles recurring billing on their platform.

**Steps:**
1. Identify a 2Checkout-paid service (from Test Case 1)
2. 2Checkout will automatically charge the customer on renewal date
3. 2Checkout sends IPN to WHMCS when payment completes
4. WHMCS processes IPN and updates invoice/service

**For Testing Renewals:**

Since 2Checkout controls the subscription timing, you have two options:

**Option A:** Wait for 2Checkout sandbox recurring cycle (if configured for short cycles)

**Option B:** Simulate IPN callback manually (for testing only):
```bash
# Simulate IPN callback to test WHMCS handling
curl -X POST https://your-tunnel-url/modules/gateways/callback/tco.php \
  -d "message_type=RECURRING_INSTALLMENT_SUCCESS" \
  -d "message_id=test-123" \
  -d "invoice_id=INVOICE_ID" \
  -d "recurring_id=RECURRING_ID" \
  -d "invoice_list=WHMCS_INVOICE_ID" \
  -d "total=100.00" \
  -d "currency=USD"
```

**Expected Results:**
- [ ] Renewal invoice created automatically (or existing invoice updated)
- [ ] Invoice status = `Paid` after IPN received
- [ ] Service `nextduedate` advanced by billing cycle
- [ ] Activity Log shows renewal payment success

**SQL Evidence Queries:**
```sql
-- Check for new/updated invoice
SELECT id, status, total, datecreated, datepaid, paymentmethod
FROM tblinvoices
WHERE userid = CLIENT_ID
ORDER BY id DESC LIMIT 2;

-- Check service updated due date
SELECT id, nextduedate, nextinvoicedate, domainstatus
FROM tblhosting
WHERE id = SERVICE_ID;

-- Check activity log for renewal
SELECT id, date, description
FROM tblactivitylog
WHERE description LIKE '%renewal%' OR description LIKE '%recurring%'
ORDER BY id DESC LIMIT 5;
```

### Test Case 3: Failed Payment Path

**Steps:**
1. Use 2Checkout sandbox test card that fails: `4000000000000002`
2. Complete a new purchase attempt
3. Verify failure handling

**Alternative:** Simulate failed IPN callback:
```bash
# Simulate failed IPN callback
curl -X POST https://your-tunnel-url/modules/gateways/callback/tco.php \
  -d "message_type=RECURRING_INSTALLMENT_FAILED" \
  -d "message_id=test-456" \
  -d "invoice_id=INVOICE_ID" \
  -d "recurring_id=RECURRING_ID" \
  -d "invoice_list=WHMCS_INVOICE_ID" \
  -d "total=100.00" \
  -d "currency=USD"
```

**Expected Results:**
- [ ] Invoice remains `Unpaid`
- [ ] Retry policy follows 2Checkout settings (not WHMCS)
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

## E) How to Run Renewal Test in 2 Minutes

### Quick Renewal Test Procedure:

```bash
# 1. Ensure tunnel is running
cloudflared tunnel --url http://localhost &

# 2. Note the tunnel URL from output
TUNNEL_URL="https://random-name-xxxx.trycloudflare.com"

# 3. Find a TCO-paid service
mysql -e "SELECT id, userid, nextduedate FROM tblhosting WHERE paymentmethod='tco' LIMIT 1;" whmcs_db

# 4. Simulate renewal IPN (replace INVOICE_ID with actual ID)
curl -X POST "$TUNNEL_URL/modules/gateways/callback/tco.php" \
  -d "message_type=RECURRING_INSTALLMENT_SUCCESS" \
  -d "invoice_id=TEST-RENEWAL-123" \
  -d "invoice_list=INVOICE_ID" \
  -d "total=100.00" \
  -d "currency=USD"

# 5. Check results (replace CLIENT_ID)
mysql -e "SELECT id, status, datepaid FROM tblinvoices WHERE userid=CLIENT_ID ORDER BY id DESC LIMIT 1;" whmcs_db
mysql -e "SELECT id, nextduedate FROM tblhosting WHERE id=SERVICE_ID;" whmcs_db
```

---

## Troubleshooting

### Common Issues:

1. **"Invalid Secret Word" error**
   - Verify secret word matches exactly between WHMCS and 2Checkout dashboard
   - Check for extra whitespace in configuration fields
   - Ensure using sandbox secret word for test mode

2. **IPN not received**
   - Verify tunnel is running and accessible
   - Check IPN URL is correctly configured in 2Checkout dashboard
   - Review 2Checkout IPN logs in their dashboard
   - Check WHMCS activity log for any received callbacks

3. **Payment not reflected in WHMCS**
   - Check `tblaccounts` table for transaction record
   - Verify gateway setting matches `tco` in `tblpaymentgateways`
   - Review WHMCS module debug log if enabled

4. **Recurring not working**
   - 2Checkout creates subscriptions automatically for recurring products
   - Verify product is configured as recurring in WHMCS
   - Check 2Checkout dashboard for subscription status

### Debug Mode:

Enable debug logging in WHMCS:
```sql
INSERT INTO tblconfiguration (setting, value) VALUES ('ModuleDebugMode', 'on')
ON DUPLICATE KEY UPDATE value = 'on';
```

Check logs at:
- WHMCS Activity Log: **Utilities > Activity Log**
- WHMCS Module Log: **Utilities > Module Debug Log**

---

## Files Modified/Created

| File | Purpose |
|------|---------|
| `docs/2CHECKOUT_INTEGRATION.md` | This documentation file |
| `docs/QA_CHECKLIST.md` | Updated with 2Checkout test cases |
| `.docs/CHANGELOG.md` | Task #4 entry added |
| `install/tco_gateway_setup.sql` | Database setup script |

---

## IPN Callback Endpoint Paths

### Primary Endpoint:
```
/modules/gateways/callback/tco.php
```

### Legacy Endpoint:
```
/modules/gateways/callback/2checkout.php
```

**Full URL:** `https://your-domain.com/modules/gateways/callback/tco.php`

**How to register in 2Checkout Dashboard:**
1. Log in to https://sandbox.2checkout.com/sandbox/
2. Go to **Notifications > Settings**
3. Enable IPN
4. Enter the full URL above
5. Configure secret word
6. Select required events
7. Save settings

---

## Tunnel URL Management

### Current Tunnel URL (Update this when tunnel changes):
```
# Replace with your current tunnel URL
TUNNEL_URL=https://your-tunnel-url.trycloudflare.com
```

### IPN URL:
```
{TUNNEL_URL}/modules/gateways/callback/tco.php
```

### Start/Stop Tunnel Commands:

```bash
# Start (cloudflared)
cloudflared tunnel --url http://localhost &

# Start (ngrok)
ngrok http 80 &

# Stop all tunnels
pkill -f cloudflared
pkill -f ngrok

# Check running tunnels
ps aux | grep -E 'cloudflared|ngrok'
```

---

## Rollback Steps

If 2Checkout integration needs to be disabled:

1. **Disable Gateway in WHMCS Admin UI:**
   - Go to **Setup > Payments > Payment Gateways**
   - Click **Manage Existing Gateways**
   - Find **2CheckOut** and uncheck **Visible**

2. **Remove Gateway Settings (Database):**
   ```sql
   DELETE FROM tblpaymentgateways WHERE gateway = 'tco';
   ```

3. **Revert Automation Settings:**
   ```sql
   UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCProcessDaysBeforeDue';
   UPDATE tblconfiguration SET value = '3' WHERE setting = 'CCDaySendFirstReminder';
   UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCDaySendSecondReminder';
   UPDATE tblconfiguration SET value = '14' WHERE setting = 'CCDaySendThirdReminder';
   UPDATE tblconfiguration SET value = '7' WHERE setting = 'SuspensionGracePeriod';
   ```

4. **Stop Tunnel:**
   ```bash
   pkill -f cloudflared
   # or
   pkill -f ngrok
   ```

5. **Remove Documentation (optional):**
   ```bash
   rm docs/2CHECKOUT_INTEGRATION.md
   rm install/tco_gateway_setup.sql
   ```

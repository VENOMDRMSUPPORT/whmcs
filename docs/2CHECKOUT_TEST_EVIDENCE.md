# 2Checkout Integration Test Evidence

## Test Date: 2026-02-21

---

## A) Gateway Configuration Evidence

### Database Configuration (tblpaymentgateways)

```
gateway	setting	value
tco	name	Credit Card (2Checkout)
tco	type	CC
tco	visible	on
tco	testmode	on
tco	friendname	Credit/Debit Card
tco	accountNumber	SANDBOX_ACCOUNT_NUMBER_PLACEHOLDER
tco	secretWord	SANDBOX_SECRET_WORD_PLACEHOLDER
tco	checkoutMethod	Standard
tco	paymentMethodTitle	Credit/Debit Card
```

**Status:** ✅ Gateway enabled in TEST mode with placeholder credentials

### Automation Settings (tblconfiguration)

```
setting	value
CCDaySendFirstReminder	0
CCDaySendSecondReminder	1
CCDaySendThirdReminder	2
CCProcessDaysBeforeDue	0
CCProcessEnabled	on
SuspensionGracePeriod	3
```

**Status:** ✅ DEV automation settings configured for fast testing

---

## B) Tunnel Setup Evidence

### Cloudflared Tunnel

- **Tunnel URL:** `https://earl-miller-cambridge-affordable.trycloudflare.com`
- **IPN Callback URL:** `https://earl-miller-cambridge-affordable.trycloudflare.com/modules/gateways/callback/tco.php`
- **Process:** Running (PID 266346)

### Callback Endpoint Test

```
HTTP Status: 301 (Redirect expected for GET request)
```

**Status:** ✅ Tunnel running and callback endpoint accessible

---

## C) Test Cases

### Test Case 1: Successful New Purchase (pid=1) Monthly

**Prerequisites:**
- 2Checkout sandbox account required
- Actual sandbox credentials needed (replace placeholders)
- IPN URL must be configured in 2Checkout dashboard

**Steps:**
1. Replace placeholder credentials in WHMCS:
   ```sql
   UPDATE tblpaymentgateways SET value = 'YOUR_ACTUAL_ACCOUNT_NUMBER' 
   WHERE gateway = 'tco' AND setting = 'accountNumber';
   UPDATE tblpaymentgateways SET value = 'YOUR_ACTUAL_SECRET_WORD' 
   WHERE gateway = 'tco' AND setting = 'secretWord';
   ```
2. Configure IPN URL in 2Checkout sandbox dashboard
3. Add product to cart: `/cart.php?a=add&pid=1`
4. Select 2Checkout as payment method
5. Complete checkout with test card: `4111111111111111`

**Expected Results:**
- [ ] Redirect to 2Checkout hosted page
- [ ] Payment completed successfully
- [ ] Redirect back to WHMCS
- [ ] Invoice status = `Paid`
- [ ] Service status = `Active`
- [ ] Activity Log shows payment success

**Evidence Query:**
```sql
-- Check invoice status
SELECT id, status, total, paymentmethod, datepaid 
FROM tblinvoices 
WHERE userid = CLIENT_ID 
ORDER BY id DESC LIMIT 1;

-- Check service status
SELECT id, domainstatus, nextduedate, paymentmethod
FROM tblhosting 
WHERE userid = CLIENT_ID 
ORDER BY id DESC LIMIT 1;

-- Check transaction record
SELECT id, invoiceid, amount, gateway, date, transid
FROM tblaccounts
WHERE gateway = 'tco'
ORDER BY id DESC LIMIT 1;
```

**Status:** ⏳ Pending - Requires actual2Checkout sandbox credentials

---

### Test Case 2: Renewal Behavior

**Important:** 2Checkout handles recurring billing on their platform.

**Steps:**
1. Complete Test Case 1 first
2. 2Checkout will automatically charge on renewal date
3. IPN notification sent to WHMCS

**For Manual Testing:**
```bash
# Simulate renewal IPN callback
curl -X POST "https://your-tunnel-url/modules/gateways/callback/tco.php" \
  -d "message_type=RECURRING_INSTALLMENT_SUCCESS" \
  -d "invoice_id=TEST-RENEWAL-123" \
  -d "invoice_list=INVOICE_ID" \
  -d "total=100.00" \
  -d "currency=USD"
```

**Expected Results:**
- [ ] Renewal invoice created/updated
- [ ] Invoice status = `Paid` after IPN
- [ ] Service `nextduedate` advanced
- [ ] Activity Log shows renewal

**Status:** ⏳ Pending - Requires Test Case 1 completion

---

### Test Case 3: Failed Payment Path

**Steps:**
1. Use test card that declines: `4000000000000002`
2. Or simulate failed IPN:
```bash
curl -X POST "https://your-tunnel-url/modules/gateways/callback/tco.php" \
  -d "message_type=RECURRING_INSTALLMENT_FAILED" \
  -d "invoice_id=TEST-FAIL-123" \
  -d "invoice_list=INVOICE_ID" \
  -d "total=100.00" \
  -d "currency=USD"
```

**Expected Results:**
- [ ] Invoice remains `Unpaid`
- [ ] Service suspension after grace period (3 days)
- [ ] Activity Log shows failure

**Status:** ⏳ Pending - Requires Test Case 1 completion

---

## D) Files Created/Modified

| File | Purpose | Status |
|------|---------|--------|
| `docs/2CHECKOUT_INTEGRATION.md` | Complete integration guide | ✅ Created |
| `install/tco_gateway_setup.sql` | Database setup script | ✅ Created |
| `docs/QA_CHECKLIST.md` | Updated with2Checkout tests | ✅ Updated |
| `.docs/CHANGELOG.md` | Task #4 entry | ✅ Updated |
| `storage/tunnel_status.txt` | Tunnel URL documentation | ✅ Created |
| `docs/2CHECKOUT_TEST_EVIDENCE.md` | This file | ✅ Created |

---

## E) Next Steps

To complete the test cases:

1. **Get 2Checkout Sandbox Credentials:**
   - Sign up at https://sandbox.2checkout.com/sandbox/
   - Get Account Number from Account > Account Management
   - Set Secret Word in Notifications > Settings

2. **Update WHMCS Gateway Settings:**
   ```sql
   UPDATE tblpaymentgateways SET value = 'YOUR_ACCOUNT_NUMBER' 
   WHERE gateway = 'tco' AND setting = 'accountNumber';
   UPDATE tblpaymentgateways SET value = 'YOUR_SECRET_WORD' 
   WHERE gateway = 'tco' AND setting = 'secretWord';
   ```

3. **Configure IPN in 2Checkout Dashboard:**
   - URL: `https://earl-miller-cambridge-affordable.trycloudflare.com/modules/gateways/callback/tco.php`
   - Enable required IPN events

4. **Run Test Cases:**
   - Test Case 1: New purchase
   - Test Case 2: Renewal (wait for2Checkout or simulate)
   - Test Case 3: Failure (use decline card or simulate)

---

## F) Rollback Steps

If needed to disable2Checkout integration:

```sql
-- Disable gateway
DELETE FROM tblpaymentgateways WHERE gateway = 'tco';

-- Revert automation settings to production values
UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCProcessDaysBeforeDue';
UPDATE tblconfiguration SET value = '3' WHERE setting = 'CCDaySendFirstReminder';
UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCDaySendSecondReminder';
UPDATE tblconfiguration SET value = '14' WHERE setting = 'CCDaySendThirdReminder';
UPDATE tblconfiguration SET value = '7' WHERE setting = 'SuspensionGracePeriod';
```

```bash
# Stop tunnel
pkill -f cloudflared
```

---

## G) Tunnel Management

### Start Tunnel:
```bash
nohup /tmp/cloudflared tunnel --url http://localhost > /tmp/cloudflared_output.txt 2>&1 &
```

### Get Tunnel URL:
```bash
cat /tmp/cloudflared_output.txt | grep -oE 'https://[a-zA-Z0-9-]+\.trycloudflare\.com' | head -1
```

### Stop Tunnel:
```bash
pkill -f cloudflared
```

### Check Tunnel Status:
```bash
ps aux | grep cloudflared | grep -v grep
```

---

**Document Version:** 1.0
**Last Updated:** 2026-02-21 15:30 UTC

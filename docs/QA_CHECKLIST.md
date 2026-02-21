# QA Checklist — WHMCS Stabilization Pack

Scope: WHMCS only. No third-party panel changes.

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

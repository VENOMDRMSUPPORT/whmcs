-- ============================================================================
-- 2Checkout (TCO) Gateway Setup Script for WHMCS 8.10.1
-- ============================================================================
-- This script configures the 2Checkout payment gateway for TEST MODE operation.
-- 
-- IMPORTANT: This script contains PLACEHOLDER values for credentials.
-- You MUST replace the placeholder values with actual 2Checkout sandbox credentials
-- from your 2Checkout Sandbox Dashboard (https://sandbox.2checkout.com/sandbox/)
--
-- NEVER commit actual API keys to version control!
-- ============================================================================

-- -----------------------------------------------------------------------------
-- Section A: Enable 2Checkout Gateway
-- -----------------------------------------------------------------------------

-- Clear any existing TCO configuration (fresh start)
DELETE FROM tblpaymentgateways WHERE gateway = 'tco';

-- Insert basic 2Checkout gateway configuration
INSERT INTO tblpaymentgateways (gateway, setting, value, `order`) VALUES
('tco', 'name', 'Credit Card (2Checkout)', 0),
('tco', 'type', 'CC', 1),
('tco', 'visible', 'on', 2),
('tco', 'testmode', 'on', 3),
('tco', 'friendname', 'Credit/Debit Card', 4);

-- -----------------------------------------------------------------------------
-- Section B: 2Checkout Credentials (PLACEHOLDERS - REPLACE BEFORE RUNNING)
-- -----------------------------------------------------------------------------
-- Get your sandbox credentials from: https://sandbox.2checkout.com/sandbox/
-- Account Number: Found in Account > Account Management
-- Secret Word: Set in Notifications > Settings

INSERT INTO tblpaymentgateways (gateway, setting, value, `order`) VALUES
-- REPLACE THESE PLACEHOLDERS WITH YOUR ACTUAL SANDBOX CREDENTIALS:
('tco', 'accountNumber', 'YOUR_SANDBOX_ACCOUNT_NUMBER', 10),
('tco', 'secretWord', 'YOUR_SECRET_WORD', 11);

-- -----------------------------------------------------------------------------
-- Section C: Checkout Method Configuration
-- -----------------------------------------------------------------------------
-- Standard = Hosted payment page (redirect to 2Checkout)
-- Inline = Embedded checkout on WHMCS page

INSERT INTO tblpaymentgateways (gateway, setting, value, `order`) VALUES
('tco', 'checkoutMethod', 'Standard', 20),
('tco', 'paymentMethodTitle', 'Credit/Debit Card', 21);

-- -----------------------------------------------------------------------------
-- Section D: DEV Automation Settings for Fast Testing
-- -----------------------------------------------------------------------------
-- WARNING: These settings are for DEV/TESTING only!
-- Revert to production values before going live.

-- Enable automatic credit card processing
INSERT INTO tblconfiguration (setting, value) VALUES
('CCProcessEnabled', 'on')
ON DUPLICATE KEY UPDATE value = 'on';

-- Process payments 0 days before due (immediate for testing)
INSERT INTO tblconfiguration (setting, value) VALUES
('CCProcessDaysBeforeDue', '0')
ON DUPLICATE KEY UPDATE value = '0';

-- First reminder: 0 days after due (immediate)
INSERT INTO tblconfiguration (setting, value) VALUES
('CCDaySendFirstReminder', '0')
ON DUPLICATE KEY UPDATE value = '0';

-- Second reminder: 1 day after due
INSERT INTO tblconfiguration (setting, value) VALUES
('CCDaySendSecondReminder', '1')
ON DUPLICATE KEY UPDATE value = '1';

-- Third reminder: 2 days after due
INSERT INTO tblconfiguration (setting, value) VALUES
('CCDaySendThirdReminder', '2')
ON DUPLICATE KEY UPDATE value = '2';

-- Suspension grace period: 3 days after due
INSERT INTO tblconfiguration (setting, value) VALUES
('SuspensionGracePeriod', '3')
ON DUPLICATE KEY UPDATE value = '3';

-- -----------------------------------------------------------------------------
-- Section E: Verification Queries (run after setup to confirm)
-- -----------------------------------------------------------------------------

-- Verify 2Checkout gateway configuration
SELECT gateway, setting, value 
FROM tblpaymentgateways 
WHERE gateway = 'tco' 
ORDER BY `order`;

-- Verify automation settings
SELECT setting, value 
FROM tblconfiguration 
WHERE setting IN (
  'CCProcessEnabled', 
  'CCProcessDaysBeforeDue',
  'CCDaySendFirstReminder',
  'CCDaySendSecondReminder', 
  'CCDaySendThirdReminder',
  'SuspensionGracePeriod'
);

-- -----------------------------------------------------------------------------
-- Section F: IPN Callback URL Reference
-- -----------------------------------------------------------------------------
-- The IPN callback URL for 2Checkout is:
-- https://your-domain.com/modules/gateways/callback/tco.php
--
-- For local testing with a tunnel (cloudflared/ngrok):
-- https://your-tunnel-url/modules/gateways/callback/tco.php
--
-- Configure this URL in 2Checkout Dashboard:
-- 1. Log in to https://sandbox.2checkout.com/sandbox/
-- 2. Go to Notifications > Settings
-- 3. Enable IPN and enter the URL above
-- 4. Set the same Secret Word as configured in WHMCS

-- -----------------------------------------------------------------------------
-- Section G: Production Revert Script (save for later)
-- -----------------------------------------------------------------------------
/*
-- Run these commands before going to production:
UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCProcessDaysBeforeDue';
UPDATE tblconfiguration SET value = '3' WHERE setting = 'CCDaySendFirstReminder';
UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCDaySendSecondReminder';
UPDATE tblconfiguration SET value = '14' WHERE setting = 'CCDaySendThirdReminder';
UPDATE tblconfiguration SET value = '7' WHERE setting = 'SuspensionGracePeriod';

-- Switch 2Checkout to live mode:
UPDATE tblpaymentgateways SET value = '' WHERE gateway = 'tco' AND setting = 'testmode';
UPDATE tblpaymentgateways SET value = 'YOUR_LIVE_ACCOUNT_NUMBER' WHERE gateway = 'tco' AND setting = 'accountNumber';
UPDATE tblpaymentgateways SET value = 'YOUR_LIVE_SECRET_WORD' WHERE gateway = 'tco' AND setting = 'secretWord';

-- Update IPN URL in 2Checkout Live Dashboard:
-- https://www.2checkout.com/ (not sandbox)
*/

-- -----------------------------------------------------------------------------
-- Section H: Test Evidence Queries
-- -----------------------------------------------------------------------------

-- Check recent TCO transactions
SELECT id, invoiceid, amount, gateway, date, transid, description
FROM tblaccounts
WHERE gateway = 'tco'
ORDER BY id DESC LIMIT 10;

-- Check activity log for TCO-related entries
SELECT id, date, description, user, userid
FROM tblactivitylog
WHERE description LIKE '%2checkout%' OR description LIKE '%tco%'
ORDER BY id DESC LIMIT 10;

-- Check invoices paid via TCO
SELECT id, userid, status, total, paymentmethod, datepaid, duedate
FROM tblinvoices
WHERE paymentmethod = 'tco'
ORDER BY id DESC LIMIT 10;

-- Check services using TCO payment method
SELECT h.id, h.userid, h.packageid, h.domainstatus, h.nextduedate, h.paymentmethod,
       p.name as product_name
FROM tblhosting h
JOIN tblproducts p ON h.packageid = p.id
WHERE h.paymentmethod = 'tco'
ORDER BY h.id DESC LIMIT 10;

-- ============================================================================
-- End of 2Checkout Gateway Setup Script
-- ============================================================================

-- ============================================================================
-- Stripe Gateway Setup Script for WHMCS 8.10.1
-- ============================================================================
-- This script configures the Stripe payment gateway for TEST MODE operation.
-- 
-- IMPORTANT: This script contains PLACEHOLDER values for credentials.
-- You MUST replace the placeholder values with actual Stripe test credentials
-- from your Stripe Dashboard (https://dashboard.stripe.com/test/apikeys)
--
-- NEVER commit actual API keys to version control!
-- ============================================================================

-- -----------------------------------------------------------------------------
-- Section A: Enable Stripe Gateway
-- -----------------------------------------------------------------------------

-- Clear any existing Stripe configuration (fresh start)
DELETE FROM tblpaymentgateways WHERE gateway = 'stripe';

-- Insert basic Stripe gateway configuration
INSERT INTO tblpaymentgateways (gateway, setting, value, `order`) VALUES
('stripe', 'name', 'Credit Card (Stripe)', 0),
('stripe', 'type', 'CC', 1),
('stripe', 'visible', 'on', 2),
('stripe', 'testmode', 'on', 3),
('stripe', 'friendname', 'Credit/Debit Card', 4);

-- -----------------------------------------------------------------------------
-- Section B: Stripe Credentials (PLACEHOLDERS - REPLACE BEFORE RUNNING)
-- -----------------------------------------------------------------------------
-- Get your test API keys from: https://dashboard.stripe.com/test/apikeys
-- Get your webhook secret from: https://dashboard.stripe.com/test/webhooks

INSERT INTO tblpaymentgateways (gateway, setting, value, `order`) VALUES
-- REPLACE THESE PLACEHOLDERS WITH YOUR ACTUAL TEST KEYS:
('stripe', 'publishableKey', 'pk_test_YOUR_PUBLISHABLE_KEY_HERE', 10),
('stripe', 'secretKey', 'sk_test_YOUR_SECRET_KEY_HERE', 11),
('stripe', 'webhookSecret', 'whsec_YOUR_WEBHOOK_SECRET_HERE', 12);

-- -----------------------------------------------------------------------------
-- Section C: Tokenization Settings (for recurring payments)
-- -----------------------------------------------------------------------------

INSERT INTO tblpaymentgateways (gateway, setting, value, `order`) VALUES
('stripe', 'storePayMethod', 'on', 20),
('stripe', 'paymentMethodTitle', 'Credit/Debit Card', 21);

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

-- Verify Stripe gateway configuration
SELECT gateway, setting, value 
FROM tblpaymentgateways 
WHERE gateway = 'stripe' 
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
-- Section F: Production Revert Script (save for later)
-- -----------------------------------------------------------------------------
/*
-- Run these commands before going to production:
UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCProcessDaysBeforeDue';
UPDATE tblconfiguration SET value = '3' WHERE setting = 'CCDaySendFirstReminder';
UPDATE tblconfiguration SET value = '7' WHERE setting = 'CCDaySendSecondReminder';
UPDATE tblconfiguration SET value = '14' WHERE setting = 'CCDaySendThirdReminder';
UPDATE tblconfiguration SET value = '7' WHERE setting = 'SuspensionGracePeriod';

-- Switch Stripe to live mode:
UPDATE tblpaymentgateways SET value = '' WHERE gateway = 'stripe' AND setting = 'testmode';
UPDATE tblpaymentgateways SET value = 'pk_live_YOUR_LIVE_KEY' WHERE gateway = 'stripe' AND setting = 'publishableKey';
UPDATE tblpaymentgateways SET value = 'sk_live_YOUR_LIVE_KEY' WHERE gateway = 'stripe' AND setting = 'secretKey';
UPDATE tblpaymentgateways SET value = 'whsec_YOUR_LIVE_WEBHOOK_SECRET' WHERE gateway = 'stripe' AND setting = 'webhookSecret';
*/

-- ============================================================================
-- End of Stripe Gateway Setup Script
-- ============================================================================

-- =============================================================================
-- Venom Solutions - Production Seed
-- =============================================================================
-- Single comprehensive SQL to provision a fresh WHMCS instance with the full
-- Venom Solutions product catalog, pricing, currencies, gateways, support
-- departments, custom fields, configurable options, and email templates.
--
-- All statements use INSERT ... ON DUPLICATE KEY UPDATE for idempotency.
-- Safe to run multiple times on the same database.
--
-- Generated from live database state: 2026-02-25
-- =============================================================================

SET @now = NOW();

-- =============================================================================
-- 1. CURRENCIES (16 currencies, USD default)
-- =============================================================================

INSERT INTO `tblcurrencies` (`id`, `code`, `prefix`, `suffix`, `format`, `rate`, `default`)
VALUES
    (1,  'USD', '$',    ' USD', 2, '1.00000',   1),
    (2,  'EUR', '€',    ' EUR', 1, '0.92000',   0),
    (3,  'GBP', '£',    ' GBP', 1, '0.79000',   0),
    (4,  'TRY', '₺',    ' TRY', 1, '31.20000',  0),
    (5,  'RUB', '₽',    ' RUB', 1, '92.00000',  0),
    (6,  'BRL', 'R$',   ' BRL', 1, '4.95000',   0),
    (7,  'CNY', '¥',    ' CNY', 1, '7.20000',   0),
    (8,  'NOK', 'kr',   ' NOK', 1, '10.60000',  0),
    (9,  'DKK', 'kr',   ' DKK', 1, '6.86000',   0),
    (10, 'CZK', 'Kč',   ' CZK', 1, '23.20000',  0),
    (11, 'HUF', 'Ft',   ' HUF', 1, '361.00000', 0),
    (12, 'RON', 'lei',  ' RON', 1, '4.58000',   0),
    (13, 'MKD', 'ден',  ' MKD', 1, '56.80000',  0),
    (14, 'UAH', '₴',    ' UAH', 1, '39.50000',  0),
    (15, 'ILS', '₪',    ' ILS', 1, '3.68000',   0),
    (16, 'AZN', '₼',    ' AZN', 1, '1.70000',   0)
ON DUPLICATE KEY UPDATE
    `code`    = VALUES(`code`),
    `prefix`  = VALUES(`prefix`),
    `suffix`  = VALUES(`suffix`),
    `format`  = VALUES(`format`),
    `rate`    = VALUES(`rate`),
    `default` = VALUES(`default`);


-- =============================================================================
-- 2. PRODUCT GROUP
-- =============================================================================

INSERT INTO `tblproductgroups` (`id`, `name`, `slug`, `headline`, `tagline`, `orderfrmtpl`, `disabledgateways`, `hidden`, `order`, `icon`, `created_at`, `updated_at`)
VALUES (1, 'Venom Solutions Plans', 'venom-solutions-plans', 'IPTV Control Panel Licenses', 'Professional IPTV server management solutions', 'venom_cart', '', 0, 1, 'fa-server', @now, @now)
ON DUPLICATE KEY UPDATE
    `name`             = VALUES(`name`),
    `slug`             = VALUES(`slug`),
    `headline`         = VALUES(`headline`),
    `tagline`          = VALUES(`tagline`),
    `orderfrmtpl`      = VALUES(`orderfrmtpl`),
    `disabledgateways` = VALUES(`disabledgateways`),
    `hidden`           = VALUES(`hidden`),
    `order`            = VALUES(`order`),
    `icon`             = VALUES(`icon`),
    `updated_at`       = @now;


-- =============================================================================
-- 3. PRODUCTS
-- =============================================================================

-- Trial: $50 one-time, auto-terminates after 7 days, no LBs
INSERT INTO `tblproducts` (
    `id`, `type`, `gid`, `name`, `slug`, `description`,
    `hidden`, `showdomainoptions`, `stockcontrol`,
    `proratabilling`, `proratadate`, `proratachargenextmonth`,
    `paytype`, `allowqty`, `subdomain`, `autosetup`, `servertype`, `servergroup`,
    `configoption1`, `configoption2`, `configoption3`, `configoption4`, `configoption5`, `configoption6`,
    `configoption7`, `configoption8`, `configoption9`, `configoption10`, `configoption11`, `configoption12`,
    `configoption13`, `configoption14`, `configoption15`, `configoption16`, `configoption17`, `configoption18`,
    `configoption19`, `configoption20`, `configoption21`, `configoption22`, `configoption23`, `configoption24`,
    `freedomain`, `freedomainpaymentterms`, `freedomaintlds`, `recurringcycles`,
    `autoterminatedays`, `configoptionsupgrade`, `billingcycleupgrade`,
    `overagesenabled`, `overagesdisklimit`, `overagesbwlimit`, `overagesdiskprice`, `overagesbwprice`,
    `tax`, `affiliateonetime`, `affiliatepaytype`, `affiliatepayamount`,
    `order`, `retired`, `is_featured`, `color`, `tagline`, `short_description`,
    `created_at`, `updated_at`
) VALUES (
    1, 'other', 1, 'Trial', 'trial',
    '<ul><li><strong>Duration:</strong> 1 Week</li><li><strong>Main Server:</strong> Included</li><li><strong>Load Balancers:</strong> NOT Allowed</li><li><strong>Support:</strong> Email</li></ul><p class=\"text-warning\"><strong>Note:</strong> Load balancers are not available with Trial plan.</p>',
    0, 0, 0,
    0, 0, 0,
    'onetime', 0, '', '', '', 0,
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', 0,
    7, 0, '',
    '', 0, 0, 0.0000, 0.0000,
    0, 0, '', 0.00,
    1, 0, 0, '#6c757d', 'Perfect for testing', '1 Week Trial - Main Server Only',
    @now, @now
) ON DUPLICATE KEY UPDATE
    `type` = VALUES(`type`), `gid` = VALUES(`gid`), `name` = VALUES(`name`), `slug` = VALUES(`slug`),
    `description` = VALUES(`description`), `hidden` = VALUES(`hidden`), `retired` = VALUES(`retired`),
    `paytype` = VALUES(`paytype`), `autoterminatedays` = VALUES(`autoterminatedays`),
    `configoptionsupgrade` = VALUES(`configoptionsupgrade`), `is_featured` = VALUES(`is_featured`),
    `color` = VALUES(`color`), `tagline` = VALUES(`tagline`),
    `short_description` = VALUES(`short_description`), `order` = VALUES(`order`), `updated_at` = @now;

-- Pro: $100/mo recurring, 1 free LB, featured, extra LBs via config options
INSERT INTO `tblproducts` (
    `id`, `type`, `gid`, `name`, `slug`, `description`,
    `hidden`, `showdomainoptions`, `stockcontrol`,
    `proratabilling`, `proratadate`, `proratachargenextmonth`,
    `paytype`, `allowqty`, `subdomain`, `autosetup`, `servertype`, `servergroup`,
    `configoption1`, `configoption2`, `configoption3`, `configoption4`, `configoption5`, `configoption6`,
    `configoption7`, `configoption8`, `configoption9`, `configoption10`, `configoption11`, `configoption12`,
    `configoption13`, `configoption14`, `configoption15`, `configoption16`, `configoption17`, `configoption18`,
    `configoption19`, `configoption20`, `configoption21`, `configoption22`, `configoption23`, `configoption24`,
    `freedomain`, `freedomainpaymentterms`, `freedomaintlds`, `recurringcycles`,
    `autoterminatedays`, `configoptionsupgrade`, `billingcycleupgrade`,
    `overagesenabled`, `overagesdisklimit`, `overagesbwlimit`, `overagesdiskprice`, `overagesbwprice`,
    `tax`, `affiliateonetime`, `affiliatepaytype`, `affiliatepayamount`,
    `order`, `retired`, `is_featured`, `color`, `tagline`, `short_description`,
    `created_at`, `updated_at`
) VALUES (
    2, 'other', 1, 'Pro', 'pro',
    '<ul><li><strong>Duration:</strong> 1 Month</li><li><strong>Main Server:</strong> Included</li><li><strong>Load Balancers:</strong> 1 Free LB Included</li><li><strong>Extra LBs:</strong> $10/month each</li><li><strong>Support:</strong> Priority Email + Chat</li></ul>',
    0, 0, 0,
    0, 0, 0,
    'recurring', 0, '', '', '', 0,
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', 0,
    0, 1, '',
    '', 0, 0, 0.0000, 0.0000,
    0, 0, '', 0.00,
    2, 0, 1, '#0d6efd', 'Most Popular', '1 Month - Main Server + 1 Free LB',
    @now, @now
) ON DUPLICATE KEY UPDATE
    `type` = VALUES(`type`), `gid` = VALUES(`gid`), `name` = VALUES(`name`), `slug` = VALUES(`slug`),
    `description` = VALUES(`description`), `hidden` = VALUES(`hidden`), `retired` = VALUES(`retired`),
    `paytype` = VALUES(`paytype`), `autoterminatedays` = VALUES(`autoterminatedays`),
    `configoptionsupgrade` = VALUES(`configoptionsupgrade`), `is_featured` = VALUES(`is_featured`),
    `color` = VALUES(`color`), `tagline` = VALUES(`tagline`),
    `short_description` = VALUES(`short_description`), `order` = VALUES(`order`), `updated_at` = @now;

-- Ultra: $299/mo recurring, unlimited LBs
INSERT INTO `tblproducts` (
    `id`, `type`, `gid`, `name`, `slug`, `description`,
    `hidden`, `showdomainoptions`, `stockcontrol`,
    `proratabilling`, `proratadate`, `proratachargenextmonth`,
    `paytype`, `allowqty`, `subdomain`, `autosetup`, `servertype`, `servergroup`,
    `configoption1`, `configoption2`, `configoption3`, `configoption4`, `configoption5`, `configoption6`,
    `configoption7`, `configoption8`, `configoption9`, `configoption10`, `configoption11`, `configoption12`,
    `configoption13`, `configoption14`, `configoption15`, `configoption16`, `configoption17`, `configoption18`,
    `configoption19`, `configoption20`, `configoption21`, `configoption22`, `configoption23`, `configoption24`,
    `freedomain`, `freedomainpaymentterms`, `freedomaintlds`, `recurringcycles`,
    `autoterminatedays`, `configoptionsupgrade`, `billingcycleupgrade`,
    `overagesenabled`, `overagesdisklimit`, `overagesbwlimit`, `overagesdiskprice`, `overagesbwprice`,
    `tax`, `affiliateonetime`, `affiliatepaytype`, `affiliatepayamount`,
    `order`, `retired`, `is_featured`, `color`, `tagline`, `short_description`,
    `created_at`, `updated_at`
) VALUES (
    3, 'other', 1, 'Ultra', 'ultra',
    '<ul><li><strong>Duration:</strong> 1 Month</li><li><strong>Main Server:</strong> Included</li><li><strong>Load Balancers:</strong> UNLIMITED</li><li><strong>Support:</strong> Priority 24/7</li></ul>',
    0, 0, 0,
    0, 0, 0,
    'recurring', 0, '', '', '', 0,
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', '', '', '',
    '', '', '', 0,
    0, 0, '',
    '', 0, 0, 0.0000, 0.0000,
    0, 0, '', 0.00,
    3, 0, 0, '#6f42c1', 'Unlimited Power', '1 Month - Main Server + Unlimited LBs',
    @now, @now
) ON DUPLICATE KEY UPDATE
    `type` = VALUES(`type`), `gid` = VALUES(`gid`), `name` = VALUES(`name`), `slug` = VALUES(`slug`),
    `description` = VALUES(`description`), `hidden` = VALUES(`hidden`), `retired` = VALUES(`retired`),
    `paytype` = VALUES(`paytype`), `autoterminatedays` = VALUES(`autoterminatedays`),
    `configoptionsupgrade` = VALUES(`configoptionsupgrade`), `is_featured` = VALUES(`is_featured`),
    `color` = VALUES(`color`), `tagline` = VALUES(`tagline`),
    `short_description` = VALUES(`short_description`), `order` = VALUES(`order`), `updated_at` = @now;


-- =============================================================================
-- 4. PRODUCT PRICING (USD only, monthly cycle)
-- =============================================================================

INSERT INTO `tblpricing` (`id`, `type`, `currency`, `relid`, `msetupfee`, `qsetupfee`, `ssetupfee`, `asetupfee`, `bsetupfee`, `tsetupfee`, `monthly`, `quarterly`, `semiannually`, `annually`, `biennially`, `triennially`)
VALUES
    (1, 'product', 1, 1, '0.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00', '50.00',  '-1.00', '-1.00', '-1.00', '-1.00', '-1.00'),
    (2, 'product', 1, 2, '0.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00', '100.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00'),
    (4, 'product', 1, 3, '0.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00', '299.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00')
ON DUPLICATE KEY UPDATE
    `type`         = VALUES(`type`),
    `currency`     = VALUES(`currency`),
    `relid`        = VALUES(`relid`),
    `msetupfee`    = VALUES(`msetupfee`),
    `monthly`      = VALUES(`monthly`),
    `quarterly`    = VALUES(`quarterly`),
    `semiannually` = VALUES(`semiannually`),
    `annually`     = VALUES(`annually`),
    `biennially`   = VALUES(`biennially`),
    `triennially`  = VALUES(`triennially`);


-- =============================================================================
-- 5. PRODUCT SLUGS (SEO-friendly URLs)
-- =============================================================================

INSERT INTO `tblproducts_slugs` (`id`, `product_id`, `group_id`, `group_slug`, `slug`, `active`, `created_at`, `updated_at`)
VALUES
    (1, 1, 1, 'venom-solutions-plans', 'trial-plan-7-days', 1, @now, @now),
    (2, 2, 1, 'venom-solutions-plans', 'monthly-access',    1, @now, @now),
    (3, 3, 1, 'venom-solutions-plans', 'ultra',             1, @now, @now)
ON DUPLICATE KEY UPDATE
    `product_id` = VALUES(`product_id`),
    `group_id`   = VALUES(`group_id`),
    `group_slug` = VALUES(`group_slug`),
    `slug`       = VALUES(`slug`),
    `active`     = VALUES(`active`),
    `updated_at` = @now;


-- =============================================================================
-- 6. ADDON: Additional Load Balancer
-- =============================================================================

INSERT INTO `tbladdons` (`id`, `packages`, `name`, `description`, `billingcycle`, `allowqty`, `tax`, `showorder`, `hidden`, `retired`, `downloads`, `autoactivate`, `suspendproduct`, `welcomeemail`, `type`, `module`, `server_group_id`, `prorate`, `weight`, `autolinkby`, `created_at`, `updated_at`)
VALUES (1, '1,2', 'Additional Load Balancer', 'Add extra load balancers to improve stability under peak load and optimize routing for a smoother experience.', 'recurring', 1, 0, 1, 0, 0, '', '', 0, 0, '', '', 0, 0, 0, '', @now, @now)
ON DUPLICATE KEY UPDATE
    `packages`    = VALUES(`packages`),
    `name`        = VALUES(`name`),
    `description` = VALUES(`description`),
    `billingcycle` = VALUES(`billingcycle`),
    `allowqty`    = VALUES(`allowqty`),
    `showorder`   = VALUES(`showorder`),
    `hidden`      = VALUES(`hidden`),
    `retired`     = VALUES(`retired`),
    `updated_at`  = @now;

-- Addon pricing: $10/mo, $30/qtr, $60/semi, $120/yr
INSERT INTO `tblpricing` (`id`, `type`, `currency`, `relid`, `msetupfee`, `qsetupfee`, `ssetupfee`, `asetupfee`, `bsetupfee`, `tsetupfee`, `monthly`, `quarterly`, `semiannually`, `annually`, `biennially`, `triennially`)
VALUES (3, 'addon', 1, 1, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '10.00', '30.00', '60.00', '120.00', '-1.00', '-1.00')
ON DUPLICATE KEY UPDATE
    `type`         = VALUES(`type`),
    `currency`     = VALUES(`currency`),
    `relid`        = VALUES(`relid`),
    `monthly`      = VALUES(`monthly`),
    `quarterly`    = VALUES(`quarterly`),
    `semiannually` = VALUES(`semiannually`),
    `annually`     = VALUES(`annually`),
    `biennially`   = VALUES(`biennially`),
    `triennially`  = VALUES(`triennially`);


-- =============================================================================
-- 7. CONFIGURABLE OPTIONS: Extra Load Balancers (Pro plan only)
-- =============================================================================

INSERT INTO `tblproductconfiggroups` (`id`, `name`, `description`)
VALUES (1, 'Extra Load Balancers', 'Add extra load balancers to your Pro plan - $10/month each')
ON DUPLICATE KEY UPDATE
    `name`        = VALUES(`name`),
    `description` = VALUES(`description`);

INSERT IGNORE INTO `tblproductconfiglinks` (`gid`, `pid`) VALUES (1, 2);

INSERT INTO `tblproductconfigoptions` (`id`, `gid`, `optionname`, `optiontype`, `qtyminimum`, `qtymaximum`, `order`, `hidden`)
VALUES (1, 1, 'Extra Load Balancers|Extra Load Balancers', 4, 0, 100, 1, 0)
ON DUPLICATE KEY UPDATE
    `optionname`  = VALUES(`optionname`),
    `optiontype`  = VALUES(`optiontype`),
    `qtyminimum`  = VALUES(`qtyminimum`),
    `qtymaximum`  = VALUES(`qtymaximum`);

INSERT IGNORE INTO `tblproductconfigoptionssub` (`id`, `configid`, `optionname`, `sortorder`, `hidden`)
VALUES (1, 1, '1', 0, 0);

-- Config option pricing: $10/mo per unit
INSERT INTO `tblpricing` (`id`, `type`, `currency`, `relid`, `msetupfee`, `qsetupfee`, `ssetupfee`, `asetupfee`, `bsetupfee`, `tsetupfee`, `monthly`, `quarterly`, `semiannually`, `annually`, `biennially`, `triennially`)
VALUES (5, 'configoptions', 1, 1, '0.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00', '10.00', '-1.00', '-1.00', '-1.00', '-1.00', '-1.00')
ON DUPLICATE KEY UPDATE
    `type`     = VALUES(`type`),
    `currency` = VALUES(`currency`),
    `relid`    = VALUES(`relid`),
    `monthly`  = VALUES(`monthly`);


-- =============================================================================
-- 8. CUSTOM FIELDS (5 fields per product for Trial and Pro)
-- =============================================================================

-- Trial (product_id=1)
INSERT INTO `tblcustomfields` (`id`, `type`, `relid`, `fieldname`, `fieldtype`, `description`, `fieldoptions`, `regexpr`, `adminonly`, `required`, `showorder`, `showinvoice`, `sortorder`, `created_at`, `updated_at`)
VALUES
    (1,  'product', 1, 'Server URL',       'text', '', '', '', '', '', '', '', 1, @now, @now),
    (2,  'product', 1, 'Username',          'text', '', '', '', '', '', '', '', 2, @now, @now),
    (3,  'product', 1, 'Password',          'text', '', '', '', '', '', '', '', 3, @now, @now),
    (4,  'product', 1, 'M3U Playlist URL',  'text', '', '', '', '', '', '', '', 4, @now, @now),
    (5,  'product', 1, 'EPG URL',           'text', '', '', '', '', '', '', '', 5, @now, @now)
ON DUPLICATE KEY UPDATE
    `fieldname` = VALUES(`fieldname`),
    `fieldtype` = VALUES(`fieldtype`),
    `sortorder` = VALUES(`sortorder`),
    `updated_at` = @now;

-- Pro (product_id=2)
INSERT INTO `tblcustomfields` (`id`, `type`, `relid`, `fieldname`, `fieldtype`, `description`, `fieldoptions`, `regexpr`, `adminonly`, `required`, `showorder`, `showinvoice`, `sortorder`, `created_at`, `updated_at`)
VALUES
    (6,  'product', 2, 'Server URL',       'text', '', '', '', '', '', '', '', 1, @now, @now),
    (7,  'product', 2, 'Username',          'text', '', '', '', '', '', '', '', 2, @now, @now),
    (8,  'product', 2, 'Password',          'text', '', '', '', '', '', '', '', 3, @now, @now),
    (9,  'product', 2, 'M3U Playlist URL',  'text', '', '', '', '', '', '', '', 4, @now, @now),
    (10, 'product', 2, 'EPG URL',           'text', '', '', '', '', '', '', '', 5, @now, @now)
ON DUPLICATE KEY UPDATE
    `fieldname` = VALUES(`fieldname`),
    `fieldtype` = VALUES(`fieldtype`),
    `sortorder` = VALUES(`sortorder`),
    `updated_at` = @now;


-- =============================================================================
-- 9. EMAIL TEMPLATE: Product Welcome Email
-- =============================================================================

INSERT INTO `tblemailtemplates` (`id`, `type`, `name`, `subject`, `message`, `attachments`, `fromname`, `fromemail`, `disabled`, `custom`, `language`, `copyto`, `blind_copy_to`, `plaintext`, `created_at`, `updated_at`)
VALUES (105, 'product', 'Venom Solutions Service Welcome Email', 'Your Venom Solutions Service Details',
    'Hello {$client_name},\n\nWelcome to Venom Solutions. Your service is now active.\nYou can find all credentials and connection details in the Client Area under Services.\n\nClient Area: {$whmcs_url}/clientarea.php?action=products\n\nIf you need any assistance, please open a ticket with Technical Support.\n\nRegards,\nVenom Solutions Team',
    '', '', '', 0, 1, 'english', '', '', 1, @now, @now)
ON DUPLICATE KEY UPDATE
    `name`      = VALUES(`name`),
    `subject`   = VALUES(`subject`),
    `message`   = VALUES(`message`),
    `disabled`  = VALUES(`disabled`),
    `custom`    = VALUES(`custom`),
    `language`  = VALUES(`language`),
    `plaintext` = VALUES(`plaintext`),
    `updated_at` = @now;


-- =============================================================================
-- 10. TICKET DEPARTMENTS
-- =============================================================================

INSERT INTO `tblticketdepartments` (`id`, `name`, `description`, `email`, `clientsonly`, `piperepliesonly`, `noautoresponder`, `hidden`, `order`, `host`, `port`, `login`, `password`, `mail_auth_config`, `feedback_request`, `prevent_client_closure`)
VALUES
    (1, 'General Enquiries',  'All Enquiries',                                       'admin@venom-drm.com',            '', '', '', '', 1, '', '', '', '', '', 0, 0),
    (2, 'Technical Support',  'Technical assistance for Venom Solutions services.',   'support@venom-solutions.test',   '', '', '', '', 2, '', '', '', '', '', 0, 0),
    (3, 'Billing Support',    'Billing and payment support for Venom Solutions services.', 'billing@venom-solutions.test', '', '', '', '', 3, '', '', '', '', '', 0, 0)
ON DUPLICATE KEY UPDATE
    `name`        = VALUES(`name`),
    `description` = VALUES(`description`),
    `email`       = VALUES(`email`),
    `hidden`      = VALUES(`hidden`),
    `order`       = VALUES(`order`);


-- =============================================================================
-- 11. PAYMENT GATEWAY: Bank Transfer
-- =============================================================================

INSERT INTO `tblpaymentgateways` (`id`, `gateway`, `setting`, `value`, `order`)
VALUES
    (3, 'banktransfer', 'name',         'Bank Transfer', 1),
    (4, 'banktransfer', 'type',         'Invoices',      0),
    (5, 'banktransfer', 'visible',      'on',            0),
    (6, 'banktransfer', 'instructions', 'After placing your order, contact billing to complete payment.', 0)
ON DUPLICATE KEY UPDATE
    `gateway` = VALUES(`gateway`),
    `setting` = VALUES(`setting`),
    `value`   = VALUES(`value`),
    `order`   = VALUES(`order`);


-- =============================================================================
-- Done.
-- =============================================================================
-- Product Catalog:
--   Trial  : $50   one-time  (auto-terminates after 7 days, no LBs)
--   Pro    : $100  /month    (1 free LB, extra LBs $10/mo each, featured)
--   Ultra  : $299  /month    (unlimited LBs)
--
-- Addon: Additional Load Balancer ($10/mo, $30/qtr, $60/semi, $120/yr)
-- Config Option: Extra Load Balancers (Pro plan only, quantity 0-100)
-- Currencies: 16 (USD default)
-- Gateway: Bank Transfer
-- Departments: General Enquiries, Technical Support, Billing Support
-- =============================================================================

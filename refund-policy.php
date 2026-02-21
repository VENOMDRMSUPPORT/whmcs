<?php
/**
 * VENOM DRM - Refund Policy Page
 * 
 * @package VENOM_DRM
 * @location refund-policy.php
 */

define('CLIENTAREA', true);

require __DIR__ . '/init.php';

use WHMCS\ClientArea;

$ca = new ClientArea();

$ca->setPageTitle('Refund Policy');

$ca->addToBreadCrumb('index.php', Lang::trans('globalsystemname'));
$ca->addToBreadCrumb('refund-policy.php', 'Refund Policy');

$ca->initPage();

/**
 * Refund Policy Content
 */
$refundContent = <<<HTML
<div class="refund-content" style="max-width: 900px; margin: 0 auto; padding: 2rem;">

    <h1 style="margin-bottom: 1.5rem; color: #e4e6f0;">Refund Policy</h1>
    
    <p style="color: #7a849a; margin-bottom: 2rem;">
        <strong>Last Updated:</strong> February 2026<br>
        <strong>Effective Date:</strong> February 2026
    </p>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">1. Overview</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            This Refund Policy outlines the terms under which VENOM Solutions issues refunds for software license purchases. By purchasing a license, you agree to this policy.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">2. Demo License (7-Day Trial)</h2>
        <div style="background: rgba(0, 212, 170, 0.1); border-left: 4px solid #00d4aa; padding: 1rem; margin-bottom: 1rem;">
            <p style="color: #a0a8b8; line-height: 1.7; margin: 0;">
                <strong>Demo License purchases are NON-REFUNDABLE.</strong>
            </p>
        </div>
        <p style="color: #a0a8b8; line-height: 1.7;">
            The 7-Day Demo License is a one-time, non-recurring purchase designed to let you evaluate our software before committing to a full license. Due to the low cost ($50) and time-limited nature of this product:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>No refunds will be issued for demo purchases</li>
            <li>Demo licenses cannot be extended beyond 7 days</li>
            <li>The $50 demo fee is not credited toward a Main License upgrade</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">3. Main Server License</h2>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">3.1 24-Hour Cancellation Window</h3>
        <p style="color: #a0a8b8; line-height: 1.7;">
            You may request a full refund within <strong>24 hours</strong> of your initial Main License purchase, provided:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>You have not activated or used the license in production</li>
            <li>You submit the refund request via our support portal</li>
            <li>No technical support has been provided beyond initial setup assistance</li>
        </ul>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">3.2 After 24 Hours</h3>
        <p style="color: #a0a8b8; line-height: 1.7;">
            After the 24-hour window, refunds are <strong>not available</strong> for:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Services that have been used or activated</li>
            <li>Renewal payments (auto-renewals)</li>
            <li>Partial billing periods</li>
            <li>Services suspended for Terms of Service violations</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">4. Service Interruptions</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            If our licensing portal experiences significant downtime (exceeding 24 consecutive hours) that prevents license validation, you may be eligible for:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Service credit applied to your account</li>
            <li>Billing cycle extension</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            <strong>Note:</strong> This applies only to our licensing portal availability, not to your own server infrastructure or streaming availability.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">5. Cancellation vs. Refund</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            You may <strong>cancel</strong> your license at any time to prevent future billing. Cancellation:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Stops automatic renewal</li>
            <li>Does not refund the current billing period</li>
            <li>Allows you to use the license until the end of the paid period</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            To cancel, log into your <a href="/clientarea.php" style="color: #6c63ff;">Client Area</a>, navigate to My Licenses, select the service, and request cancellation.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">6. Chargebacks</h2>
        <div style="background: rgba(240, 82, 82, 0.1); border-left: 4px solid #f05252; padding: 1rem; margin-bottom: 1rem;">
            <p style="color: #a0a8b8; line-height: 1.7; margin: 0;">
                <strong>Warning:</strong> Filing a chargeback without first contacting our support team will result in immediate account suspension and potential permanent ban.
            </p>
        </div>
        <p style="color: #a0a8b8; line-height: 1.7;">
            If you have a billing dispute, please contact us via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a> first. We will work with you to resolve the issue.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">7. How to Request a Refund</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            To request a refund (within the 24-hour window):
        </p>
        <ol style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Log into your <a href="/clientarea.php" style="color: #6c63ff;">Client Area</a></li>
            <li>Open a support ticket with the subject "Refund Request"</li>
            <li>Include your invoice number and reason for the request</li>
            <li>Our team will review and respond within 1-2 business days</li>
        </ol>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">8. Refund Processing</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Approved refunds will be processed using the original payment method within 5-10 business days. Processing times may vary depending on your payment provider.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">9. Policy Changes</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We reserve the right to modify this Refund Policy at any time. Changes will be posted on this page with an updated "Last Updated" date.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">10. Contact</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            For questions about this Refund Policy, please contact us via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a>.
        </p>
    </section>

</div>
HTML;

$ca->assign('refundContent', $refundContent);
$ca->setTemplate('refund-policy');

$ca->output();

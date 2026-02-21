<?php
/**
 * VENOM DRM - Terms of Service Page
 * 
 * @package VENOM_DRM
 * @location terms-of-service.php
 */

define('CLIENTAREA', true);

require __DIR__ . '/init.php';

use WHMCS\ClientArea;
use WHMCS\Database\Capsule;

$ca = new ClientArea();

$ca->setPageTitle('Terms of Service');

$ca->addToBreadCrumb('index.php', Lang::trans('globalsystemname'));
$ca->addToBreadCrumb('terms-of-service.php', 'Terms of Service');

$ca->initPage();

/**
 * Terms of Service Content
 */
$termsContent = <<<HTML
<div class="terms-content" style="max-width: 900px; margin: 0 auto; padding: 2rem;">

    <h1 style="margin-bottom: 1.5rem; color: #e4e6f0;">Terms of Service</h1>
    
    <p style="color: #7a849a; margin-bottom: 2rem;">
        <strong>Last Updated:</strong> February 2026<br>
        <strong>Effective Date:</strong> February 2026
    </p>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">1. Agreement to Terms</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            By accessing or using VENOM Solutions software licensing services ("Services"), you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, you may not access or use the Services.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            These Terms constitute a legally binding agreement between you and VENOM Solutions ("Company," "we," "us," or "our") governing your use of our software licensing portal and services.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">2. Description of Services</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            VENOM Solutions provides <strong>software licensing services only</strong>. Our Services include:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Server management software licenses</li>
            <li>Load balancer licensing</li>
            <li>Technical support for licensed software</li>
            <li>Software updates and patches (for active licenses)</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            <strong>Important:</strong> Our licenses cover software only. We do not provide, host, transmit, or have access to any content, media, streaming data, or user materials. You are solely responsible for any content you deploy using our licensed software.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">3. License Grant</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Subject to your compliance with these Terms and payment of applicable fees, VENOM Solutions grants you a limited, non-exclusive, non-transferable, revocable license to use our software in accordance with your purchased license tier.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            You may not:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Reverse engineer, decompile, or disassemble the software</li>
            <li>Redistribute, sell, lease, or sublicense the software</li>
            <li>Use the software for any unlawful purpose</li>
            <li>Remove or alter any proprietary notices</li>
            <li>Use the software beyond the scope of your license tier</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">4. Payment Terms</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            License fees are due in advance of the service period. You agree to pay all fees associated with your license, including:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Base license fees (monthly, quarterly, semi-annual, or annual)</li>
            <li>Additional load balancer fees ($10/month per unit)</li>
            <li>Any applicable taxes</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            Demo licenses are one-time payments and do not automatically renew. Full licenses renew automatically based on your selected billing cycle unless cancelled.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">5. Service Level</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We strive to maintain high availability of our licensing portal. However, we do not guarantee uninterrupted access. Scheduled maintenance will be communicated in advance when possible.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            <strong>Note:</strong> The availability of your streaming server infrastructure is your responsibility. Our cloud portal manages license validation only and does not affect your streaming availability.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">6. Termination</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We may suspend or terminate your license if you:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Violate these Terms</li>
            <li>Fail to pay applicable fees</li>
            <li>Use the software for unlawful purposes</li>
            <li>Engage in abuse of our services (see Acceptable Use Policy)</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            Upon termination, your license will be deactivated and you must cease using the software immediately.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">7. Disclaimer of Warranties</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            THE SOFTWARE AND SERVICES ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            WE DO NOT WARRANT THAT THE SOFTWARE WILL BE ERROR-FREE, UNINTERRUPTED, OR COMPATIBLE WITH YOUR SPECIFIC INFRASTRUCTURE.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">8. Limitation of Liability</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            IN NO EVENT SHALL VENOM SOLUTIONS BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, INCLUDING BUT NOT LIMITED TO LOSS OF PROFITS, DATA, OR BUSINESS OPPORTUNITIES, REGARDLESS OF THE CAUSE OF ACTION.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Our total liability shall not exceed the amount you paid for the license in the twelve (12) months preceding the claim.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">9. Changes to Terms</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We reserve the right to modify these Terms at any time. Material changes will be communicated via email to the address on file. Continued use of the Services after changes constitutes acceptance of the modified Terms.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">10. Governing Law</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            These Terms shall be governed by and construed in accordance with applicable laws, without regard to conflict of law principles.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">11. Contact</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            For questions about these Terms, please contact us via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a>.
        </p>
    </section>

</div>
HTML;

$ca->assign('termsContent', $termsContent);

// Set template
$ca->setTemplate('terms-of-service');

$ca->output();

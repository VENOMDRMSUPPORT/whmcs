<?php
/**
 * VENOM DRM - Privacy Policy Page
 * 
 * @package VENOM_DRM
 * @location privacy-policy.php
 */

define('CLIENTAREA', true);

require __DIR__ . '/init.php';

use WHMCS\ClientArea;

$ca = new ClientArea();

$ca->setPageTitle('Privacy Policy');

$ca->addToBreadCrumb('index.php', Lang::trans('globalsystemname'));
$ca->addToBreadCrumb('privacy-policy.php', 'Privacy Policy');

$ca->initPage();

/**
 * Privacy Policy Content
 */
$privacyContent = <<<HTML
<div class="privacy-content" style="max-width: 900px; margin: 0 auto; padding: 2rem;">

    <h1 style="margin-bottom: 1.5rem; color: #e4e6f0;">Privacy Policy</h1>
    
    <p style="color: #7a849a; margin-bottom: 2rem;">
        <strong>Last Updated:</strong> February 2026<br>
        <strong>Effective Date:</strong> February 2026
    </p>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">1. Introduction</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            VENOM Solutions ("we," "us," or "our") respects your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our software licensing services.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Please read this Privacy Policy carefully. By using our Services, you consent to the practices described in this policy.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">2. Information We Collect</h2>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">2.1 Account Information</h3>
        <p style="color: #a0a8b8; line-height: 1.7;">
            When you create an account, we collect:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Full name</li>
            <li>Email address</li>
            <li>Billing address (country, state, city, postal code)</li>
            <li>Phone number (optional)</li>
            <li>Company name (if applicable)</li>
        </ul>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">2.2 Payment Information</h3>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We collect payment information necessary to process your license purchases. Sensitive payment data (credit card numbers) is processed and stored by our payment processors (2Checkout, etc.) and is not stored on our servers.
        </p>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">2.3 Technical Information</h3>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We automatically collect:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>IP address</li>
            <li>Browser type and version</li>
            <li>Device information</li>
            <li>Usage logs and access timestamps</li>
            <li>License validation requests</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">3. How We Use Your Information</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We use your information to:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Process and manage your software licenses</li>
            <li>Handle billing and payment processing</li>
            <li>Validate license authenticity</li>
            <li>Provide technical support</li>
            <li>Send service-related communications (invoices, renewal reminders)</li>
            <li>Improve our services and user experience</li>
            <li>Comply with legal obligations</li>
            <li>Prevent fraud and abuse</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">4. Information Sharing</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We do <strong>not</strong> sell, rent, or trade your personal information. We may share your information only in the following circumstances:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li><strong>Service Providers:</strong> With third-party payment processors and email delivery services necessary to operate our business</li>
            <li><strong>Legal Requirements:</strong> When required by law, court order, or government request</li>
            <li><strong>Business Transfers:</strong> In connection with a merger, acquisition, or sale of assets</li>
            <li><strong>Protection:</strong> To protect our rights, privacy, safety, or property</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">5. Data Security</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We implement appropriate technical and organizational measures to protect your personal information, including:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Encryption of data in transit (HTTPS/TLS)</li>
            <li>Secure password hashing</li>
            <li>Access controls and authentication</li>
            <li>Regular security assessments</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            However, no method of transmission over the Internet is 100% secure. We cannot guarantee absolute security.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">6. Data Retention</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We retain your personal information for as long as necessary to:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Provide our services to you</li>
            <li>Comply with legal obligations</li>
            <li>Resolve disputes</li>
            <li>Enforce our agreements</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            Upon account deletion, we will anonymize or delete your personal information, except where retention is required by law.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">7. Your Rights</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Depending on your location, you may have the right to:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Access your personal information</li>
            <li>Correct inaccurate data</li>
            <li>Request deletion of your data</li>
            <li>Object to or restrict processing</li>
            <li>Data portability</li>
            <li>Withdraw consent</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            To exercise these rights, please contact us via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a>.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">8. Cookies</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We use cookies and similar technologies to:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Authenticate your session</li>
            <li>Remember your preferences</li>
            <li>Analyze site usage</li>
        </ul>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            You can manage cookie preferences through your browser settings.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">9. Third-Party Links</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Our services may contain links to third-party websites. We are not responsible for the privacy practices of these external sites. We encourage you to review their privacy policies.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">10. Children's Privacy</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Our services are not intended for individuals under the age of 18. We do not knowingly collect personal information from children.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">11. Changes to This Policy</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the new policy on this page and updating the "Last Updated" date.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">12. Contact</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            For questions about this Privacy Policy or to exercise your rights, please contact us via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a>.
        </p>
    </section>

</div>
HTML;

$ca->assign('privacyContent', $privacyContent);
$ca->setTemplate('privacy-policy');

$ca->output();

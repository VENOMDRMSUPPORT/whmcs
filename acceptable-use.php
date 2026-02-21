<?php
/**
 * VENOM DRM - Acceptable Use / Anti-Abuse Policy Page
 * 
 * @package VENOM_DRM
 * @location acceptable-use.php
 */

define('CLIENTAREA', true);

require __DIR__ . '/init.php';

use WHMCS\ClientArea;

$ca = new ClientArea();

$ca->setPageTitle('Acceptable Use Policy');

$ca->addToBreadCrumb('index.php', Lang::trans('globalsystemname'));
$ca->addToBreadCrumb('acceptable-use.php', 'Acceptable Use Policy');

$ca->initPage();

/**
 * Acceptable Use Policy Content
 */
$acceptableUseContent = <<<HTML
<div class="acceptable-use-content" style="max-width: 900px; margin: 0 auto; padding: 2rem;">

    <h1 style="margin-bottom: 1.5rem; color: #e4e6f0;">Acceptable Use Policy</h1>
    
    <p style="color: #7a849a; margin-bottom: 2rem;">
        <strong>Last Updated:</strong> February 2026<br>
        <strong>Effective Date:</strong> February 2026
    </p>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">1. Purpose</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            This Acceptable Use Policy ("AUP") defines the rules and restrictions for using VENOM Solutions software licensing services. By using our Services, you agree to comply with this policy.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Violations of this AUP may result in suspension or termination of your license without refund.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">2. Software-Only License</h2>
        <div style="background: rgba(108, 99, 255, 0.1); border-left: 4px solid #6c63ff; padding: 1rem; margin-bottom: 1rem;">
            <p style="color: #a0a8b8; line-height: 1.7; margin: 0;">
                <strong>Important:</strong> VENOM Solutions provides software licensing only. We do not provide, host, transmit, or have access to any content, media, streaming data, or user materials.
            </p>
        </div>
        <p style="color: #a0a8b8; line-height: 1.7;">
            You are solely responsible for:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>All content you deploy using the licensed software</li>
            <li>Ensuring your content complies with applicable laws</li>
            <li>Your own server infrastructure and availability</li>
            <li>Any third-party services you integrate with our software</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">3. Prohibited Uses</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            You may NOT use our software or services to:
        </p>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">3.1 Illegal Activities</h3>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Violate any local, state, national, or international law</li>
            <li>Distribute, store, or transmit illegal content</li>
            <li>Facilitate copyright infringement or piracy</li>
            <li>Engage in fraud, phishing, or scams</li>
            <li>Distribute malware, viruses, or harmful code</li>
        </ul>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">3.2 Harmful Activities</h3>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Launch or participate in DDoS attacks</li>
            <li>Attempt to gain unauthorized access to systems</li>
            <li>Interfere with or disrupt our services or infrastructure</li>
            <li>Harass, threaten, or harm others</li>
            <li>Distribute spam or unsolicited communications</li>
        </ul>
        
        <h3 style="color: #00d4aa; margin-bottom: 0.5rem; margin-top: 1rem;">3.3 License Abuse</h3>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Use the software beyond your licensed tier</li>
            <li>Share, resell, or redistribute your license</li>
            <li>Attempt to bypass license validation</li>
            <li>Reverse engineer or modify the software</li>
            <li>Create derivative works based on our software</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">4. Content Responsibility</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Since we provide software only and have no access to your content:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>We cannot monitor or filter your content</li>
            <li>You bear full responsibility for content legality and appropriateness</li>
            <li>We are not liable for any content-related damages or legal issues</li>
            <li>You must respond to any third-party complaints about your content</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">5. Abuse Reporting</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            If you become aware of any abuse or violation of this AUP, please report it immediately via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a>.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            When reporting abuse, please include:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Description of the violation</li>
            <li>Evidence (logs, screenshots, URLs)</li>
            <li>Your contact information for follow-up</li>
        </ul>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">6. Enforcement</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Upon receiving a credible abuse report or detecting a violation, we may:
        </p>
        <ul style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Investigate the alleged violation</li>
            <li>Request additional information from you</li>
            <li>Issue a warning for minor violations</li>
            <li>Suspend your license pending investigation</li>
            <li>Terminate your license for serious or repeated violations</li>
            <li>Report illegal activities to relevant authorities</li>
        </ul>
        <div style="background: rgba(240, 82, 82, 0.1); border-left: 4px solid #f05252; padding: 1rem; margin-top: 1rem;">
            <p style="color: #a0a8b8; line-height: 1.7; margin: 0;">
                <strong>Note:</strong> Licenses terminated for AUP violations are not eligible for refunds.
            </p>
        </div>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">7. Appeals</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            If your license is suspended or terminated for an alleged AUP violation, you may appeal the decision by:
        </p>
        <ol style="color: #a0a8b8; line-height: 1.8; margin-left: 1.5rem;">
            <li>Opening a support ticket within 7 days of the action</li>
            <li>Providing a written explanation and supporting evidence</li>
            <li>Cooperating with our investigation</li>
        </ol>
        <p style="color: #a0a8b8; line-height: 1.7; margin-top: 1rem;">
            We will review appeals within 5 business days and communicate our decision.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">8. Service Availability</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Our licensing portal manages license validation only. The availability of your own server infrastructure, streaming services, or any third-party systems is your responsibility.
        </p>
        <p style="color: #a0a8b8; line-height: 1.7;">
            Issues with our licensing portal will not affect the operation of properly licensed software that has already been validated.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">9. Policy Updates</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            We reserve the right to modify this AUP at any time. Material changes will be communicated via email to the address on file. Continued use of the Services after changes constitutes acceptance of the modified policy.
        </p>
    </section>

    <section style="margin-bottom: 2rem;">
        <h2 style="color: #6c63ff; margin-bottom: 1rem;">10. Contact</h2>
        <p style="color: #a0a8b8; line-height: 1.7;">
            For questions about this Acceptable Use Policy or to report abuse, please contact us via our <a href="/submitticket.php" style="color: #6c63ff;">support portal</a>.
        </p>
    </section>

</div>
HTML;

$ca->assign('acceptableUseContent', $acceptableUseContent);
$ca->setTemplate('acceptable-use');

$ca->output();

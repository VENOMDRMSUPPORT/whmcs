    </div>

    <footer class="venom-footer">
        <div class="footer-container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <a href="{$WEB_ROOT}/index.php" style="display: inline-flex; align-items: center; gap: 10px; text-decoration: none; margin-bottom: 18px;">
                        {include file="$template/includes/logo.tpl" size="32px" textSize="1rem" gap="8px"}
                    </a>
                    <p class="footer-description">
                        Professional service management platform built for providers.
                        Scalable licensing, automation, and real-time monitoring in one powerful panel.
                    </p>
                    <div class="footer-contact">
                        <a href="mailto:support@venom-solutions.com" class="footer-contact-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                <polyline points="22,6 12,13 2,6"></polyline>
                            </svg>
                            support@venom-solutions.com
                        </a>
                        <div class="footer-contact-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                            </svg>
                            24/7 Live Chat Support
                        </div>
                    </div>
                </div>

                <div class="footer-links">
                    <div class="footer-column">
                        <h4>Quick Access</h4>
                        <ul>
                            <li><a href="{$WEB_ROOT}/index.php">Home</a></li>
                            <li><a href="{$WEB_ROOT}/index.php#pricing">Pricing</a></li>
                            <li><a href="{$WEB_ROOT}/domainchecker.php">Domain Checker</a></li>
                            <li><a href="{$WEB_ROOT}/register.php">Create Account</a></li>
                            <li><a href="{$WEB_ROOT}/clientarea.php">Client Area</a></li>
                        </ul>
                    </div>
                    <div class="footer-column">
                        <h4>Support</h4>
                        <ul>
                            <li><a href="{$WEB_ROOT}/knowledgebase.php">Knowledgebase</a></li>
                            <li><a href="{$WEB_ROOT}/announcements.php">Announcements</a></li>
                            <li><a href="{$WEB_ROOT}/supporttickets.php">Support Tickets</a></li>
                            <li><a href="{$WEB_ROOT}/submitticket.php">Open Ticket</a></li>
                            <li><a href="{$WEB_ROOT}/contact.php">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; {$date_year} Venom Solutions. All rights reserved.</p>
                <div class="footer-payment-stack">
                    <div class="footer-secure">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#34d399" stroke-width="2">
                            <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                            <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                            <line x1="12" y1="22.08" x2="12" y2="12"></line>
                        </svg>
                        <span>Secure Payments</span>
                    </div>

                    <div class="footer-payments" aria-label="Accepted payment methods">
                        <span class="payment-chip" title="Visa" aria-label="Visa">
                            <img src="https://cdn.simpleicons.org/visa/FFFFFF" alt="Visa" class="payment-logo payment-logo-visa" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="Mastercard" aria-label="Mastercard">
                            <img src="https://cdn.simpleicons.org/mastercard/FFFFFF" alt="Mastercard" class="payment-logo payment-logo-mastercard" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="PayPal" aria-label="PayPal">
                            <img src="https://cdn.simpleicons.org/paypal/FFFFFF" alt="PayPal" class="payment-logo payment-logo-paypal" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="USDT" aria-label="USDT">
                            <img src="https://cdn.simpleicons.org/tether/FFFFFF" alt="USDT" class="payment-logo payment-logo-usdt" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="Bitcoin" aria-label="Bitcoin">
                            <img src="https://cdn.simpleicons.org/bitcoin/FFFFFF" alt="Bitcoin" class="payment-logo payment-logo-btc" loading="lazy" decoding="async">
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    {$footeroutput}
</body>
</html>

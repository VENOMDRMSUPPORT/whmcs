<div class="register-page">
    <div class="register-shell">
        <aside class="register-side">
            <div class="register-side-content">
                {include file="$template/includes/logo.tpl" size="40px" textSize="1.35rem" gap="12px"}
                <h2>Launch Your IPTV Business</h2>
                <p>Get your Venom DRM license and start managing your streaming infrastructure today.</p>

                <ul class="register-benefits">
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Full-featured IPTV management panel
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Multi-server load balancing
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Real-time user management
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Automated license activation
                    </li>
                </ul>

                <div class="register-side-signin">
                    <p>Already have an account? <a href="{$WEB_ROOT}/login.php">Sign in</a></p>
                </div>
            </div>
        </aside>

        <div class="auth-card glass-card register-card">
            <div class="tech-corner corner-tl"></div>
            <div class="tech-corner corner-tr"></div>
            <div class="tech-corner corner-bl"></div>
            <div class="tech-corner corner-br"></div>

            <div class="register-floating-badge">
                <div class="register-floating-badge-title">
                    <span class="register-floating-badge-dot"></span>
                    <span>Create Account</span>
                </div>
            </div>

        {if $errormessage}
            <div class="alert alert-error">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="15" y1="9" x2="9" y2="15"/>
                    <line x1="9" y1="9" x2="15" y2="15"/>
                </svg>
                <span>{$errormessage}</span>
            </div>
        {/if}

        <form method="post" action="{$WEB_ROOT}/register.php?step=2" class="auth-form">
            {if $token}
                <input type="hidden" name="token" value="{$token}">
            {/if}
            <div class="form-row-2">
                <div class="form-group">
                    <label for="firstname">First Name</label>
                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21a8 8 0 0 0-16 0"></path>
                                <circle cx="12" cy="8" r="4"></circle>
                            </svg>
                        </span>
                        <input class="input-control" type="text" name="firstname" id="firstname" value="{$clientfirstname}" placeholder="John" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="lastname">Last Name</label>
                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21a8 8 0 0 0-16 0"></path>
                                <circle cx="12" cy="8" r="4"></circle>
                            </svg>
                        </span>
                        <input class="input-control" type="text" name="lastname" id="lastname" value="{$clientlastname}" placeholder="Doe" required>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-shell">
                    <span class="input-icon" aria-hidden="true">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="5" width="18" height="14" rx="2"></rect>
                            <path d="M3 7l9 6 9-6"></path>
                        </svg>
                    </span>
                    <input class="input-control" type="email" name="email" id="email" value="{$clientemail}" placeholder="john@example.com" required>
                </div>
            </div>

            <div class="form-group">
                <label for="phonenumber">Phone Number</label>
                <div class="input-shell">
                    <span class="input-icon" aria-hidden="true">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.8 19.8 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.8 19.8 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.8 12.8 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.1 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.8 12.8 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                        </svg>
                    </span>
                    <input class="input-control" type="tel" name="phonenumber" id="phonenumber" value="{$clientphonenumber}" placeholder="+1 (555) 000-0000">
                </div>
            </div>

            <div class="form-row-2">
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="4" y="11" width="16" height="10" rx="2"></rect>
                                <path d="M8 11V8a4 4 0 1 1 8 0v3"></path>
                            </svg>
                        </span>
                        <input class="input-control" type="password" name="password" id="password" placeholder="Create a password" required minlength="8">
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirmpw">Confirm Password</label>
                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="4" y="11" width="16" height="10" rx="2"></rect>
                                <path d="M8 11V8a4 4 0 1 1 8 0v3"></path>
                                <path d="M9 16l2 2 4-4"></path>
                            </svg>
                        </span>
                        <input class="input-control" type="password" name="confirmpw" id="confirmpw" placeholder="Confirm your password" required>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="companyname">Company Name <span class="optional">(Optional)</span></label>
                <div class="input-shell">
                    <span class="input-icon" aria-hidden="true">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M3 21h18"></path>
                            <path d="M5 21V7l7-4 7 4v14"></path>
                            <path d="M9 10h1"></path>
                            <path d="M14 10h1"></path>
                            <path d="M9 14h1"></path>
                            <path d="M14 14h1"></path>
                        </svg>
                    </span>
                    <input class="input-control" type="text" name="companyname" id="companyname" value="{$clientcompanyname}" placeholder="Your company name">
                </div>
            </div>

            {if $customfields}
            <div class="form-group">
                {$customfields}
            </div>
            {/if}

            {if $captcha}
            <div class="form-group">
                {$captcha}
            </div>
            {/if}

            <div class="terms-notice">
                <p>By creating an account, you agree to our <a href="{$WEB_ROOT}/terms.php">Terms of Service</a> and <a href="{$WEB_ROOT}/privacy.php">Privacy Policy</a>.</p>
            </div>

            <button type="submit" class="btn-glow auth-submit">
                Create Account
            </button>
        </form>

        <div class="auth-footer register-mobile-signin">
            <p>Already have an account? <a href="{$WEB_ROOT}/login.php">Sign in</a></p>
        </div>

        </div>
    </div>
</div>

<style>
.register-page {
    min-height: calc(100vh - 220px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 48px 20px;
}

.register-shell {
    width: 100%;
    max-width: 1240px;
    display: grid;
    grid-template-columns: minmax(320px, 460px) minmax(560px, 1fr);
    gap: 64px;
    align-items: stretch;
}

.register-side {
    display: flex;
    align-items: center;
    padding: 20px 6px;
}

.register-side-content {
    display: grid;
    gap: 18px;
    max-width: 360px;
}

.register-side h2 {
    margin: 0;
    font-size: clamp(1.9rem, 3vw, 2.45rem);
    line-height: 1.08;
    letter-spacing: -0.8px;
    max-width: 12ch;
}

.register-side p {
    margin: 0;
    color: hsl(var(--muted-foreground));
    line-height: 1.8;
    font-size: 0.95rem;
    max-width: 34ch;
}

.register-benefits {
    list-style: none;
    margin: 8px 0 0;
    padding: 0;
    display: grid;
    gap: 10px;
}

.register-benefits li {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 0.9rem;
    color: hsl(var(--foreground) / 0.95);
    line-height: 1.5;
}

.register-benefits svg {
    color: hsl(var(--primary));
    flex-shrink: 0;
    margin-top: 2px;
    filter: drop-shadow(0 0 6px hsl(var(--primary) / 0.35));
}

.register-side-signin {
    margin-top: 10px;
    padding-top: 18px;
    border-top: 1px solid hsl(var(--border) / 0.5);
}

.register-side-signin p {
    margin: 0;
    font-size: 0.92rem;
    color: hsl(var(--muted-foreground));
}

.register-side-signin a {
    color: hsl(var(--primary));
    text-decoration: none;
    font-weight: 700;
}

.register-side-signin a:hover {
    text-decoration: underline;
}

.register-card {
    width: 100%;
    border-radius: 24px;
    padding: 72px 34px 40px;
    overflow: visible;
}

.register-floating-badge {
    position: absolute;
    top: 0;
    left: 34px;
    transform: translateY(-42%);
    display: grid;
    gap: 0;
    min-width: 0;
    max-width: none;
    padding: 10px 15px;
    border-radius: 16px;
    border: 1px solid hsl(var(--primary) / 0.45);
    background: linear-gradient(135deg, hsl(var(--card) / 0.96) 0%, hsl(var(--primary) / 0.2) 100%);
    color: hsl(var(--foreground));
    box-shadow: 0 8px 22px hsl(var(--background) / 0.55), 0 0 16px hsl(var(--primary) / 0.25);
    z-index: 4;
}

.register-card::before {
    content: "";
    position: absolute;
    top: -1px;
    left: 34px;
    width: 180px;
    height: 3px;
    background: hsl(var(--background));
    z-index: 3;
    pointer-events: none;
}

.register-floating-badge-title {
    display: inline-flex;
    align-items: center;
    gap: 9px;
    font-size: 1.08rem;
    font-weight: 900;
    letter-spacing: -0.2px;
    line-height: 1.1;
}

.register-floating-badge-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: hsl(var(--primary));
    box-shadow: 0 0 10px hsl(var(--primary));
}

.auth-form {
    display: grid;
    gap: 16px;
}

.form-group {
    display: grid;
    gap: 8px;
}

.input-shell {
    display: grid;
    grid-template-columns: 46px 1fr;
    align-items: stretch;
    border: 1px solid hsl(var(--primary) / 0.24);
    border-radius: 12px;
    background: hsl(var(--card) / 0.56);
    overflow: hidden;
    transition: border-color 0.25s ease, box-shadow 0.25s ease;
}

.input-shell:focus-within {
    border-color: hsl(var(--primary) / 0.62);
    box-shadow: 0 0 0 3px hsl(var(--primary) / 0.12);
}

.input-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: hsl(var(--primary) / 0.14);
    color: hsl(var(--primary));
    border-right: 1px solid hsl(var(--primary) / 0.24);
}

.input-shell .input-control {
    width: 100%;
    border: none;
    border-radius: 0;
    background: hsl(var(--input) / 0.5);
    color: hsl(var(--foreground));
    font-size: 0.95rem;
    padding: 13px 16px;
    outline: none;
    box-shadow: none;
}

.input-shell .input-control::placeholder {
    color: hsl(var(--muted-foreground));
    opacity: 0.65;
}

.input-shell .input-control:focus {
    border: none;
    box-shadow: none;
}

.input-shell .input-control:-webkit-autofill,
.input-shell .input-control:-webkit-autofill:hover,
.input-shell .input-control:-webkit-autofill:focus {
    -webkit-text-fill-color: hsl(var(--foreground));
    -webkit-box-shadow: 0 0 0 1000px hsl(var(--input) / 0.5) inset;
    box-shadow: 0 0 0 1000px hsl(var(--input) / 0.5) inset;
    caret-color: hsl(var(--foreground));
    border: none;
    border-radius: 0;
}

.form-group label {
    font-size: 0.85rem;
    font-weight: 700;
    color: hsl(var(--foreground));
}

.form-row-2 {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 14px;
}

.optional {
    font-weight: 400;
    opacity: 0.6;
    font-size: 0.85rem;
}

.terms-notice {
    background: hsl(var(--primary) / 0.05);
    border: 1px solid hsl(var(--primary) / 0.15);
    padding: 14px 16px;
    border-radius: 12px;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
    line-height: 1.6;
}

.terms-notice p {
    margin: 0;
}

.terms-notice a {
    color: hsl(var(--primary));
    text-decoration: none;
    font-weight: 600;
}

.terms-notice a:hover {
    text-decoration: underline;
}

.auth-submit {
    margin-top: 6px;
    width: 100%;
    min-height: 48px;
    border-radius: 12px;
    font-size: 1rem;
}

.auth-footer {
    margin-top: 24px;
    padding-top: 20px;
    border-top: 1px solid hsl(var(--border) / 0.6);
}

.register-mobile-signin {
    display: none;
}

.auth-footer p {
    margin: 0;
    color: hsl(var(--muted-foreground));
    font-size: 0.92rem;
}

.auth-footer a {
    color: hsl(var(--primary));
    text-decoration: none;
    font-weight: 700;
}

.auth-footer a:hover {
    text-decoration: underline;
}

.alert {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    margin-bottom: 16px;
}

@media (max-width: 980px) {
    .register-shell {
        grid-template-columns: 1fr;
        max-width: 680px;
        gap: 20px;
    }

    .register-side {
        padding: 24px 22px;
    }

    .register-side-signin {
        display: none;
    }

    .register-mobile-signin {
        display: block;
    }
}

@media (max-width: 620px) {
    .form-row-2 {
        grid-template-columns: 1fr;
    }
    
    .register-card {
        padding: 66px 22px 30px;
    }

    .register-floating-badge {
        left: 22px;
        right: 22px;
        min-width: 0;
        max-width: none;
        transform: translateY(-38%);
        padding: 9px 12px;
    }

    .register-floating-badge-title {
        font-size: 0.95rem;
    }

    .register-card::before {
        left: 22px;
        width: 150px;
    }

    .register-side {
        display: none;
    }
}
</style>

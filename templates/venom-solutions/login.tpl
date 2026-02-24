<div class="login-page">
    <div class="login-shell">
        <aside class="login-side">
            <div class="login-side-content">
                {include file="$template/includes/logo.tpl" size="40px" textSize="1.35rem" gap="12px"}
                <h2>Welcome Back</h2>
                <p>Sign in to manage your services, billing, and support activity from one secure dashboard.</p>

                <ul class="login-benefits">
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Full client dashboard access
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Fast invoices and payment tracking
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Priority support ticket management
                    </li>
                </ul>

                <div class="login-side-create">
                    <p>New to Venom Solutions? <a href="{$WEB_ROOT}/register.php">Create account</a></p>
                </div>
            </div>
        </aside>

        <div class="auth-card glass-card login-card">
        <div class="tech-corner corner-tl"></div>
        <div class="tech-corner corner-tr"></div>
        <div class="tech-corner corner-bl"></div>
        <div class="tech-corner corner-br"></div>

        <div class="login-floating-badge">
            <span class="login-floating-badge-dot"></span>
            <span>SIGN IN</span>
        </div>

        {if $incorrect}
            <div class="alert alert-error">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="15" y1="9" x2="9" y2="15"/>
                    <line x1="9" y1="9" x2="15" y2="15"/>
                </svg>
                <span>{$LANG.loginerror}</span>
            </div>
        {/if}

        <form method="post" action="{$systemurl}dologin.php" class="auth-form">
            {if $token}
                <input type="hidden" name="token" value="{$token}">
            {/if}
            <div class="form-group">
                <label for="username">Email Address</label>
                <div class="input-shell">
                    <span class="input-icon" aria-hidden="true">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="5" width="18" height="14" rx="2"></rect>
                            <path d="M3 7l9 6 9-6"></path>
                        </svg>
                    </span>
                    <input class="input-control" type="email" name="username" id="username" value="{$username|default:''}" placeholder="name@company.com" required>
                </div>
            </div>

            <div class="form-group">
                <div class="label-row">
                    <label for="password">Password</label>
                </div>
                <div class="input-shell">
                    <span class="input-icon" aria-hidden="true">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="4" y="11" width="16" height="10" rx="2"></rect>
                            <path d="M8 11V8a4 4 0 1 1 8 0v3"></path>
                        </svg>
                    </span>
                    <input class="input-control" type="password" name="password" id="password" placeholder="Enter your password" required>
                </div>
            </div>

            <div class="form-row">
                <label class="checkbox-label">
                    <input type="checkbox" name="rememberme" id="rememberme">
                    <span class="checkbox-custom"></span>
                    Keep me signed in
                </label>
                <a href="{$WEB_ROOT}/pwreset.php" class="forgot-link forgot-link-inline">Forgot password?</a>
            </div>

            <button type="submit" class="btn-glow auth-submit">
                Sign In
            </button>
        </form>

        <div class="auth-footer login-mobile-create">
            <p>Don't have an account? <a href="{$WEB_ROOT}/register.php">Create one</a></p>
        </div>

        </div>
    </div>
</div>

<style>
.login-page {
    min-height: calc(100vh - 220px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 48px 20px;
}

.login-shell {
    width: 100%;
    max-width: 1180px;
    display: grid;
    grid-template-columns: minmax(320px, 440px) minmax(460px, 560px);
    gap: 64px;
    justify-content: center;
    align-items: stretch;
}

.login-side {
    display: flex;
    align-items: center;
    padding: 20px 6px;
}

.login-side-content {
    display: grid;
    gap: 18px;
    max-width: 360px;
}

.login-side h2 {
    margin: 0;
    font-size: clamp(1.9rem, 3vw, 2.4rem);
    line-height: 1.08;
    letter-spacing: -0.8px;
}

.login-side p {
    margin: 0;
    color: hsl(var(--muted-foreground));
    line-height: 1.78;
    font-size: 0.95rem;
}

.login-benefits {
    list-style: none;
    margin: 8px 0 0;
    padding: 0;
    display: grid;
    gap: 10px;
}

.login-benefits li {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 0.9rem;
    color: hsl(var(--foreground) / 0.95);
    line-height: 1.5;
}

.login-benefits svg {
    color: hsl(var(--primary));
    flex-shrink: 0;
    margin-top: 2px;
    filter: drop-shadow(0 0 6px hsl(var(--primary) / 0.35));
}

.login-side-create {
    margin-top: 8px;
    padding-top: 16px;
    border-top: 1px solid hsl(var(--border) / 0.5);
}

.login-side-create p {
    margin: 0;
    font-size: 0.92rem;
}

.login-side-create a {
    color: hsl(var(--primary));
    text-decoration: none;
    font-weight: 700;
}

.login-side-create a:hover {
    text-decoration: underline;
}

.login-card {
    --login-badge-left: 34px;
    --login-badge-gap-left: 24px;
    width: 100%;
    max-width: 560px;
    padding: 64px 34px 36px;
    border-radius: 24px;
    overflow: visible;
    border: 1px solid hsl(var(--primary) / 0.2);
    background: hsl(var(--glass-bg));
}

.login-floating-badge {
    position: absolute;
    top: 0;
    left: var(--login-badge-left);
    transform: translateY(-50%);
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 9px 16px;
    border-radius: 999px;
    border: 1px solid hsl(var(--primary) / 0.45);
    background: linear-gradient(135deg, hsl(var(--card) / 0.96) 0%, hsl(var(--primary) / 0.2) 100%);
    color: hsl(var(--foreground));
    font-size: 0.82rem;
    font-weight: 900;
    letter-spacing: 1.1px;
    box-shadow: 0 8px 22px hsl(var(--background) / 0.55), 0 0 16px hsl(var(--primary) / 0.25);
    z-index: 4;
}

.login-card::before {
    content: "";
    position: absolute;
    top: -1px;
    left: var(--login-badge-gap-left);
    width: 120px;
    height: 3px;
    background: hsl(var(--background));
    z-index: 3;
    pointer-events: none;
}

.login-floating-badge-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: hsl(var(--primary));
    box-shadow: 0 0 10px hsl(var(--primary));
}

.auth-form {
    display: grid;
    gap: 18px;
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

.label-row {
    display: flex;
    align-items: center;
}

.label-row label {
    margin-bottom: 0;
}

.forgot-link {
    font-size: 0.85rem;
    color: hsl(var(--primary));
    text-decoration: none;
    font-weight: 600;
    transition: opacity 0.2s;
}

.forgot-link:hover {
    opacity: 0.8;
}

.form-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
}

.checkbox-label {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    font-size: 0.9rem;
    color: hsl(var(--muted-foreground));
    font-weight: 500;
    margin-bottom: 0;
}

.forgot-link-inline {
    margin-left: auto;
    white-space: nowrap;
}

.checkbox-label input[type="checkbox"] {
    display: none;
}

.checkbox-custom {
    width: 20px;
    height: 20px;
    border: 1px solid hsl(var(--primary) / 0.45);
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(155deg, hsl(var(--card) / 0.78) 0%, hsl(var(--primary) / 0.16) 100%);
    box-shadow: inset 0 1px 0 rgb(255 255 255 / 0.15), 0 0 0 1px hsl(var(--background) / 0.4);
    transition: all 0.2s ease;
}

.checkbox-label:hover .checkbox-custom {
    border-color: hsl(var(--primary) / 0.65);
    box-shadow: inset 0 1px 0 rgb(255 255 255 / 0.2), 0 0 0 1px hsl(var(--background) / 0.3), 0 0 10px hsl(var(--primary) / 0.22);
}

.checkbox-label input:checked + .checkbox-custom {
    background: linear-gradient(145deg, hsl(var(--gradient-start)) 0%, hsl(var(--gradient-end)) 100%);
    border-color: hsl(var(--primary));
    box-shadow: 0 0 12px hsl(var(--primary) / 0.35), inset 0 1px 0 rgb(255 255 255 / 0.25);
}

.checkbox-label input:checked + .checkbox-custom::after {
    content: "✓";
    color: hsl(222 47% 10%);
    font-size: 12px;
    font-weight: 900;
    text-shadow: 0 1px 0 rgb(255 255 255 / 0.2);
}

.checkbox-label input:focus-visible + .checkbox-custom {
    outline: 2px solid hsl(var(--primary));
    outline-offset: 2px;
}

.auth-submit {
    padding: 14px 16px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 1rem;
    letter-spacing: 0.5px;
    cursor: pointer;
    border: none;
    margin-top: 8px;
}

.auth-footer {
    text-align: center;
    border-top: 1px solid hsl(var(--primary) / 0.1);
    padding-top: 20px;
    margin-top: 24px;
}

.login-mobile-create {
    display: none;
}

.auth-footer p {
    color: hsl(var(--muted-foreground));
    font-size: 0.9rem;
    margin: 0;
}

.auth-footer a {
    color: hsl(var(--primary));
    text-decoration: none;
    font-weight: 700;
    transition: opacity 0.2s;
}

.auth-footer a:hover {
    opacity: 0.8;
}

.alert {
    display: flex;
    align-items: flex-start;
    gap: 10px;
}

@media (max-width: 980px) {
    .login-shell {
        grid-template-columns: 1fr;
        max-width: 560px;
        gap: 20px;
    }

    .login-side {
        padding: 22px;
    }

    .login-side-create {
        display: none;
    }

    .login-mobile-create {
        display: block;
    }
}

@media (max-width: 620px) {
    .login-card {
        --login-badge-left: 22px;
        --login-badge-gap-left: 14px;
        padding: 56px 22px 30px;
    }

    .login-card::before {
        width: 116px;
    }

    .login-side { display: none; }

    .form-row { flex-wrap: wrap; }

    .forgot-link-inline { width: 100%; margin-left: 0; }

    .auth-submit { width: 100%; }
}
</style>

{assign var=resetSuccess value=$success|default:$successfulmsg|default:$msg|default:''}

<div class="pwreset-page">
    <div class="pwreset-shell">
        <aside class="pwreset-side">
            <div class="pwreset-side-content">
                {include file="$template/includes/logo.tpl" size="40px" textSize="1.35rem" gap="12px"}
                <h2>Recover Access Quickly</h2>
                <p>Enter your account email and we will send a secure reset link right away.</p>

                <ul class="pwreset-benefits">
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Secure one-time reset link
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Fast delivery to your inbox
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Keeps your account protected
                    </li>
                </ul>
            </div>
        </aside>

        <div class="auth-card glass-card pwreset-card">
            <div class="tech-corner corner-tl"></div>
            <div class="tech-corner corner-tr"></div>
            <div class="tech-corner corner-bl"></div>
            <div class="tech-corner corner-br"></div>

            <div class="pwreset-floating-badge">
                <span class="pwreset-floating-badge-dot"></span>
                <span>RESET PASSWORD</span>
            </div>

            {if $resetSuccess}
                <div class="alert alert-success">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                        <polyline points="22 4 12 14.01 9 11.01"/>
                    </svg>
                    <span>{$resetSuccess}</span>
                </div>
            {/if}

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

            <form method="post" action="{$WEB_ROOT}/pwreset.php" class="auth-form">
                {if $token}
                    <input type="hidden" name="token" value="{$token}">
                {/if}
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="5" width="18" height="14" rx="2"></rect>
                                <path d="M3 7l9 6 9-6"></path>
                            </svg>
                        </span>
                        <input class="input-control" type="email" name="email" id="email" placeholder="name@company.com" required>
                    </div>
                </div>

                {if $captcha}
                <div class="form-group">
                    <label>Security Check</label>
                    {$captcha}
                </div>
                {/if}

                <button type="submit" class="btn-glow auth-submit">
                    Send Reset Link
                </button>
            </form>

            <div class="auth-footer">
                <p>Remember your password? <a href="{$WEB_ROOT}/login.php">Sign in</a></p>
            </div>
        </div>
    </div>
</div>

<style>
.pwreset-page { min-height: calc(100vh - 220px); display: flex; align-items: center; justify-content: center; padding: 48px 20px; }
.pwreset-shell { width: 100%; max-width: 1180px; display: grid; grid-template-columns: minmax(320px, 440px) minmax(460px, 560px); gap: 64px; justify-content: center; align-items: stretch; }
.pwreset-side { display: flex; align-items: center; padding: 20px 6px; }
.pwreset-side-content { display: grid; gap: 18px; max-width: 360px; }
.pwreset-side h2 { margin: 0; font-size: clamp(1.9rem, 3vw, 2.4rem); line-height: 1.08; letter-spacing: -0.8px; }
.pwreset-side p { margin: 0; color: hsl(var(--muted-foreground)); line-height: 1.78; font-size: 0.95rem; }
.pwreset-benefits { list-style: none; margin: 8px 0 0; padding: 0; display: grid; gap: 10px; }
.pwreset-benefits li { display: flex; align-items: flex-start; gap: 10px; font-size: 0.9rem; color: hsl(var(--foreground) / 0.95); line-height: 1.5; }
.pwreset-benefits svg { color: hsl(var(--primary)); flex-shrink: 0; margin-top: 2px; filter: drop-shadow(0 0 6px hsl(var(--primary) / 0.35)); }

.pwreset-card { width: 100%; max-width: 560px; padding: 64px 34px 36px; border-radius: 24px; overflow: visible; }
.pwreset-floating-badge { position: absolute; top: 0; left: 34px; transform: translateY(-50%); display: inline-flex; align-items: center; gap: 8px; padding: 9px 16px; border-radius: 999px; border: 1px solid hsl(var(--primary) / 0.45); background: linear-gradient(135deg, hsl(var(--card) / 0.96) 0%, hsl(var(--primary) / 0.2) 100%); color: hsl(var(--foreground)); font-size: 0.72rem; font-weight: 800; letter-spacing: 1px; box-shadow: 0 8px 22px hsl(var(--background) / 0.55), 0 0 16px hsl(var(--primary) / 0.25); z-index: 4; }
.pwreset-card::before { content: ""; position: absolute; top: -1px; left: 24px; width: 164px; height: 3px; background: hsl(var(--background)); z-index: 3; pointer-events: none; }
.pwreset-floating-badge-dot { width: 8px; height: 8px; border-radius: 50%; background: hsl(var(--primary)); box-shadow: 0 0 10px hsl(var(--primary)); }

.auth-form { display: grid; gap: 18px; }
.form-group { display: grid; gap: 8px; }

.input-shell { display: grid; grid-template-columns: 46px 1fr; align-items: stretch; border: 1px solid hsl(var(--primary) / 0.24); border-radius: 12px; background: hsl(var(--card) / 0.56); overflow: hidden; transition: border-color 0.25s ease, box-shadow 0.25s ease; }
.input-shell:focus-within { border-color: hsl(var(--primary) / 0.62); box-shadow: 0 0 0 3px hsl(var(--primary) / 0.12); }
.input-icon { display: inline-flex; align-items: center; justify-content: center; background: hsl(var(--primary) / 0.14); color: hsl(var(--primary)); border-right: 1px solid hsl(var(--primary) / 0.24); }
.input-shell .input-control { width: 100%; border: none; border-radius: 0; background: hsl(var(--input) / 0.5); color: hsl(var(--foreground)); font-size: 0.95rem; padding: 13px 16px; outline: none; box-shadow: none; }
.input-shell .input-control::placeholder { color: hsl(var(--muted-foreground)); opacity: 0.65; }
.input-shell .input-control:focus { border: none; box-shadow: none; }
.input-shell .input-control:-webkit-autofill,
.input-shell .input-control:-webkit-autofill:hover,
.input-shell .input-control:-webkit-autofill:focus { -webkit-text-fill-color: hsl(var(--foreground)); -webkit-box-shadow: 0 0 0 1000px hsl(var(--input) / 0.5) inset; box-shadow: 0 0 0 1000px hsl(var(--input) / 0.5) inset; caret-color: hsl(var(--foreground)); border: none; border-radius: 0; }

.auth-submit { padding: 14px 16px; border-radius: 12px; font-weight: 700; font-size: 1rem; cursor: pointer; border: none; margin-top: 8px; }
.auth-footer { text-align: center; border-top: 1px solid hsl(var(--primary) / 0.1); padding-top: 20px; margin-top: 24px; }
.auth-footer p { color: hsl(var(--muted-foreground)); font-size: 0.9rem; margin: 0; }
.auth-footer a { color: hsl(var(--primary)); text-decoration: none; font-weight: 700; }
.auth-footer a:hover { opacity: 0.8; }
.alert { display: flex; align-items: center; gap: 10px; padding: 14px 16px; }

@media (max-width: 980px) {
    .pwreset-shell { grid-template-columns: 1fr; max-width: 560px; gap: 20px; }
    .pwreset-side { padding: 22px; }
}

@media (max-width: 620px) {
    .pwreset-side { display: none; }
    .pwreset-card { padding: 56px 22px 30px; }
    .pwreset-floating-badge { left: 22px; }
    .pwreset-card::before { left: 14px; width: 156px; }
}
</style>

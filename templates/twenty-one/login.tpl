<div class="venom-login-page venom-auth-page">

    {* Background — matches landing page 1:1 *}
    <div class="venom-login-bg"></div>

    {* Centered card *}
    <div class="venom-login-center">
        <div class="venom-login-motion">

            <div class="venom-glass-card">

                {* Card header *}
                <div class="venom-card-header">
                    <a href="{$WEB_ROOT}/" class="venom-logo-link">
                        <div class="venom-card-logo animated-logo" style="width:64px;height:64px;">
                            <div class="animated-logo-glow"></div>
                            <div class="animated-logo-ring-outer"></div>
                            <div class="animated-logo-ring-inner"></div>
                            <div class="animated-logo-ring-decorative"></div>
                            <div class="animated-logo-inner">
                                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="filter:drop-shadow(0 0 20px #06b6d4);">
                                    <path d="M5 3L12 21L19 3" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M8 5L12 15L16 5" stroke="#06b6d4" stroke-width="1.5" stroke-linecap="round"/>
                                </svg>
                            </div>
                        </div>
                    </a>
                    <h1 class="venom-card-title">Client Portal</h1>
                    <p class="venom-card-subtitle">Access your dashboard and manage licenses</p>
                </div>

                {* Flash / error messages *}
                <div class="venom-flash-area">
                    {include file="$template/includes/flashmessage.tpl"}
                </div>

                {* Login form *}
                <form method="post" action="{routePath('login-validate')}" class="login-form venom-form" role="form">

                    {* Email *}
                    <div class="venom-field">
                        <label for="venom-email" class="venom-label">Email Address</label>
                        <div class="venom-input-wrap">
                            <span class="venom-input-icon">
                                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                </svg>
                            </span>
                            <input
                                type="email"
                                id="venom-email"
                                name="username"
                                class="venom-auth-input"
                                placeholder="you@example.com"
                                autocomplete="email"
                                autofocus
                            />
                        </div>
                    </div>

                    {* Password *}
                    <div class="venom-field">
                        <label for="venom-password" class="venom-label">Password</label>
                        <div class="venom-input-wrap">
                            <span class="venom-input-icon">
                                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                                </svg>
                            </span>
                            <input
                                type="password"
                                id="venom-password"
                                name="password"
                                class="venom-auth-input venom-password-input"
                                placeholder="••••••••"
                                autocomplete="current-password"
                            />
                            <button
                                type="button"
                                class="venom-pw-toggle"
                                aria-label="Toggle password visibility"
                                onclick="venomTogglePw(this)"
                            >
                                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" style="opacity:0.5;transition:opacity 0.2s;">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <div class="venom-form-actions-row">
                        <label class="venom-checkbox-label">
                            <input type="checkbox" name="rememberme" class="venom-checkbox-input" />
                            <span>{lang key='loginrememberme'}</span>
                        </label>
                        <a href="{routePath('password-reset-begin')}" class="venom-forgot-link">Forgot password?</a>
                    </div>

                    {* CAPTCHA (if enabled) *}
                    {if $captcha->isEnabled()}
                        <div class="venom-captcha-wrap">
                            <div class="venom-captcha-block">
                                {include file="$template/includes/captcha.tpl" captchaForm='clientLogin' nocache}
                            </div>
                        </div>
                    {/if}

                    {* Submit *}
                    <button type="submit" class="venom-btn-submit{$captcha->getButtonClass('clientLogin')}">
                        Sign In
                    </button>

                </form>

                {* Footer - hide when registration is disabled (Setup > General Settings) *}
                {if !$registrationDisabled}
                <div class="venom-card-footer">
                    <span class="venom-footer-muted">{lang key='userLogin.notRegistered'}&nbsp;</span>
                    <a href="{$WEB_ROOT}/register.php" class="venom-footer-link">{lang key='userLogin.createAccount'}</a>
                </div>
                {/if}

            </div>{* .venom-glass-card *}

        </div>{* .venom-login-motion *}
    </div>{* .venom-login-center *}

</div>{* .venom-login-page *}

{include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}

{literal}
<script>
function venomTogglePw(btn) {
    var input = document.getElementById('venom-password');
    var isText = input.type === 'text';
    input.type = isText ? 'password' : 'text';
    btn.querySelector('svg').style.opacity = isText ? '0.5' : '1';
}
</script>
{/literal}

<div class="venom-flash-area">
    {if $errorMessage}
        {include file="$template/includes/alert.tpl" type="error" msg=$errorMessage textcenter=true}
    {/if}
</div>

<form method="post" action="{routePath('password-reset-validate-email')}" class="venom-form" role="form">
    <input type="hidden" name="action" value="reset" />

    <div class="venom-field">
        <label for="venom-pwreset-email" class="venom-label">{lang key='loginemail'}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                </svg>
            </span>
            <input type="email" class="venom-auth-input" name="email" id="venom-pwreset-email" placeholder="name@example.com" autofocus required>
        </div>
    </div>

    {if $captcha->isEnabled() && $captcha->isEnabledForForm('passwordReset')}
        <div class="venom-captcha-wrap">
            <div class="venom-captcha-block">
                {include file="$template/includes/captcha.tpl" captchaForm='passwordReset' nocache}
            </div>
        </div>
    {/if}

    <button type="submit" class="venom-btn-submit{$captcha->getButtonClass('passwordReset')}">
        {lang key='pwresetsubmit'}
    </button>
</form>

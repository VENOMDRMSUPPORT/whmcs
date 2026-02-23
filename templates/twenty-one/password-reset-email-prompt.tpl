{* VENOM Solutions — Password Reset Email Prompt *}
{if $errorMessage}
    <div class="venom-flash-area">
        {include file="$template/includes/alert.tpl" type="error" msg=$errorMessage textcenter=true}
    </div>
{/if}

<form method="post" action="{routePath('password-reset-validate-email')}" class="venom-form" role="form">
    <input type="hidden" name="action" value="reset" />

    <div class="venom-field">
        <label for="inputEmail" class="venom-label">{lang key='loginemail'}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon"><i class="fas fa-envelope"></i></span>
            <input type="email" class="venom-auth-input" name="email" id="inputEmail" placeholder="{lang key='enteremail'}" autofocus>
        </div>
    </div>

    {if $captcha->isEnabled()}
        <div class="venom-captcha-wrap">
            <div class="venom-captcha-block">
                {include file="$template/includes/captcha.tpl"}
            </div>
        </div>
    {/if}

    <div class="venom-form-submit">
        <button type="submit" class="venom-btn-submit{$captcha->getButtonClass($captchaForm)}">
            {lang key='pwresetsubmit'}
        </button>
    </div>
</form>

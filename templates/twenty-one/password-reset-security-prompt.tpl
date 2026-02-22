<div class="venom-flash-area">
    {if $errorMessage}
        {include file="$template/includes/alert.tpl" type="error" msg=$errorMessage textcenter=true}
    {/if}
</div>

<form method="post" action="{routePath('password-reset-security-verify')}" class="venom-form" role="form">
    <div class="venom-field">
        <label for="venom-pwreset-answer" class="venom-label">{$securityQuestion}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
            </span>
            <input type="text" class="venom-auth-input" name="answer" id="venom-pwreset-answer" autofocus required>
        </div>
    </div>

    <button type="submit" class="venom-btn-submit">
        {lang key='pwresetsubmit'}
    </button>
</form>

<form class="venom-form using-password-strength" method="POST" action="{routePath('password-reset-change-perform')}">
    <input type="hidden" name="answer" id="answer" value="{$securityAnswer}" />

    <div class="venom-field">
        <label for="inputNewPassword1" class="venom-label">{lang key='newpassword'}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                </svg>
            </span>
            <input type="password" class="venom-auth-input" name="newpw" id="inputNewPassword1" autocomplete="new-password" required>
        </div>
    </div>

    <div class="venom-field">
        <label for="inputNewPassword2" class="venom-label">{lang key='confirmnewpassword'}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                </svg>
            </span>
            <input type="password" class="venom-auth-input" name="confirmpw" id="inputNewPassword2" autocomplete="new-password" required>
        </div>
        <div id="inputNewPassword2Msg"></div>
    </div>

    <div class="venom-field">
        <label class="venom-label">{lang key='pwstrength'}</label>
        {include file="$template/includes/pwstrength.tpl"}
    </div>

    <div class="venom-field">
        <button type="submit" class="venom-btn-submit" name="submit">
            {lang key='clientareasavechanges'}
        </button>
        <a href="{$WEB_ROOT}/index.php?rp=/login" class="venom-footer-link" style="display:inline-block;margin-top:0.75rem;">{lang key='cancel'}</a>
    </div>
</form>

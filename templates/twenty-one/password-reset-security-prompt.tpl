{* VENOM Solutions — Password Reset Security Prompt *}
{if $errorMessage}
    <div class="venom-flash-area">
        <div class="alert alert-danger" style="display: flex; align-items: center; gap: 0.75rem; border-radius: 0.5rem; border: 1px solid rgba(239, 68, 68, 0.3); background: rgba(239, 68, 68, 0.1); padding: 0.75rem 1rem; margin-bottom: 1.25rem; font-size: 0.875rem; color: #f0f4f8;">
            <i class="fas fa-exclamation-circle"></i>
            <span>{$errorMessage}</span>
        </div>
    </div>
{/if}

<form method="post" action="{routePath('password-reset-security-verify')}" class="venom-form">
    <div class="venom-field">
        <label for="inputAnswer" class="venom-label">{$securityQuestion}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon"><i class="fas fa-shield-alt"></i></span>
            <input type="text" name="answer" class="venom-auth-input" id="inputAnswer" placeholder="{lang key='clientareasecurityanswer'}" autofocus>
        </div>
    </div>

    <div class="venom-form-submit">
        <button type="submit" class="venom-btn-submit">
            {lang key='pwresetsubmit'}
        </button>
    </div>
</form>

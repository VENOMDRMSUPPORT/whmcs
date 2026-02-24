<div class="auth-page">
    <div class="auth-card glass-card">
        <div class="tech-corner corner-tl"></div>
        <div class="tech-corner corner-tr"></div>
        <div class="tech-corner corner-bl"></div>
        <div class="tech-corner corner-br"></div>

        <div class="auth-header">
            {include file="$template/includes/logo.tpl" size="44px" textSize="1.5rem" gap="14px"}
            <h2>Set New Password</h2>
            <p>Create a new password for your account</p>
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

        <form method="post" action="{$WEB_ROOT}/pwreset.php" class="auth-form">
            {if $token}<input type="hidden" name="token" value="{$token}">{/if}
            {if $email}<input type="hidden" name="email" value="{$email}">{/if}

            <div class="form-group">
                <label for="newpw">New Password</label>
                <input type="password" name="newpw" id="newpw" placeholder="Create a new password" required minlength="8">
                <span class="input-hint">Must be at least 8 characters</span>
            </div>

            <div class="form-group">
                <label for="confirmpw">Confirm Password</label>
                <input type="password" name="confirmpw" id="confirmpw" placeholder="Confirm your new password" required>
            </div>

            <button type="submit" class="btn-glow auth-submit">
                Reset Password
            </button>
        </form>

        <div class="auth-footer">
            <p><a href="{$WEB_ROOT}/login.php">← Back to Sign In</a></p>
        </div>
    </div>
</div>

<style>
.auth-page {
    min-height: 85vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
}

.auth-card {
    width: 100%;
    max-width: 440px;
    padding: 48px 40px;
    border-radius: 24px;
}

.auth-header {
    text-align: center;
    margin-bottom: 36px;
}

.auth-header h2 {
    font-size: 1.75rem;
    font-weight: 800;
    margin: 20px 0 8px;
    color: hsl(var(--foreground));
}

.auth-header p {
    color: hsl(var(--muted-foreground));
    font-size: 0.9rem;
}

.auth-form {
    display: grid;
    gap: 22px;
}

.form-group {
    display: grid;
    gap: 8px;
}

.input-hint {
    font-size: 0.75rem;
    color: hsl(var(--muted-foreground));
}

.auth-submit {
    padding: 16px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 1rem;
    cursor: pointer;
    border: none;
    margin-top: 8px;
}

.auth-footer {
    text-align: center;
    border-top: 1px solid hsl(var(--primary) / 0.1);
    padding-top: 28px;
    margin-top: 32px;
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
}

.alert {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 14px 16px;
}

@media (max-width: 480px) {
    .auth-card {
        padding: 36px 24px;
    }
}
</style>

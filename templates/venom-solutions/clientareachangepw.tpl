{assign var=changePwSuccess value=$success|default:$successful|default:$successfulmsg|default:''}

<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Password Protection</h3>
                <p>Use a strong unique password to keep your account and services secure.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/clientarea.php?action=details" class="client-unified-side-link">Profile Details</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=security" class="client-unified-side-link">Security Settings</a>
                <a href="{$WEB_ROOT}/clientarea.php" class="client-unified-side-link">Back to Dashboard</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="settings-page">
        <div class="page-header">
            <h1>Change Password</h1>
            <p>Update your account password</p>
        </div>

        <div class="settings-grid">
            <div class="settings-nav glass-card">
                <a href="{$WEB_ROOT}/clientarea.php?action=details" class="nav-item">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                        <circle cx="12" cy="7" r="4"/>
                    </svg>
                    Profile Details
                </a>
                <a href="{$WEB_ROOT}/clientarea.php?action=changepw" class="nav-item active">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                    </svg>
                    Change Password
                </a>
                <a href="{$WEB_ROOT}/clientarea.php?action=security" class="nav-item">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                    </svg>
                    Security
                </a>
            </div>

            <div class="settings-content glass-card">
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

                {if $changePwSuccess}
                    <div class="alert alert-success">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                            <polyline points="22 4 12 14.01 9 11.01"/>
                        </svg>
                        <span>{$changePwSuccess}</span>
                    </div>
                {/if}

                <form method="post" action="{$WEB_ROOT}/clientarea.php?action=changepw" class="password-form">
                    {if $token}
                        <input type="hidden" name="token" value="{$token}">
                    {/if}
                    <div class="form-group">
                        <label for="oldpw">Current Password</label>
                        <input type="password" name="oldpw" id="oldpw" placeholder="Enter current password" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="newpw">New Password</label>
                            <input type="password" name="newpw" id="newpw" placeholder="Create new password" required minlength="8">
                        </div>
                        <div class="form-group">
                            <label for="confirmpw">Confirm New Password</label>
                            <input type="password" name="confirmpw" id="confirmpw" placeholder="Confirm new password" required>
                        </div>
                    </div>

                    <div class="password-requirements">
                        <h4>Password Requirements</h4>
                        <ul>
                            <li>At least 8 characters long</li>
                            <li>Include uppercase and lowercase letters</li>
                            <li>Include at least one number</li>
                        </ul>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-glow">Update Password</button>
                    </div>
                </form>
            </div>
        </div>
            </div>
        </main>
    </div>
</div>

<style>
.settings-page {
    display: grid;
    gap: 24px;
}

.page-header {
    margin-bottom: 32px;
}

.page-header h1 {
    margin: 0 0 8px 0;
    font-size: 1.75rem;
    font-weight: 800;
}

.page-header p {
    color: hsl(var(--muted-foreground));
    margin: 0;
}

.settings-grid {
    display: grid;
    grid-template-columns: 240px 1fr;
    gap: 28px;
}

.settings-nav {
    padding: 16px;
    border-radius: 16px;
    height: fit-content;
}

.nav-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 14px 16px;
    border-radius: 10px;
    color: hsl(var(--muted-foreground));
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 600;
    transition: all 0.2s;
}

.nav-item:hover {
    background: hsl(var(--primary) / 0.05);
    color: hsl(var(--foreground));
}

.nav-item.active {
    background: hsl(var(--primary) / 0.1);
    color: hsl(var(--primary));
}

.nav-item svg {
    flex-shrink: 0;
}

.settings-content {
    padding: 36px;
    border-radius: 16px;
}

.password-form {
    max-width: 500px;
}

.form-group {
    margin-bottom: 22px;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.password-requirements {
    background: hsl(var(--primary) / 0.05);
    border: 1px solid hsl(var(--primary) / 0.15);
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 28px;
}

.password-requirements h4 {
    margin: 0 0 12px 0;
    font-size: 0.9rem;
    font-weight: 700;
    color: hsl(var(--foreground));
}

.password-requirements ul {
    margin: 0;
    padding: 0;
    list-style: none;
    display: grid;
    gap: 8px;
}

.password-requirements li {
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
    display: flex;
    align-items: center;
    gap: 8px;
}

.password-requirements li::before {
    content: "•";
    color: hsl(var(--primary));
}

.form-actions {
    padding-top: 8px;
}

.form-actions .btn-glow {
    padding: 14px 32px;
}

.alert {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 14px 16px;
    margin-bottom: 24px;
}

@media (max-width: 768px) {
    .settings-grid {
        grid-template-columns: 1fr;
    }
    
    .settings-nav {
        display: flex;
        overflow-x: auto;
        gap: 8px;
        padding: 12px;
    }
    
    .nav-item {
        white-space: nowrap;
    }
    
    .form-row {
        grid-template-columns: 1fr;
    }
}
</style>

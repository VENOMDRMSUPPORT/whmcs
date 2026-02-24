{assign var=profileSuccess value=$success|default:$successful|default:$successfulmsg|default:''}
{assign var=profileFirstName value=$client.firstname|default:$clientfirstname|default:$firstname|default:''}
{assign var=profileLastName value=$client.lastname|default:$clientlastname|default:$lastname|default:''}
{assign var=profileCompany value=$client.companyname|default:$clientcompanyname|default:$companyname|default:''}
{assign var=profileEmail value=$client.email|default:$clientemail|default:$email|default:''}
{assign var=profilePhone value=$client.phonenumber|default:$clientphonenumber|default:$phonenumber|default:''}
{assign var=profileAddress1 value=$client.address1|default:$clientaddress1|default:$address1|default:''}
{assign var=profileAddress2 value=$client.address2|default:$clientaddress2|default:$address2|default:''}
{assign var=profileCity value=$client.city|default:$clientcity|default:$city|default:''}
{assign var=profileState value=$client.state|default:$clientstate|default:$state|default:''}
{assign var=profilePostcode value=$client.postcode|default:$clientpostcode|default:$postcode|default:''}
{assign var=profileCountryDropdown value=$countries|default:$countrydropdown|default:''}

<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Account Settings</h3>
                <p>Update profile details and keep your billing information accurate.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/clientarea.php?action=changepw" class="client-unified-side-link">Change Password</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=security" class="client-unified-side-link">Security Settings</a>
                <a href="{$WEB_ROOT}/clientarea.php" class="client-unified-side-link">Back to Dashboard</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="profile-page">
        <div class="page-header">
            <h1>My Profile</h1>
            <p>Manage your account information</p>
        </div>

        <div class="profile-grid">
            <div class="profile-nav glass-card">
                <a href="{$WEB_ROOT}/clientarea.php?action=details" class="nav-item active">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                        <circle cx="12" cy="7" r="4"/>
                    </svg>
                    Profile Details
                </a>
                <a href="{$WEB_ROOT}/clientarea.php?action=changepw" class="nav-item">
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

            <div class="profile-content glass-card">
                {if $profileSuccess}
                <div class="alert alert-success">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                        <polyline points="22 4 12 14.01 9 11.01"/>
                    </svg>
                    <span>{$profileSuccess}</span>
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

                <form method="post" action="{$WEB_ROOT}/clientarea.php?action=details" class="profile-form">
                    {if $token}
                        <input type="hidden" name="token" value="{$token}">
                    {/if}
                    <div class="form-section">
                        <h3>Personal Information</h3>
                        <div class="form-row">
                            <div class="form-group">
                                <label>First Name</label>
                                <input type="text" name="firstname" value="{$profileFirstName}" required>
                            </div>
                            <div class="form-group">
                                <label>Last Name</label>
                                <input type="text" name="lastname" value="{$profileLastName}" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Company Name</label>
                            <input type="text" name="companyname" value="{$profileCompany}">
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Email Address</label>
                                <input type="email" value="{$profileEmail}" disabled>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="tel" name="phonenumber" value="{$profilePhone}">
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3>Billing Address</h3>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address1" value="{$profileAddress1}">
                        </div>
                        <div class="form-group">
                            <label>Address Line 2</label>
                            <input type="text" name="address2" value="{$profileAddress2}">
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>City</label>
                                <input type="text" name="city" value="{$profileCity}">
                            </div>
                            <div class="form-group">
                                <label>State</label>
                                <input type="text" name="state" value="{$profileState}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Postcode</label>
                                <input type="text" name="postcode" value="{$profilePostcode}">
                            </div>
                            <div class="form-group">
                                <label>Country</label>
                                <select name="country">
                                    {$profileCountryDropdown}
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-glow">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
            </div>
        </main>
    </div>
</div>

<style>
.profile-page {
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

.profile-grid {
    display: grid;
    grid-template-columns: 240px 1fr;
    gap: 28px;
}

.profile-nav {
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

.profile-content {
    padding: 36px;
    border-radius: 16px;
}

.form-section {
    margin-bottom: 36px;
}

.form-section h3 {
    margin: 0 0 20px 0;
    font-size: 1.1rem;
    font-weight: 700;
    padding-bottom: 12px;
    border-bottom: 1px solid hsl(var(--border) / 0.5);
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    font-size: 0.9rem;
}

.form-group input,
.form-group select {
    width: 100%;
}

.form-group input:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.form-actions {
    padding-top: 12px;
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
    border-radius: 10px;
}

.alert-success {
    background: rgba(34, 197, 94, 0.1);
    border: 1px solid rgba(34, 197, 94, 0.3);
    color: #4ade80;
}

.alert-error {
    background: rgba(239, 68, 68, 0.1);
    border: 1px solid rgba(239, 68, 68, 0.3);
    color: #f87171;
}

@media (max-width: 768px) {
    .profile-grid {
        grid-template-columns: 1fr;
    }
    
    .profile-nav {
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

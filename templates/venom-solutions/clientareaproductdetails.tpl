{assign var=serviceId value=$id|default:$serviceid|default:0}
{assign var=serviceName value=$product|default:$servicename|default:'Service'}
{assign var=serviceStatus value=$status|default:'Active'}
{assign var=serviceDueDate value=$nextduedate|default:$nextduedateformatted|default:'-'}
{assign var=serviceRecurring value=$recurringamount|default:$amount|default:'--'}

<div class="clientarea-shell">
    {include file="$template/includes/clientarea-left-rail.tpl"}
    <div class="clientarea-main">
<div class="product-details-page">
    <div class="container">
        <div class="page-breadcrumb">
            <a href="{$WEB_ROOT}/clientarea.php">Dashboard</a>
            <span>/</span>
            <a href="{$WEB_ROOT}/clientarea.php?action=products">Services</a>
            <span>/</span>
            <span>{$serviceName}</span>
        </div>

        <div class="page-header">
            <div>
                <h1>{$serviceName}</h1>
                <p>License Information & Management</p>
            </div>
            <div class="header-status">
                <span class="status-badge {$serviceStatus|lower}">{$serviceStatus}</span>
            </div>
        </div>

        <div class="details-grid">
            <div class="main-card glass-card">
                <div class="card-header">
                    <h3>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        Control Panel Access
                    </h3>
                </div>

                <div class="credentials-grid">
                    <div class="credential-item">
                        <label>Access URL</label>
                        <div class="credential-value">
                            <code>https://venom-drm.test/</code>
                            <button class="copy-btn" type="button" data-copy="https://venom-drm.test/" aria-label="Copy access URL">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/>
                                    <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <div class="credential-item">
                        <label>License Key</label>
                        <div class="credential-value">
                            <code>VNM-{$serviceId}-XXXX-XXXX</code>
                            <button class="copy-btn" type="button" data-copy="VNM-{$serviceId}-XXXX-XXXX" aria-label="Copy license key">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/>
                                    <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <div class="credential-row">
                        <div class="credential-item">
                            <label>Username</label>
                            <div class="credential-value">
                                <code>client-{$serviceId}</code>
                            </div>
                        </div>
                        <div class="credential-item">
                            <label>Password</label>
                            <div class="credential-value">
                                <code>••••••••</code>
                                <button class="copy-btn" type="button" aria-label="Show password">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                        <circle cx="12" cy="12" r="3"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-actions">
                    <a href="https://venom-drm.test/" target="_blank" class="btn-glow">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                            <polyline points="15 3 21 3 21 9"/><line x1="10" y1="14" x2="21" y2="3"/>
                        </svg>
                        Open Panel
                    </a>
                </div>
            </div>

            <div class="sidebar-card glass-card">
                <div class="card-header">
                    <h3>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <polyline points="14 2 14 8 20 8"/>
                        </svg>
                        Billing & Renewal
                    </h3>
                </div>

                <div class="billing-info">
                    <div class="billing-row">
                        <span>Next Due Date</span>
                        <span>{$serviceDueDate}</span>
                    </div>
                    <div class="billing-row">
                        <span>Recurring Amount</span>
                        <span class="gradient-text">{$serviceRecurring}</span>
                    </div>
                    <div class="billing-row">
                        <span>Auto-Renew</span>
                        <span class="status-enabled">Enabled</span>
                    </div>
                </div>

                <div class="sidebar-actions">
                    <a href="{$WEB_ROOT}/clientarea.php?action=renew&id={$serviceId}" class="btn-glow" style="width: 100%; justify-content: center;">
                        Extend License
                    </a>
                    <a href="{$WEB_ROOT}/upgrade.php?type=package&id={$serviceId}" class="btn-venom-outline" style="width: 100%; justify-content: center;">
                        Upgrade Plan
                    </a>
                </div>
            </div>
        </div>

        <div class="info-cards">
            <div class="info-card glass-card">
                <div class="info-icon">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"/>
                        <polyline points="12 6 12 12 16 14"/>
                    </svg>
                </div>
                <div class="info-content">
                    <h4>Installation Time</h4>
                    <p>Usually within 5-10 minutes</p>
                </div>
            </div>
            <div class="info-card glass-card">
                <div class="info-icon">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                    </svg>
                </div>
                <div class="info-content">
                    <h4>Secure Connection</h4>
                    <p>SSL/HTTPS encrypted</p>
                </div>
            </div>
            <div class="info-card glass-card">
                <div class="info-icon">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                    </svg>
                </div>
                <div class="info-content">
                    <h4>Need Help?</h4>
                    <p>Open a support ticket</p>
                </div>
            </div>
        </div>
    </div>
</div>
    </div>
</div>

<style>
.product-details-page {
    max-width: 1100px;
    margin: 0 auto;
    padding: 40px 20px;
}

.page-breadcrumb {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 24px;
    font-size: 0.85rem;
}

.page-breadcrumb a {
    color: hsl(var(--muted-foreground));
    text-decoration: none;
    transition: color 0.2s;
}

.page-breadcrumb a:hover {
    color: hsl(var(--primary));
}

.page-breadcrumb span {
    color: hsl(var(--muted-foreground));
    opacity: 0.5;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 32px;
    gap: 20px;
    flex-wrap: wrap;
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

.status-badge {
    display: inline-block;
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-badge.active {
    background: rgba(34, 197, 94, 0.15);
    color: #4ade80;
    border: 1px solid rgba(34, 197, 94, 0.3);
}

.status-badge.suspended,
.status-badge.pending {
    background: rgba(251, 191, 36, 0.15);
    color: #fbbf24;
    border: 1px solid rgba(251, 191, 36, 0.3);
}

.status-badge.terminated,
.status-badge.cancelled,
.status-badge.expired {
    background: rgba(239, 68, 68, 0.15);
    color: #f87171;
    border: 1px solid rgba(239, 68, 68, 0.3);
}

.details-grid {
    display: grid;
    grid-template-columns: 1fr 320px;
    gap: 28px;
    margin-bottom: 32px;
}

.main-card,
.sidebar-card {
    padding: 0;
    border-radius: 20px;
    overflow: hidden;
}

.card-header {
    padding: 24px 28px;
    border-bottom: 1px solid hsl(var(--border) / 0.5);
    display: flex;
    align-items: center;
    gap: 12px;
}

.card-header h3 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 10px;
}

.card-header svg {
    color: hsl(var(--primary));
}

.credentials-grid {
    padding: 28px;
    display: grid;
    gap: 24px;
}

.credential-item label {
    display: block;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: hsl(var(--muted-foreground));
    margin-bottom: 10px;
}

.credential-value {
    display: flex;
    align-items: center;
    gap: 12px;
    background: hsl(var(--input) / 0.4);
    border: 1px solid hsl(var(--border) / 0.5);
    border-radius: 10px;
    padding: 14px 16px;
}

.credential-value code {
    font-family: var(--font-mono);
    font-size: 0.9rem;
    color: hsl(var(--foreground));
    flex-grow: 1;
}

.copy-btn {
    background: none;
    border: none;
    color: hsl(var(--primary));
    cursor: pointer;
    padding: 4px;
    border-radius: 6px;
    transition: background 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
}

.copy-btn:hover {
    background: hsl(var(--primary) / 0.1);
}

.copy-btn.copied {
    color: #4ade80;
    background: rgba(34, 197, 94, 0.15);
}

.credential-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.panel-actions {
    padding: 0 28px 28px;
    display: flex;
    gap: 14px;
}

.panel-actions .btn-glow {
    gap: 10px;
}

.sidebar-card .card-header {
    background: hsl(var(--card) / 0.5);
}

.billing-info {
    padding: 24px 28px;
    display: grid;
    gap: 18px;
}

.billing-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 0.9rem;
}

.billing-row span:first-child {
    color: hsl(var(--muted-foreground));
}

.billing-row span:last-child {
    font-weight: 600;
}

.status-enabled {
    color: #4ade80;
    background: rgba(34, 197, 94, 0.15);
    padding: 3px 10px;
    border-radius: 12px;
    font-size: 0.75rem;
}

.sidebar-actions {
    padding: 0 28px 28px;
    display: grid;
    gap: 12px;
}

.sidebar-actions .btn-venom-outline,
.sidebar-actions .btn-glow {
    padding: 14px 20px;
    font-size: 0.95rem;
}

.info-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
}

.info-card {
    padding: 24px;
    border-radius: 16px;
    display: flex;
    align-items: center;
    gap: 18px;
}

.info-icon {
    width: 52px;
    height: 52px;
    background: hsl(var(--primary) / 0.1);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
    flex-shrink: 0;
}

.info-content h4 {
    margin: 0 0 4px 0;
    font-size: 0.95rem;
    font-weight: 700;
}

.info-content p {
    margin: 0;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
}

@media (max-width: 900px) {
    .details-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 520px) {
    .credential-row {
        grid-template-columns: 1fr;
    }
    
    .panel-actions {
        flex-direction: column;
    }
    
    .panel-actions .btn-glow {
        justify-content: center;
    }
}
</style>

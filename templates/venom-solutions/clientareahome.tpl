<div class="clientarea-shell">
    {include file="$template/includes/clientarea-left-rail.tpl"}
    <div class="clientarea-main">
<div class="client-home-page">
    <div class="container">
        <div class="page-header">
            <div>
                <h1>Welcome back, <span class="gradient-text">{$clientname|default:$clientsdetails.fullname|default:'Client'}</span></h1>
                <p>Manage your infrastructure and streaming services.</p>
            </div>
            <div class="header-actions">
                <a href="{$WEB_ROOT}/cart.php" class="btn-glow">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                    </svg>
                    New Order
                </a>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card glass-card">
                <div class="stat-icon">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
                        <line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/>
                    </svg>
                </div>
                <div class="stat-content">
                    <span class="stat-value">{$clientsstats.productsnumactive|default:0}</span>
                    <span class="stat-label">Active Services</span>
                </div>
            </div>
            <div class="stat-card glass-card">
                <div class="stat-icon warning">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                        <polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/>
                        <line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/>
                    </svg>
                </div>
                <div class="stat-content">
                    <span class="stat-value">{$clientsstats.numunpaidinvoices|default:0}</span>
                    <span class="stat-label">Unpaid Invoices</span>
                </div>
            </div>
            <div class="stat-card glass-card">
                <div class="stat-icon info">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                    </svg>
                </div>
                <div class="stat-content">
                    <span class="stat-value">{$clientsstats.numactivetickets|default:0}</span>
                    <span class="stat-label">Open Tickets</span>
                </div>
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h2>Your Active Licenses</h2>
                <a href="{$WEB_ROOT}/clientarea.php?action=products" class="view-all">View All</a>
            </div>
            
            <div class="glass-card" style="overflow: hidden;">
                {if $services}
                <table class="table-venom">
                    <thead>
                        <tr>
                            <th>Product / Service</th>
                            <th>Next Due Date</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$services item=service}
                        <tr>
                            <td>
                                <div class="product-info">
                                    <strong>{$service.groupname|default:$service.domain|default:'Service'}</strong>
                                    <span>{$service.product|default:$service.name|default:'Managed Service'}</span>
                                </div>
                            </td>
                            <td>{$service.nextduedate|default:$service.dueDate|default:'-'}</td>
                            <td>{$service.amount|default:$service.recurringamount|default:'--'}</td>
                            <td>
                                <span class="status-badge {$service.status|default:'Active'|lower}">{$service.status|default:'Active'}</span>
                            </td>
                            <td style="text-align: right;">
                                <a href="{$WEB_ROOT}/clientarea.php?action=productdetails&id={$service.id|default:$service.serviceid}" class="btn-venom-outline" style="padding: 8px 16px; font-size: 0.8rem;">Manage</a>
                            </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {else}
                <div class="empty-state">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
                        <line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/>
                    </svg>
                    <h3>No Active Services</h3>
                    <p>You don't have any active licenses at the moment.</p>
                    <a href="{$WEB_ROOT}/cart.php" class="btn-glow">Browse Plans</a>
                </div>
                {/if}
            </div>
        </div>

        <div class="content-section">
            <div class="section-header">
                <h2>Quick Actions</h2>
            </div>
            
            <div class="quick-actions-grid">
                <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="action-card glass-card glass-card-hover">
                    <div class="action-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                        </svg>
                    </div>
                    <h3>Add Funds</h3>
                    <p>Add credit to your account</p>
                </a>
                <a href="{$WEB_ROOT}/supporttickets.php?action=open" class="action-card glass-card glass-card-hover">
                    <div class="action-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                            <line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
                        </svg>
                    </div>
                    <h3>Open Ticket</h3>
                    <p>Contact support team</p>
                </a>
                <a href="{$WEB_ROOT}/clientarea.php?action=details" class="action-card glass-card glass-card-hover">
                    <div class="action-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                    </div>
                    <h3>My Profile</h3>
                    <p>Update your information</p>
                </a>
                <a href="{$WEB_ROOT}/clientarea.php?action=invoices" class="action-card glass-card glass-card-hover">
                    <div class="action-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <polyline points="14 2 14 8 20 8"/>
                        </svg>
                    </div>
                    <h3>Invoices</h3>
                    <p>View billing history</p>
                </a>
            </div>
        </div>
    </div>
</div>
    </div>
</div>

<style>
.client-home-page {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 40px;
    gap: 20px;
    flex-wrap: wrap;
}

.page-header h1 {
    margin: 0 0 8px 0;
    font-size: 2rem;
    font-weight: 800;
}

.page-header p {
    color: hsl(var(--muted-foreground));
    margin: 0;
}

.header-actions .btn-glow {
    gap: 10px;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 48px;
}

.stat-card {
    display: flex;
    align-items: center;
    gap: 18px;
    padding: 24px;
    border-radius: 16px;
}

.stat-icon {
    width: 52px;
    height: 52px;
    background: hsl(var(--primary) / 0.1);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
}

.stat-icon.warning {
    background: rgba(251, 191, 36, 0.1);
    color: #fbbf24;
}

.stat-icon.info {
    background: rgba(59, 130, 246, 0.1);
    color: #3b82f6;
}

.stat-content {
    display: flex;
    flex-direction: column;
}

.stat-value {
    font-size: 1.75rem;
    font-weight: 800;
    color: hsl(var(--foreground));
    line-height: 1.2;
}

.stat-label {
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.content-section {
    margin-bottom: 48px;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.section-header h2 {
    margin: 0;
    font-size: 1.35rem;
    font-weight: 800;
}

.view-all {
    color: hsl(var(--primary));
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 600;
    transition: opacity 0.2s;
}

.view-all:hover {
    opacity: 0.8;
}

.product-info {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.product-info strong {
    font-size: 0.95rem;
}

.product-info span {
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
}

.status-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-badge.active {
    background: rgba(34, 197, 94, 0.15);
    color: #4ade80;
}

.status-badge.suspended {
    background: rgba(251, 191, 36, 0.15);
    color: #fbbf24;
}

.status-badge.terminated {
    background: rgba(239, 68, 68, 0.15);
    color: #f87171;
}

.empty-state {
    padding: 60px 40px;
    text-align: center;
}

.empty-state svg {
    color: hsl(var(--muted-foreground));
    opacity: 0.5;
    margin-bottom: 20px;
}

.empty-state h3 {
    margin: 0 0 8px 0;
    font-size: 1.25rem;
    font-weight: 700;
}

.empty-state p {
    color: hsl(var(--muted-foreground));
    margin: 0 0 24px 0;
}

.quick-actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
}

.action-card {
    padding: 28px 24px;
    border-radius: 16px;
    text-decoration: none;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    transition: all 0.3s ease;
}

.action-icon {
    width: 48px;
    height: 48px;
    background: hsl(var(--primary) / 0.1);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
    margin-bottom: 18px;
}

.action-card h3 {
    margin: 0 0 6px 0;
    font-size: 1.1rem;
    font-weight: 700;
    color: hsl(var(--foreground));
}

.action-card p {
    margin: 0;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
}

@media (max-width: 640px) {
    .page-header {
        flex-direction: column;
    }
    
    .header-actions {
        width: 100%;
    }
    
    .header-actions .btn-glow {
        width: 100%;
        justify-content: center;
    }
    
    .table-venom {
        display: block;
        overflow-x: auto;
    }
}
</style>

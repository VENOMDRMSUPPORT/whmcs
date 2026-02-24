<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Services Overview</h3>
                <p>Track active services, renewals, and delivery status from one place.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/cart.php" class="client-unified-side-link">Order New Service</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=renewals" class="client-unified-side-link">Review Renewals</a>
                <a href="{$WEB_ROOT}/supporttickets.php" class="client-unified-side-link">Open Support Ticket</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="products-page">
        <div class="page-header">
            <div>
                <h1>My Services</h1>
                <p>View and manage all your active subscriptions</p>
            </div>
            <a href="{$WEB_ROOT}/cart.php" class="btn-glow">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                New Order
            </a>
        </div>

        <div class="filter-tabs">
            <button class="tab active">All Services</button>
            <button class="tab">Active</button>
            <button class="tab">Suspended</button>
            <button class="tab">Expired</button>
        </div>

        {if $services}
        <div class="services-grid">
            {foreach from=$services item=service}
            <div class="service-card glass-card">
                <div class="service-header">
                    <div class="service-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
                            <line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/>
                        </svg>
                    </div>
                    <span class="status-badge {$service.status|default:'Active'|lower}">{$service.status|default:'Active'}</span>
                </div>
                
                <div class="service-body">
                    <h3>{$service.product|default:$service.name|default:'Service'}</h3>
                    <p class="service-group">{$service.groupname|default:$service.domain|default:'Managed Service'}</p>
                    
                    <div class="service-details">
                        <div class="detail-row">
                            <span>Next Due Date</span>
                            <span>{$service.nextduedate|default:$service.dueDate|default:'-'}</span>
                        </div>
                        <div class="detail-row">
                            <span>Amount</span>
                            <span class="gradient-text">{$service.amount|default:$service.recurringamount|default:'--'}</span>
                        </div>
                    </div>
                </div>
                
                <div class="service-actions">
                    <a href="{$WEB_ROOT}/clientarea.php?action=productdetails&id={$service.id|default:$service.serviceid}" class="btn-venom-outline">
                        Manage
                    </a>
                    <a href="{$WEB_ROOT}/clientarea.php?action=renew&id={$service.id|default:$service.serviceid}" class="btn-glow">
                        Renew
                    </a>
                </div>
            </div>
            {/foreach}
        </div>
        {else}
        <div class="empty-state glass-card">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
                <line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/>
            </svg>
            <h2>No Services Found</h2>
            <p>You don't have any active services at the moment.</p>
            <a href="{$WEB_ROOT}/cart.php" class="btn-glow">Browse Plans</a>
        </div>
        {/if}
            </div>
        </main>
    </div>
</div>

<style>
.products-page {
    display: grid;
    gap: 24px;
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

.page-header .btn-glow {
    gap: 10px;
}

.filter-tabs {
    display: flex;
    gap: 8px;
    margin-bottom: 28px;
    overflow-x: auto;
    padding-bottom: 4px;
}

.tab {
    padding: 10px 20px;
    background: transparent;
    border: 1px solid hsl(var(--border));
    border-radius: 10px;
    color: hsl(var(--muted-foreground));
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    white-space: nowrap;
}

.tab:hover {
    border-color: hsl(var(--primary) / 0.5);
    color: hsl(var(--foreground));
}

.tab.active {
    background: hsl(var(--primary) / 0.1);
    border-color: hsl(var(--primary));
    color: hsl(var(--primary));
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 24px;
}

.service-card {
    padding: 28px;
    border-radius: 20px;
    display: flex;
    flex-direction: column;
}

.service-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 20px;
}

.service-icon {
    width: 52px;
    height: 52px;
    background: hsl(var(--primary) / 0.1);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
}

.status-badge {
    display: inline-block;
    padding: 5px 14px;
    border-radius: 20px;
    font-size: 0.7rem;
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

.status-badge.expired,
.status-badge.terminated {
    background: rgba(239, 68, 68, 0.15);
    color: #f87171;
}

.service-body {
    flex-grow: 1;
    margin-bottom: 24px;
}

.service-body h3 {
    margin: 0 0 6px 0;
    font-size: 1.2rem;
    font-weight: 800;
}

.service-group {
    color: hsl(var(--muted-foreground));
    font-size: 0.9rem;
    margin: 0 0 20px 0;
}

.service-details {
    display: grid;
    gap: 12px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    font-size: 0.9rem;
}

.detail-row span:first-child {
    color: hsl(var(--muted-foreground));
}

.detail-row span:last-child {
    font-weight: 600;
}

.service-actions {
    display: flex;
    gap: 12px;
    padding-top: 20px;
    border-top: 1px solid hsl(var(--border) / 0.5);
}

.service-actions .btn-venom-outline,
.service-actions .btn-glow {
    flex: 1;
    padding: 12px 16px;
    font-size: 0.9rem;
    text-align: center;
    justify-content: center;
}

.empty-state {
    padding: 80px 40px;
    text-align: center;
    border-radius: 20px;
}

.empty-state svg {
    color: hsl(var(--muted-foreground));
    opacity: 0.4;
    margin-bottom: 24px;
}

.empty-state h2 {
    margin: 0 0 10px 0;
    font-size: 1.5rem;
    font-weight: 800;
}

.empty-state p {
    color: hsl(var(--muted-foreground));
    margin: 0 0 28px 0;
}

@media (max-width: 480px) {
    .services-grid {
        grid-template-columns: 1fr;
    }
    
    .service-actions {
        flex-direction: column;
    }
}
</style>

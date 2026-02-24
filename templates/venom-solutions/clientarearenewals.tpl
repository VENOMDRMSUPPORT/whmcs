{assign var=renewalItems value=$renewals|default:$services}
{assign var=pendingRenewals value=0}
{if $renewalItems}
    {foreach from=$renewalItems item=renewalCounter}
        {assign var=itemType value=$renewalCounter.type|default:$renewalCounter.itemtype|default:''}
        {if $itemType|lower != 'domain'}
            {if $renewalCounter.status|default:''|lower == 'unpaid' || $renewalCounter.status|default:''|lower == 'pending'}
                {assign var=pendingRenewals value=$pendingRenewals+1}
            {/if}
        {/if}
    {/foreach}
{/if}

<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Renewals Center</h3>
                <p>Stay ahead of expiration dates and keep all services continuously active.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/clientarea.php?action=products" class="client-unified-side-link">My Services</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=invoices" class="client-unified-side-link">View Invoices</a>
                <a href="{$WEB_ROOT}/supporttickets.php" class="client-unified-side-link">Contact Support</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="renewals-page">
        <div class="page-header">
            <h1>Renewals</h1>
            <p>Manage your service renewals</p>
        </div>

        <div class="renewals-summary glass-card">
            <div class="summary-item">
                <span class="summary-label">Pending Renewals</span>
                <span class="summary-value">{$pendingcount|default:$pendingRenewals}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Total Due</span>
                <span class="summary-value gradient-text">{$totaldue|default:'--'}</span>
            </div>
        </div>

        {if $renewalItems}
        <div class="renewals-list glass-card">
            <table class="table-venom">
                <thead>
                    <tr>
                        <th>Service</th>
                        <th>Next Due</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$renewalItems item=renewal}
                        {assign var=itemType value=$renewal.type|default:$renewal.itemtype|default:''}
                        {if $itemType|lower != 'domain'}
                    <tr>
                        <td>
                            <strong>{$renewal.product|default:$renewal.name|default:$renewal.servicename|default:'Service'}</strong>
                            <span class="service-id">{$renewal.servicename|default:'-'}</span>
                        </td>
                        <td>{$renewal.nextduedate|default:$renewal.dueDate|default:'-'}</td>
                        <td>{$renewal.amount|default:$renewal.recurringamount|default:'--'}</td>
                        <td>
                            <span class="status-badge {$renewal.status|default:'Pending'|replace:' ':'-'}">{$renewal.status|default:'Pending'}</span>
                        </td>
                        <td>
                            <a href="{$WEB_ROOT}/clientarea.php?action=productdetails&id={$renewal.id|default:$renewal.serviceid}" class="btn-glow">
                                Renew Now
                            </a>
                        </td>
                    </tr>
                        {/if}
                    {/foreach}
                </tbody>
            </table>
        </div>
        {else}
        <div class="empty-state glass-card">
            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <polyline points="23 4 23 10 17 10"/>
                <path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"/>
            </svg>
            <h2>No Pending Renewals</h2>
            <p>All your services are up to date.</p>
        </div>
        {/if}
            </div>
        </main>
    </div>
</div>

<style>
.renewals-page {
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

.renewals-summary {
    display: flex;
    justify-content: space-around;
    padding: 32px;
    border-radius: 16px;
    margin-bottom: 32px;
}

.summary-item {
    text-align: center;
}

.summary-label {
    display: block;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 8px;
}

.summary-value {
    font-size: 2rem;
    font-weight: 800;
}

.service-id {
    display: block;
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
    font-family: var(--font-mono);
}

.status-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
}

.status-badge.Pending {
    background: rgba(251, 191, 36, 0.15);
    color: #fbbf24;
}

.status-badge.pending {
    background: rgba(251, 191, 36, 0.15);
    color: #fbbf24;
}

.status-badge.Paid {
    background: rgba(34, 197, 94, 0.15);
    color: #4ade80;
}

.status-badge.paid {
    background: rgba(34, 197, 94, 0.15);
    color: #4ade80;
}

.empty-state {
    padding: 60px 40px;
    text-align: center;
    border-radius: 16px;
}

.empty-state svg {
    color: hsl(var(--muted-foreground));
    opacity: 0.5;
    margin-bottom: 20px;
}

.empty-state h2 {
    margin: 0 0 8px 0;
    font-size: 1.35rem;
}

.empty-state p {
    color: hsl(var(--muted-foreground));
    margin: 0;
}
</style>

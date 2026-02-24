{assign var=invoicePaidCount value=0}
{assign var=invoiceUnpaidCount value=0}
{if $invoices}
    {foreach from=$invoices item=invoiceCounter}
        {if $invoiceCounter.status|default:''|lower == 'paid'}
            {assign var=invoicePaidCount value=$invoicePaidCount+1}
        {/if}
        {if $invoiceCounter.status|default:''|lower == 'unpaid'}
            {assign var=invoiceUnpaidCount value=$invoiceUnpaidCount+1}
        {/if}
    {/foreach}
{/if}

<div class="clientarea-shell">
    {include file="$template/includes/clientarea-left-rail.tpl"}
    <div class="clientarea-main">
<div class="invoices-page">
    <div class="container">
        <div class="page-header">
            <div>
                <h1>Invoices</h1>
                <p>View and manage your billing history</p>
            </div>
            <div class="header-actions">
                <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="btn-glow">Add Funds</a>
            </div>
        </div>

        <div class="invoices-summary">
            <div class="summary-card glass-card">
                <span class="summary-label">Total Due</span>
                <span class="summary-value gradient-text">{$totaldue|default:'--'}</span>
            </div>
            <div class="summary-card glass-card">
                <span class="summary-label">Paid Invoices</span>
                <span class="summary-value">{$paidcount|default:$invoicePaidCount}</span>
            </div>
            <div class="summary-card glass-card">
                <span class="summary-label">Unpaid Invoices</span>
                <span class="summary-value unpaid">{$unpaidcount|default:$invoiceUnpaidCount}</span>
            </div>
        </div>

        <div class="invoices-list glass-card">
            {if $invoices}
            <table class="table-venom">
                <thead>
                    <tr>
                        <th>Invoice #</th>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$invoices item=invoice}
                    <tr>
                        <td><strong>#{$invoice.invoicenum|default:$invoice.id}</strong></td>
                        <td>{$invoice.date|default:$invoice.datecreated|default:'-'}</td>
                        <td>{$invoice.description|default:$invoice.rawstatus|default:'Invoice Details'}</td>
                        <td><span class="amount">{$invoice.amount|default:$invoice.total|default:'--'}</span></td>
                        <td>
                            <span class="status-badge {$invoice.status|default:''|replace:' ':'-'}">
                                {if $invoice.status|lower == 'paid'}Paid{elseif $invoice.status|lower == 'unpaid'}Unpaid{else}{$invoice.status}{/if}
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="{$WEB_ROOT}/viewinvoice.php?id={$invoice.id|default:$invoice.invoicenum}" class="btn-icon" title="View">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                        <circle cx="12" cy="12" r="3"/>
                                    </svg>
                                </a>
                                {if $invoice.status|lower == 'unpaid'}
                                <a href="{$WEB_ROOT}/viewinvoice.php?id={$invoice.id|default:$invoice.invoicenum}&pay=true" class="btn-icon primary" title="Pay Now">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/>
                                        <line x1="1" y1="10" x2="23" y2="10"/>
                                    </svg>
                                </a>
                                {/if}
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
            {else}
            <div class="empty-state">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <polyline points="14 2 14 8 20 8"/>
                </svg>
                <h3>No Invoices</h3>
                <p>You don't have any invoices yet.</p>
            </div>
            {/if}
        </div>
    </div>
</div>
    </div>
</div>

<style>
.invoices-page {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
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

.invoices-summary {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 32px;
}

.summary-card {
    padding: 24px;
    border-radius: 16px;
    text-align: center;
}

.summary-label {
    display: block;
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 8px;
}

.summary-value {
    font-size: 1.75rem;
    font-weight: 800;
}

.summary-value.unpaid {
    color: #fbbf24;
}

.invoices-list {
    border-radius: 16px;
    overflow: hidden;
}

.amount {
    font-weight: 700;
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

.status-badge.Paid,
.status-badge.paid {
    background: rgba(34, 197, 94, 0.15);
    color: #4ade80;
}

.status-badge.Unpaid,
.status-badge.unpaid {
    background: rgba(251, 191, 36, 0.15);
    color: #fbbf24;
}

.status-badge {
    border: 1px solid transparent;
}

.action-buttons {
    display: flex;
    gap: 8px;
}

.btn-icon {
    width: 36px;
    height: 36px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    background: hsl(var(--primary) / 0.1);
    color: hsl(var(--primary));
    transition: all 0.2s;
}

.btn-icon:hover {
    background: hsl(var(--primary) / 0.2);
}

.btn-icon.primary {
    background: hsl(var(--primary));
    color: #fff;
}

.btn-icon.primary:hover {
    filter: brightness(1.1);
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
}

.empty-state p {
    color: hsl(var(--muted-foreground));
    margin: 0;
}

@media (max-width: 768px) {
    .table-venom {
        display: block;
        overflow-x: auto;
    }
}
</style>

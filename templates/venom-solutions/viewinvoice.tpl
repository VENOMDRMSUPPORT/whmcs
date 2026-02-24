{assign var=invoiceNumber value=$invoicenum|default:$invoiceid|default:$id|default:'-'}
{assign var=invoiceClientName value=$clientname|default:$clientsdetails.fullname|default:$clientsdetails.firstname|default:'Client'}
{assign var=invoiceClientEmail value=$clientemail|default:$clientsdetails.email|default:''}
{assign var=invoiceDate value=$date|default:$datecreated|default:'-'}
{assign var=invoiceDueDate value=$duedate|default:$datedue|default:'-'}
{assign var=invoiceLineItems value=$items|default:$invoiceitems}
{assign var=invoiceSubtotal value=$subtotal|default:''}
{assign var=invoiceTax value=$tax|default:$taxtotal|default:''}
{assign var=invoiceTotal value=$total|default:$invoicetotal|default:$balance|default:'--'}

<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Invoice Details</h3>
                <p>Review line items, totals, and invoice status before payment or download.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/clientarea.php?action=invoices" class="client-unified-side-link">All Invoices</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="client-unified-side-link">Add Funds</a>
                <a href="{$WEB_ROOT}/supporttickets.php" class="client-unified-side-link">Billing Support</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="invoice-page">
        <div class="invoice-header">
            <div class="invoice-brand">
                {include file="$template/includes/logo.tpl" size="40px" textSize="1.25rem" gap="12px"}
            </div>
            <div class="invoice-info">
                <h1>Invoice #{$invoiceNumber}</h1>
                <span class="status-badge {$status}">{$status}</span>
            </div>
        </div>

        <div class="invoice-details glass-card">
            <div class="detail-section">
                <h3>From</h3>
                <p><strong>Venom Solutions</strong></p>
                <p>support@venom-solutions.com</p>
            </div>
            <div class="detail-section">
                <h3>Bill To</h3>
                <p><strong>{$invoiceClientName}</strong></p>
                <p>{$invoiceClientEmail}</p>
            </div>
            <div class="detail-section">
                <h3>Invoice Details</h3>
                <p><span>Date:</span> {$invoiceDate}</p>
                <p><span>Due Date:</span> {$invoiceDueDate}</p>
            </div>
        </div>

        <div class="invoice-items glass-card">
            <table class="items-table">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$invoiceLineItems item=item}
                    <tr>
                        <td>{$item.description|default:$item.desc|default:'Invoice Item'}</td>
                        <td>{$item.amount|default:$item.lineamount|default:'--'}</td>
                    </tr>
                    {foreachelse}
                    <tr>
                        <td>Invoice Charges</td>
                        <td>{$invoiceTotal}</td>
                    </tr>
                    {/foreach}
                </tbody>
                <tfoot>
                    {if $invoiceSubtotal}
                    <tr>
                        <td>Subtotal</td>
                        <td>{$invoiceSubtotal}</td>
                    </tr>
                    {/if}
                    {if $invoiceTax}
                    <tr>
                        <td>Tax</td>
                        <td>{$invoiceTax}</td>
                    </tr>
                    {/if}
                    <tr class="total-row">
                        <td>Total</td>
                        <td class="gradient-text">{$invoiceTotal}</td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="invoice-actions">
            <button onclick="window.print()" class="btn-venom-outline">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="6 9 6 2 18 2 18 9"/>
                    <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>
                    <rect x="6" y="14" width="12" height="8"/>
                </svg>
                Print Invoice
            </button>
            {if $status|lower == 'unpaid'}
            <a href="{$WEB_ROOT}/viewinvoice.php?id={$id|default:$invoiceid}&pay=true" class="btn-glow">
                Pay Now
            </a>
            {/if}
        </div>
            </div>
        </main>
    </div>
</div>

<style>
.invoice-page {
    display: grid;
    gap: 24px;
}

.invoice-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 40px;
    gap: 20px;
}

.invoice-info {
    text-align: right;
}

.invoice-info h1 {
    margin: 0 0 12px 0;
    font-size: 1.75rem;
    font-weight: 800;
}

.status-badge {
    display: inline-block;
    padding: 6px 16px;
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

.invoice-details {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 32px;
    padding: 32px;
    border-radius: 16px;
    margin-bottom: 32px;
}

.detail-section h3 {
    margin: 0 0 12px 0;
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: hsl(var(--muted-foreground));
}

.detail-section p {
    margin: 0 0 6px 0;
    font-size: 0.9rem;
}

.detail-section p span {
    color: hsl(var(--muted-foreground));
}

.invoice-items {
    border-radius: 16px;
    overflow: hidden;
    margin-bottom: 32px;
}

.items-table {
    width: 100%;
    border-collapse: collapse;
}

.items-table th,
.items-table td {
    padding: 18px 24px;
    text-align: left;
}

.items-table th {
    background: hsl(var(--card) / 0.5);
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: hsl(var(--muted-foreground));
    font-weight: 700;
}

.items-table th:last-child,
.items-table td:last-child {
    text-align: right;
}

.items-table td {
    border-bottom: 1px solid hsl(var(--border) / 0.5);
}

.items-table tfoot td {
    border-bottom: none;
    font-size: 0.9rem;
}

.items-table tfoot tr.total-row td {
    font-size: 1.25rem;
    font-weight: 800;
    padding-top: 20px;
}

.invoice-actions {
    display: flex;
    gap: 16px;
    justify-content: flex-end;
}

.invoice-actions .btn-venom-outline,
.invoice-actions .btn-glow {
    gap: 10px;
    padding: 14px 28px;
}

@media (max-width: 640px) {
    .invoice-header {
        flex-direction: column;
    }
    
    .invoice-info {
        text-align: left;
    }
    
    .invoice-details {
        grid-template-columns: 1fr;
    }
    
    .invoice-actions {
        flex-direction: column;
    }
}
</style>

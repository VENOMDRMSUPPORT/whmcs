{assign var=displayClientName value=$clientname|default:$clientsdetails.fullname|default:'Client'}
{assign var=displayLocation value=''}
{if $clientsdetails.city}
    {assign var=displayLocation value=$clientsdetails.city}
{/if}
{if $clientsdetails.state}
    {if $displayLocation neq ''}{assign var=displayLocation value="`$displayLocation`, "}{/if}
    {assign var=displayLocation value="`$displayLocation``$clientsdetails.state`"}
{/if}
{if $clientsdetails.country}
    {if $displayLocation neq ''}{assign var=displayLocation value="`$displayLocation`, "}{/if}
    {assign var=displayLocation value="`$displayLocation``$clientsdetails.country`"}
{/if}
{assign var=displayPhone value=$clientsdetails.phonenumberformatted|default:$clientsdetails.phonenumber|default:''}
{assign var=displayCompany value=$clientsdetails.companyname|default:''}
{assign var=activeServicesCount value=$clientsstats.productsnumactive|default:0}
{assign var=walletBalance value=$clientsstats.creditbalance|default:$clientsdetails.credit|default:$creditbalance|default:'0.00'}
{assign var=unpaidInvoicesCount value=$clientsstats.numunpaidinvoices|default:0}
{assign var=openTicketsCount value=$clientsstats.numactivetickets|default:0}
{assign var=recentTickets value=$tickets|default:[]}
{assign var=latestAnnouncements value=$announcements|default:[]}
{assign var=activeServicesPanel value=null}
{if $panels}
    {foreach $panels as $panelItem}
        {assign var=panelName value=$panelItem->getName()|lower}
        {if $panelItem->hasChildren() && (strstr($panelName, 'active') && (strstr($panelName, 'service') || strstr($panelName, 'product')))}
            {assign var=activeServicesPanel value=$panelItem}
        {/if}
    {/foreach}
{/if}

<div class="client-dashboard-page">
    <div class="container client-dashboard-shell">
        <aside class="dashboard-side-col">
            <section class="dashboard-profile-card glass-card">
                <div class="dashboard-profile-header">
                    <div class="dashboard-avatar" aria-hidden="true">
                        <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M20 21a8 8 0 0 0-16 0"></path>
                            <circle cx="12" cy="8" r="4"></circle>
                        </svg>
                    </div>
                    <h2>{$displayClientName}</h2>
                    <p class="profile-email">{$clientsdetails.email|default:'client@example.com'}</p>
                </div>

                <div class="profile-facts" role="list">
                    <div class="profile-fact" role="listitem">
                        <span class="profile-fact-label">Client ID</span>
                        <span class="profile-fact-value">#{$clientsdetails.userid|default:$clientsdetails.id|default:'-'}</span>
                    </div>
                    <div class="profile-fact" role="listitem">
                        <span class="profile-fact-label">Location</span>
                        <span class="profile-fact-value" title="{$displayLocation|default:'Not set'}">{$displayLocation|default:'Not set'}</span>
                    </div>
                    <div class="profile-fact" role="listitem">
                        <span class="profile-fact-label">Phone</span>
                        <span class="profile-fact-value" title="{$displayPhone|default:'Not set'}">{$displayPhone|default:'Not set'}</span>
                    </div>
                    <div class="profile-fact" role="listitem">
                        <span class="profile-fact-label">Company</span>
                        <span class="profile-fact-value" title="{$displayCompany|default:'Not set'}">{$displayCompany|default:'Not set'}</span>
                    </div>
                </div>

                <div class="profile-actions">
                    <a href="{$WEB_ROOT}/clientarea.php?action=details" class="btn-venom-outline">Update</a>
                    <a href="{$WEB_ROOT}/logout.php" class="btn-venom-outline profile-logout">Logout</a>
                </div>
            </section>

            <section class="dashboard-side-card glass-card">
                <h3>Quick Access</h3>
                <a href="{$WEB_ROOT}/cart.php" class="dashboard-side-link">Order New Service</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="dashboard-side-link">Add Funds</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=creditcard" class="dashboard-side-link">Payment Methods</a>
            </section>
        </aside>

        <main class="dashboard-main-col">
            <div class="row g-3 g-md-4 mb-2">
                <div class="col-6 col-lg-3 d-flex">
                    <a href="{$WEB_ROOT}/clientarea.php?action=products" class="stat-card stat-card-link w-100">
                        <div class="stat-card-icon-wrap">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="3" width="7" height="7" rx="1.5"></rect><rect x="14" y="3" width="7" height="7" rx="1.5"></rect><rect x="3" y="14" width="7" height="7" rx="1.5"></rect><rect x="14" y="14" width="7" height="7" rx="1.5"></rect>
                            </svg>
                        </div>
                        <div class="stat-card-value">{$activeServicesCount}</div>
                        <div class="stat-card-label">Services</div>
                    </a>
                </div>
                <div class="col-6 col-lg-3 d-flex">
                    <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="stat-card stat-card-link stat-card-wallet w-100">
                        <div class="stat-card-icon-wrap">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M21 12V7a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5"></path>
                                <path d="M16 12h6"></path>
                                <path d="M18 14a2 2 0 1 0 0-4"></path>
                            </svg>
                        </div>
                        <div class="stat-card-value stat-card-amount">{$walletBalance}</div>
                        <div class="stat-card-label">Wallet Balance</div>
                    </a>
                </div>
                <div class="col-6 col-lg-3 d-flex">
                    <a href="{$WEB_ROOT}/clientarea.php?action=invoices&status=Unpaid" class="stat-card stat-card-link stat-card-danger w-100">
                        <div class="stat-card-icon-wrap">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="9"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line>
                            </svg>
                        </div>
                        <div class="stat-card-value">{$unpaidInvoicesCount}</div>
                        <div class="stat-card-label">Unpaid Invoices</div>
                    </a>
                </div>
                <div class="col-6 col-lg-3 d-flex">
                    <a href="{$WEB_ROOT}/supporttickets.php" class="stat-card stat-card-link w-100">
                        <div class="stat-card-icon-wrap">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                            </svg>
                        </div>
                        <div class="stat-card-value">{$openTicketsCount}</div>
                        <div class="stat-card-label">Open Tickets</div>
                    </a>
                </div>
            </div>

            <section class="dashboard-block glass-card">
                <div class="dashboard-block-head">
                    <h3>
                        <span class="block-title-icon" aria-hidden="true">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="3" width="7" height="7" rx="1.5"></rect><rect x="14" y="3" width="7" height="7" rx="1.5"></rect><rect x="3" y="14" width="7" height="7" rx="1.5"></rect><rect x="14" y="14" width="7" height="7" rx="1.5"></rect>
                            </svg>
                        </span>
                        <span>Your Active Services</span>
                    </h3>
                    <a href="{$WEB_ROOT}/clientarea.php?action=products" class="view-all">View All</a>
                </div>

                {if $services}
                    <div class="dashboard-service-list">
                        {foreach from=$services item=service}
                            <article class="dashboard-service-row">
                                <div class="service-meta">
                                    <strong>{$service.product|default:$service.name|default:'Managed Service'}</strong>
                                    <span>{$service.domain|default:$service.groupname|default:'-'}</span>
                                </div>
                                <span class="status-badge {$service.status|default:'Active'|lower}">{$service.status|default:'Active'}</span>
                                <a href="{$WEB_ROOT}/clientarea.php?action=productdetails&id={$service.id|default:$service.serviceid}" class="btn-venom-outline service-manage-btn">Manage</a>
                            </article>
                        {/foreach}
                    </div>
                {elseif $activeServicesPanel && $activeServicesPanel->hasChildren()}
                    <div class="dashboard-service-list">
                        {foreach $activeServicesPanel->getChildren() as $serviceItem}
                            <article class="dashboard-service-row fallback-service-row">
                                <div class="service-meta">
                                    <strong>{$serviceItem->getLabel()}</strong>
                                </div>
                                {if $serviceItem->hasBadge()}
                                    <span class="status-badge active">{$serviceItem->getBadge()}</span>
                                {/if}
                                {if $serviceItem->getUri()}
                                    <a href="{$serviceItem->getUri()}" class="btn-venom-outline service-manage-btn">Manage</a>
                                {/if}
                            </article>
                        {/foreach}
                    </div>
                {else}
                    <div class="empty-state compact-empty">
                        <h4>No Active Services</h4>
                        <p>You currently have no active products.</p>
                        <a href="{$WEB_ROOT}/cart.php" class="btn-glow">Browse Plans</a>
                    </div>
                {/if}
            </section>

            <div class="dashboard-lower-grid">
                <div class="dashboard-lower-stack">
                    <section class="dashboard-block glass-card">
                        <div class="dashboard-block-head">
                            <h3>
                                <span class="block-title-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                                    </svg>
                                </span>
                                <span>Recent Support Tickets</span>
                            </h3>
                            <a href="{$WEB_ROOT}/supporttickets.php" class="view-all">View All</a>
                        </div>

                        {if $recentTickets}
                            <div class="dashboard-mini-list">
                                {foreach from=$recentTickets item=ticket}
                                    <a href="{$WEB_ROOT}/viewticket.php?tid={$ticket.tid|default:$ticket.id}&c={$ticket.c|default:''}" class="mini-row">
                                        <strong>#{$ticket.tid|default:$ticket.id} - {$ticket.title|default:'Support Request'}</strong>
                                        <span>{$ticket.lastreply|default:$ticket.date|default:'Recently updated'}</span>
                                    </a>
                                {/foreach}
                            </div>
                        {else}
                            <div class="empty-inline">No recent tickets found.</div>
                        {/if}
                    </section>

                    <section class="dashboard-block glass-card">
                        <div class="dashboard-block-head">
                            <h3>
                                <span class="block-title-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M3 11l18-8v18l-18-8z"></path><path d="M11 13v5a2 2 0 0 0 4 0v-3"></path>
                                    </svg>
                                </span>
                                <span>Latest News</span>
                            </h3>
                            <a href="{$WEB_ROOT}/announcements.php" class="view-all">View All</a>
                        </div>

                        {if $latestAnnouncements}
                            <div class="dashboard-mini-list">
                                {foreach from=$latestAnnouncements item=item}
                                    <a href="{$WEB_ROOT}/announcements.php/view/{$item.id}" class="mini-row">
                                        <strong>{$item.title|default:'Announcement'}</strong>
                                        <span>{$item.date|default:''}</span>
                                    </a>
                                {/foreach}
                            </div>
                        {else}
                            <div class="empty-inline">No announcements available.</div>
                        {/if}
                    </section>
                </div>

                <section class="dashboard-block glass-card wallet-block">
                    <div class="dashboard-block-head">
                        <h3>
                            <span class="block-title-icon" aria-hidden="true">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 12V7a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5"></path>
                                    <path d="M16 12h6"></path>
                                    <path d="M18 14a2 2 0 1 0 0-4"></path>
                                </svg>
                            </span>
                            <span>Wallet</span>
                        </h3>
                        <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="view-all wallet-add-funds">Add Funds</a>
                    </div>
                    <p class="wallet-desc">Add credit to your account for faster payments and renewals.</p>
                    <div class="wallet-balance-card">
                        <span class="wallet-balance-label">Current Balance</span>
                        <span class="wallet-balance-value">{$walletBalance}</span>
                    </div>
                    <div class="wallet-actions">
                        <a href="{$WEB_ROOT}/clientarea.php?action=invoices" class="btn-venom-outline wallet-action">View Invoices</a>
                        <a href="{$WEB_ROOT}/clientarea.php?action=creditcard" class="btn-glow wallet-action">Payment Methods</a>
                    </div>
                </section>
            </div>
        </main>
    </div>
</div>

<style>
.client-dashboard-page {
    padding: 24px 0 30px;
}

.client-dashboard-shell {
    display: grid;
    grid-template-columns: 280px minmax(0, 1fr);
    gap: 24px;
    max-width: 1400px;
    padding: 0 16px;
}

.dashboard-side-col {
    display: grid;
    gap: 16px;
    align-content: start;
}

.dashboard-profile-card,
.dashboard-side-card,
.dashboard-block {
    padding: 18px;
    border-radius: 14px;
}

.dashboard-profile-card,
.dashboard-side-card {
    border: 1px solid hsl(var(--primary) / 0.42);
    background: linear-gradient(165deg, hsl(var(--card) / 0.96) 0%, hsl(var(--primary) / 0.06) 100%);
    box-shadow: inset 0 1px 0 rgb(255 255 255 / 0.08), 0 10px 22px hsl(var(--background) / 0.46);
}

.dashboard-profile-header {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.dashboard-avatar {
    width: 56px;
    height: 56px;
    border-radius: 14px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
    background: hsl(var(--primary) / 0.14);
    margin-bottom: 12px;
}

.dashboard-profile-card h2 {
    margin: 0 0 6px;
    font-size: 1.05rem;
}

.dashboard-profile-card p {
    margin: 0 0 4px;
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
}

.profile-email {
    word-break: break-all;
    margin-bottom: 10px;
}

.profile-facts {
    display: grid;
    gap: 6px;
    border-top: 1px solid hsl(var(--primary) / 0.26);
    border-bottom: 1px solid hsl(var(--primary) / 0.22);
    padding: 4px 0;
}

.profile-fact {
    display: grid;
    grid-template-columns: 76px minmax(0, 1fr);
    gap: 8px;
    align-items: baseline;
    font-size: 0.76rem;
    padding: 5px 0;
    border-top: 1px solid hsl(var(--primary) / 0.2);
}

.profile-fact:first-child {
    border-top: none;
}

.profile-fact-label {
    color: hsl(var(--muted-foreground) / 0.95);
    text-transform: uppercase;
    letter-spacing: 0.04em;
    font-weight: 700;
}

.profile-fact-value {
    color: hsl(var(--foreground));
    font-weight: 600;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.profile-actions {
    margin-top: 14px;
    display: flex;
    gap: 8px;
}

.profile-actions a {
    flex: 1;
    justify-content: center;
    min-height: 34px;
    font-size: 0.78rem;
    padding: 0 10px;
}

.profile-logout {
    color: #fda4af;
    border-color: rgb(248 113 113 / 0.42);
}

.dashboard-side-card h3 {
    margin: 0 0 10px;
    font-size: 0.9rem;
}

.dashboard-side-link {
    display: block;
    padding: 8px 10px;
    border-radius: 8px;
    color: hsl(var(--muted-foreground));
    text-decoration: none;
    font-size: 0.82rem;
    border: 1px solid hsl(var(--primary) / 0.24);
    background: hsl(var(--card) / 0.42);
    margin-bottom: 7px;
}

.dashboard-side-link:hover {
    color: hsl(var(--foreground));
    border-color: hsl(var(--primary) / 0.45);
    background: hsl(var(--primary) / 0.08);
}

.dashboard-main-col {
    min-width: 0;
    display: grid;
    gap: 18px;
}

/* Stat cards: professional dashboard design */
.stat-card-link {
    display: block;
    position: relative;
    height: 100%;
    padding: 1.5rem 1.25rem;
    border-radius: 12px;
    background: hsl(var(--card) / 0.6);
    border: 1px solid hsl(var(--border) / 0.6);
    text-decoration: none;
    transition: all 0.2s ease;
}

.stat-card-link:hover {
    background: hsl(var(--card) / 0.85);
    border-color: hsl(var(--primary) / 0.35);
    box-shadow: 0 4px 12px hsl(var(--background) / 0.6);
}

.stat-card-icon-wrap {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 1rem;
    color: hsl(var(--primary));
    background: hsl(var(--primary) / 0.12);
}

.stat-card-value {
    font-size: 2rem;
    font-weight: 700;
    line-height: 1.2;
    color: hsl(var(--foreground));
    letter-spacing: -0.03em;
}

.stat-card-amount {
    font-variant-numeric: tabular-nums;
    font-size: 1.75rem;
}

.stat-card-label {
    margin-top: 0.35rem;
    font-size: 0.8rem;
    font-weight: 500;
    color: hsl(var(--muted-foreground));
}

.stat-card-danger .stat-card-icon-wrap {
    color: #f87171;
    background: rgb(248 113 113 / 0.15);
}

.stat-card-danger .stat-card-value {
    color: #f87171;
}

.stat-card-danger:hover {
    border-color: rgb(248 113 113 / 0.4);
}

.dashboard-block-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 14px;
    padding-bottom: 11px;
    border-bottom: 1px solid hsl(var(--border) / 0.52);
}

.dashboard-block h3 {
    margin: 0;
    font-size: 1rem;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.block-title-icon {
    width: 22px;
    height: 22px;
    border-radius: 8px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
    background: hsl(var(--primary) / 0.12);
    border: 1px solid hsl(var(--primary) / 0.28);
}

.view-all {
    color: hsl(var(--primary));
    text-decoration: none;
    font-size: 0.8rem;
}

.dashboard-service-list {
    display: grid;
}

.dashboard-service-row {
    display: grid;
    grid-template-columns: minmax(0, 1fr) auto auto;
    align-items: center;
    gap: 12px;
    padding: 12px 0;
    border-top: 1px solid hsl(var(--border) / 0.4);
}

.fallback-service-row {
    grid-template-columns: minmax(0, 1fr) auto;
}

.dashboard-service-row:first-child {
    border-top: none;
}

.service-meta strong {
    display: block;
    font-size: 0.9rem;
}

.service-meta span {
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
}

.service-manage-btn {
    padding: 7px 12px;
    font-size: 0.76rem;
}

.status-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 999px;
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.4px;
}

.status-badge.active {
    background: rgb(34 197 94 / 0.16);
    color: #4ade80;
}

.status-badge.suspended {
    background: rgb(251 191 36 / 0.16);
    color: #fbbf24;
}

.status-badge.terminated {
    background: rgb(239 68 68 / 0.16);
    color: #fb7185;
}

.dashboard-lower-grid {
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    gap: 16px;
}

.dashboard-lower-stack {
    display: grid;
    gap: 16px;
}

.dashboard-mini-list {
    display: grid;
}

.mini-row {
    display: block;
    text-decoration: none;
    padding: 10px 0;
    border-top: 1px solid hsl(var(--border) / 0.4);
}

.mini-row:first-child {
    border-top: none;
}

.mini-row strong {
    display: block;
    color: hsl(var(--foreground));
    font-size: 0.84rem;
    margin-bottom: 4px;
}

.mini-row span,
.empty-inline {
    color: hsl(var(--muted-foreground));
    font-size: 0.78rem;
}

.wallet-block p.wallet-desc {
    margin: 0 0 1.25rem;
    color: hsl(var(--muted-foreground));
    font-size: 0.875rem;
    line-height: 1.45;
}

.wallet-add-funds {
    text-decoration: none;
}

.wallet-add-funds:hover {
    text-decoration: underline;
}

.wallet-balance-card {
    padding: 1.25rem;
    border-radius: 10px;
    background: hsl(var(--primary) / 0.1);
    border: 1px solid hsl(var(--primary) / 0.2);
    margin-bottom: 1.25rem;
}

.wallet-balance-label {
    display: block;
    color: hsl(var(--muted-foreground));
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    margin-bottom: 0.5rem;
}

.wallet-balance-value {
    font-size: 1.75rem;
    font-weight: 700;
    font-variant-numeric: tabular-nums;
    letter-spacing: -0.02em;
    color: hsl(var(--foreground));
}

.wallet-actions {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
}

.wallet-action {
    justify-content: center;
    min-height: 40px;
}

.compact-empty {
    padding: 24px 14px;
    text-align: center;
}

.compact-empty h4 {
    margin: 0 0 6px;
}

.compact-empty p {
    margin: 0 0 14px;
    color: hsl(var(--muted-foreground));
    font-size: 0.85rem;
}

@media (max-width: 1100px) {
    .client-dashboard-shell {
        grid-template-columns: 1fr;
        padding: 0 12px;
    }

    .dashboard-side-col {
        grid-template-columns: 1fr 1fr;
    }

    .dashboard-lower-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 760px) {
    .client-dashboard-page {
        padding-top: 16px;
    }

    .client-dashboard-shell {
        padding: 0 8px;
    }

    .dashboard-side-col {
        grid-template-columns: 1fr;
    }

    .dashboard-service-row {
        grid-template-columns: 1fr;
        gap: 8px;
    }

    .service-manage-btn {
        width: fit-content;
    }
}

@media (max-width: 480px) {
    .client-dashboard-page {
        padding: 12px 0 20px;
    }
    
    .client-dashboard-shell {
        padding: 0 6px;
        gap: 12px;
    }
    
    .dashboard-profile-card,
    .dashboard-side-card,
    .dashboard-block {
        padding: 12px;
    }
    
    .stat-card-link {
        padding: 1rem 0.875rem;
    }
    
    .stat-card-icon-wrap {
        width: 32px;
        height: 32px;
        margin-bottom: 0.75rem;
    }
    
    .stat-card-value {
        font-size: 1.5rem;
    }
    
    .stat-card-amount {
        font-size: 1.35rem;
    }
    
    .profile-facts {
        font-size: 0.7rem;
    }
    
    .profile-fact {
        grid-template-columns: 60px 1fr;
    }
    
    .dashboard-block-head {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
    }
    .wallet-actions {
        grid-template-columns: 1fr;
    }

    .wallet-action {
        width: 100%;
    }
}
</style>

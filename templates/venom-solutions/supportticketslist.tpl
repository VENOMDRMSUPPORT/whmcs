<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Support Center</h3>
                <p>Track ticket progress and keep all support communication in one queue.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/supporttickets.php?action=open" class="client-unified-side-link">Open New Ticket</a>
                <a href="{$WEB_ROOT}/knowledgebase.php" class="client-unified-side-link">Knowledgebase</a>
                <a href="{$WEB_ROOT}/announcements.php" class="client-unified-side-link">Announcements</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="tickets-page">
        <div class="page-header">
            <div>
                <h1>Support Tickets</h1>
                <p>View and manage your support requests</p>
            </div>
            <a href="{$WEB_ROOT}/supporttickets.php?action=open" class="btn-glow">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                New Ticket
            </a>
        </div>

        {if $tickets}
        <div class="tickets-list">
            {foreach from=$tickets item=ticket}
            <a href="{$WEB_ROOT}/viewticket.php?tid={$ticket.id|default:$ticket.tid}&c={$ticket.c}" class="ticket-card glass-card">
                <div class="ticket-status {$ticket.status|default:'Open'|lower|replace:' ':'-'}">
                    <span class="status-dot"></span>
                </div>
                <div class="ticket-content">
                    <h3>{$ticket.subject}</h3>
                    <div class="ticket-meta">
                        <span class="ticket-id">#{$ticket.id|default:$ticket.tid}</span>
                        <span class="ticket-date">{$ticket.date|default:$ticket.lastreply|default:'-'}</span>
                    </div>
                </div>
                <div class="ticket-info">
                    <span class="priority {$ticket.priority|default:'Medium'}">{$ticket.priority|default:'Medium'}</span>
                    <span class="department">{$ticket.department|default:'Support'}</span>
                </div>
                <svg class="ticket-arrow" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="9 18 15 12 9 6"/>
                </svg>
            </a>
            {/foreach}
        </div>
        {else}
        <div class="empty-state glass-card">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
            </svg>
            <h2>No Tickets</h2>
            <p>You haven't opened any support tickets yet.</p>
            <a href="{$WEB_ROOT}/supporttickets.php?action=open" class="btn-glow">Open Ticket</a>
        </div>
        {/if}
            </div>
        </main>
    </div>
</div>

<style>
.tickets-page {
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

.tickets-list {
    display: grid;
    gap: 16px;
}

.ticket-card {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 24px;
    border-radius: 16px;
    text-decoration: none;
    transition: all 0.3s ease;
}

.ticket-card:hover {
    transform: translateX(4px);
}

.ticket-status {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    flex-shrink: 0;
}

.ticket-status.Open,
.ticket-status.open {
    background: #4ade80;
    box-shadow: 0 0 8px #4ade80;
}

.ticket-status.Answered {
    background: #3b82f6;
    box-shadow: 0 0 8px #3b82f6;
}

.ticket-status.answered {
    background: #3b82f6;
    box-shadow: 0 0 8px #3b82f6;
}

.ticket-status.Closed {
    background: hsl(var(--muted-foreground));
}

.ticket-status.closed {
    background: hsl(var(--muted-foreground));
}

.ticket-content {
    flex-grow: 1;
}

.ticket-content h3 {
    margin: 0 0 6px 0;
    font-size: 1.05rem;
    font-weight: 700;
    color: hsl(var(--foreground));
}

.ticket-meta {
    display: flex;
    gap: 16px;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
}

.ticket-id {
    font-family: var(--font-mono);
}

.ticket-info {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 6px;
}

.priority {
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    padding: 4px 10px;
    border-radius: 12px;
}

.priority.High {
    background: rgba(239, 68, 68, 0.15);
    color: #f87171;
}

.priority.Medium {
    background: rgba(251, 191, 36, 0.15);
    color: #fbbf24;
}

.priority.Low {
    background: rgba(34, 197, 94, 0.15);
    color: #4ade80;
}

.department {
    font-size: 0.8rem;
    color: hsl(var(--muted-foreground));
}

.ticket-arrow {
    color: hsl(var(--muted-foreground));
    opacity: 0.5;
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

@media (max-width: 640px) {
    .ticket-card {
        flex-wrap: wrap;
    }
    
    .ticket-info {
        align-items: flex-start;
    }
}
</style>

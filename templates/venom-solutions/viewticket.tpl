<div class="viewticket-page">
    <div class="container">
        <div class="page-header">
            <a href="{$WEB_ROOT}/supporttickets.php" class="back-link">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/>
                </svg>
                Back to Tickets
            </a>
            <div class="ticket-title">
                <h1>{$subject}</h1>
                <span class="ticket-id">#{$id}</span>
            </div>
            <span class="status-badge {$status|default:'Open'}">{$status|default:'Open'}</span>
        </div>

        <div class="ticket-thread">
            {foreach from=$replies item=reply}
            <div class="message {if $reply.admin}from-admin{else}from-client{/if}">
                <div class="message-header">
                    <div class="message-author">
                        {if $reply.admin}
                        <div class="avatar admin">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                        </div>
                        <span>Support Team</span>
                        {else}
                        <div class="avatar">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                        </div>
                        <span>{$clientname|default:$clientsdetails.fullname|default:'You'}</span>
                        {/if}
                    </div>
                    <span class="message-date">{$reply.date|default:$reply.timestamp|default:'-'}</span>
                </div>
                <div class="message-body glass-card">
                    {$reply.message|default:$reply.content}
                </div>
            </div>
            {/foreach}
            {if !$replies}
            <div class="message from-client">
                <div class="message-body glass-card">
                    No replies yet. You can send your first message below.
                </div>
            </div>
            {/if}
        </div>

        <div class="reply-form glass-card">
            <h3>Add Reply</h3>
            <form method="post" action="{$WEB_ROOT}/viewticket.php?tid={$id}&c={$c}">
                {if $token}
                    <input type="hidden" name="token" value="{$token}">
                {/if}
                <div class="form-group">
                    <textarea name="replymessage" rows="5" placeholder="Type your reply..." required></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" name="addreply" class="btn-glow">
                        Send Reply
                    </button>
                    {if $status|default:''|lower == 'open'}
                    <button type="submit" name="closeticket" class="btn-venom-outline">
                        Close Ticket
                    </button>
                    {/if}
                </div>
            </form>
        </div>
    </div>
</div>

<style>
.viewticket-page {
    max-width: 900px;
    margin: 0 auto;
    padding: 40px 20px;
}

.back-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: hsl(var(--muted-foreground));
    text-decoration: none;
    font-size: 0.9rem;
    margin-bottom: 24px;
    transition: color 0.2s;
}

.back-link:hover {
    color: hsl(var(--primary));
}

.page-header {
    display: flex;
    align-items: flex-start;
    gap: 20px;
    margin-bottom: 40px;
    flex-wrap: wrap;
}

.ticket-title {
    flex-grow: 1;
}

.ticket-title h1 {
    margin: 0 0 6px 0;
    font-size: 1.5rem;
    font-weight: 800;
}

.ticket-id {
    font-family: var(--font-mono);
    font-size: 0.9rem;
    color: hsl(var(--muted-foreground));
}

.status-badge {
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
}

.status-badge.Open { background: rgba(34, 197, 94, 0.15); color: #4ade80; }
.status-badge.Answered { background: rgba(59, 130, 246, 0.15); color: #3b82f6; }
.status-badge.Closed { background: hsl(var(--muted-foreground) / 0.15); color: hsl(var(--muted-foreground)); }
.status-badge.open { background: rgba(34, 197, 94, 0.15); color: #4ade80; }
.status-badge.answered { background: rgba(59, 130, 246, 0.15); color: #3b82f6; }
.status-badge.closed { background: hsl(var(--muted-foreground) / 0.15); color: hsl(var(--muted-foreground)); }

.ticket-thread {
    display: grid;
    gap: 24px;
    margin-bottom: 32px;
}

.message {
    display: grid;
    gap: 12px;
}

.message-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.message-author {
    display: flex;
    align-items: center;
    gap: 12px;
    font-weight: 600;
}

.avatar {
    width: 40px;
    height: 40px;
    background: hsl(var(--primary) / 0.15);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: hsl(var(--primary));
}

.avatar.admin {
    background: linear-gradient(135deg, hsl(var(--gradient-start)), hsl(var(--gradient-end)));
    color: #fff;
}

.message-date {
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
}

.message-body {
    padding: 24px;
    border-radius: 16px;
    line-height: 1.7;
}

.from-admin .message-body {
    background: hsl(var(--primary) / 0.08);
    border: 1px solid hsl(var(--primary) / 0.2);
}

.from-client .message-body {
    background: hsl(var(--card) / 0.6);
}

.reply-form {
    padding: 32px;
    border-radius: 16px;
}

.reply-form h3 {
    margin: 0 0 20px 0;
    font-size: 1.15rem;
    font-weight: 700;
}

.reply-form textarea {
    width: 100%;
    min-height: 120px;
    resize: vertical;
}

.form-actions {
    display: flex;
    gap: 14px;
    margin-top: 16px;
}

.form-actions .btn-glow,
.form-actions .btn-venom-outline {
    padding: 14px 28px;
}

@media (max-width: 560px) {
    .form-actions {
        flex-direction: column;
    }
}
</style>

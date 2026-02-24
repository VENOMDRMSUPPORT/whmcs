<div class="submit-ticket-page">
    <div class="container">
        <div class="page-header">
            <a href="{$WEB_ROOT}/supporttickets.php" class="back-link">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/>
                </svg>
                Back to Tickets
            </a>
            <h1>Open New Ticket</h1>
            <p>Describe your issue and we'll help you</p>
        </div>

        <div class="ticket-form-card glass-card">
            {if $errormessage}
            <div class="alert alert-error">
                <span>{$errormessage}</span>
            </div>
            {/if}

            <form method="post" action="{$WEB_ROOT}/supporttickets.php?action=open" enctype="multipart/form-data">
                {if $token}
                    <input type="hidden" name="token" value="{$token}">
                {/if}
                <div class="form-row">
                    <div class="form-group">
                        <label>Department</label>
                        <select name="deptid" required>
                            <option value="">Select Department</option>
                            {foreach $departments as $dept}
                            <option value="{$dept.id|default:$dept.did|default:$dept.departmentid}">{$dept.name|default:$dept.department|default:'Support'}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Priority</label>
                        <select name="priority" required>
                            <option value="Low">Low</option>
                            <option value="Medium" selected>Medium</option>
                            <option value="High">High</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" name="subject" placeholder="Brief description of your issue" required>
                </div>

                <div class="form-group">
                    <label>Related Service</label>
                    <select name="serviceid">
                        <option value="">General Inquiry</option>
                        {foreach $services as $service}
                        <option value="{$service.id|default:$service.serviceid}">{$service.product|default:$service.name|default:$service.domain|default:'Service'}</option>
                        {/foreach}
                    </select>
                </div>

                <div class="form-group">
                    <label>Message</label>
                    <textarea name="message" rows="8" placeholder="Describe your issue in detail..." required>{$message|default:''}</textarea>
                </div>

                {if $attachments || $allowattachments}
                <div class="form-group">
                    <label>Attachments</label>
                    <input type="file" name="attachments[]" multiple>
                </div>
                {/if}

                <button type="submit" class="btn-glow">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                    </svg>
                    Submit Ticket
                </button>
            </form>
        </div>
    </div>
</div>

<style>
.submit-ticket-page {
    max-width: 800px;
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

.page-header h1 {
    margin: 0 0 8px 0;
    font-size: 1.75rem;
    font-weight: 800;
}

.page-header p {
    color: hsl(var(--muted-foreground));
    margin: 0;
}

.ticket-form-card {
    padding: 40px;
    border-radius: 20px;
    margin-top: 32px;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    margin-bottom: 24px;
}

.form-group label {
    display: block;
    margin-bottom: 10px;
    font-weight: 600;
}

.form-group select,
.form-group input,
.form-group textarea {
    width: 100%;
}

.form-group textarea {
    resize: vertical;
    min-height: 150px;
}

.ticket-form-card .btn-glow {
    gap: 10px;
    padding: 16px 32px;
    font-size: 1rem;
}

.alert {
    padding: 14px 16px;
    margin-bottom: 24px;
    border-radius: 10px;
}

.alert-error {
    background: rgba(239, 68, 68, 0.1);
    border: 1px solid rgba(239, 68, 68, 0.3);
    color: #f87171;
}

@media (max-width: 560px) {
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .ticket-form-card {
        padding: 28px;
    }
}
</style>

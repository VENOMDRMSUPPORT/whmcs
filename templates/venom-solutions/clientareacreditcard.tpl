<div class="creditcard-page">
    <div class="container">
        <div class="page-header">
            <h1>Payment Methods</h1>
            <p>Manage your saved payment methods</p>
        </div>

        <div class="cards-grid">
            {if $cards}
            {foreach from=$cards item=card}
            <div class="card-item glass-card">
                <div class="card-icon">
                    <svg width="32" height="20" viewBox="0 0 32 20">
                        <rect width="32" height="20" rx="3" fill="#1A1F71"/>
                        <text x="6" y="14" fill="white" font-size="7" font-weight="bold">VISA</text>
                    </svg>
                </div>
                <div class="card-details">
                    <span class="card-number">•••• •••• •••• {$card.last4|default:'----'}</span>
                    <span class="card-expiry">Expires {$card.expiry|default:'--/--'}</span>
                </div>
                <div class="card-actions">
                    <button type="button" class="btn-icon" onclick="deleteCard({$card.id|default:0})">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="3 6 5 6 21 6"/>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                        </svg>
                    </button>
                </div>
            </div>
            {/foreach}
            {elseif $cardlastfour || $cardnum}
            <div class="card-item glass-card">
                <div class="card-icon">
                    <svg width="32" height="20" viewBox="0 0 32 20">
                        <rect width="32" height="20" rx="3" fill="#1A1F71"/>
                        <text x="6" y="14" fill="white" font-size="7" font-weight="bold">CARD</text>
                    </svg>
                </div>
                <div class="card-details">
                    <span class="card-number">•••• •••• •••• {$cardlastfour|default:$cardnum|default:'----'}</span>
                    <span class="card-expiry">Expires {$cardexp|default:$expirydate|default:'--/--'}</span>
                </div>
            </div>
            {else}
            <div class="empty-cards">
                <p>No saved cards</p>
            </div>
            {/if}
        </div>

        <div class="add-card-section glass-card">
            <h2>Add New Card</h2>
            
            <form method="post" action="{$WEB_ROOT}/clientarea.php?action=creditcard" class="card-form">
                {if $token}
                    <input type="hidden" name="token" value="{$token}">
                {/if}
                <input type="hidden" name="action" value="submit">
                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" name="cardnum" placeholder="1234 5678 9012 3456" maxlength="19" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" name="cardexp" placeholder="MM/YY" maxlength="5" required>
                    </div>
                    <div class="form-group">
                        <label>CVV</label>
                        <input type="text" name="cardcvv" placeholder="123" maxlength="4" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Cardholder Name</label>
                    <input type="text" name="cardname" placeholder="John Doe" required>
                </div>

                <div class="form-group">
                    <label class="checkbox-label">
                        <input type="checkbox" name="savecard" checked>
                        <span class="checkbox-custom"></span>
                        Save card for future payments
                    </label>
                </div>

                <button type="submit" class="btn-glow">Add Card</button>
            </form>
        </div>
    </div>
</div>

<script>
function deleteCard(id) {
    if (!id) {
        return;
    }
    if(confirm('Are you sure you want to delete this card?')) {
        window.location.href = '?action=creditcard&delete=' + id;
    }
}

document.addEventListener('DOMContentLoaded', function () {
    var cardNumInput = document.querySelector('input[name="cardnum"]');
    var cardExpInput = document.querySelector('input[name="cardexp"]');

    if (cardNumInput) {
        cardNumInput.addEventListener('input', function(e) {
            var value = e.target.value.replace(/\D/g, '');
            value = value.replace(/(.{4})/g, '$1 ').trim();
            e.target.value = value;
        });
    }

    if (cardExpInput) {
        cardExpInput.addEventListener('input', function(e) {
            var value = e.target.value.replace(/\D/g, '');
            if(value.length >= 2) {
                value = value.slice(0,2) + '/' + value.slice(2);
            }
            e.target.value = value;
        });
    }
});
</script>

<style>
.creditcard-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 40px 20px;
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

.cards-grid {
    display: grid;
    gap: 16px;
    margin-bottom: 32px;
}

.card-item {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 24px;
    border-radius: 16px;
}

.card-icon {
    flex-shrink: 0;
}

.card-details {
    flex-grow: 1;
}

.card-number {
    display: block;
    font-family: var(--font-mono);
    font-size: 1.1rem;
    font-weight: 700;
    margin-bottom: 4px;
}

.card-expiry {
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
}

.btn-icon {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(239, 68, 68, 0.1);
    border: none;
    border-radius: 10px;
    color: #f87171;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-icon:hover {
    background: rgba(239, 68, 68, 0.2);
}

.empty-cards {
    padding: 40px;
    text-align: center;
    color: hsl(var(--muted-foreground));
}

.add-card-section {
    padding: 36px;
    border-radius: 16px;
}

.add-card-section h2 {
    margin: 0 0 28px 0;
    font-size: 1.25rem;
    font-weight: 800;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    margin-bottom: 22px;
}

.form-group label {
    display: block;
    margin-bottom: 10px;
    font-weight: 600;
}

.form-group input {
    width: 100%;
}

.checkbox-label {
    display: flex;
    align-items: center;
    gap: 12px;
    cursor: pointer;
    font-weight: 500;
}

.checkbox-label input {
    display: none;
}

.checkbox-custom {
    width: 22px;
    height: 22px;
    border: 2px solid hsl(var(--border));
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
}

.checkbox-label input:checked + .checkbox-custom {
    background: hsl(var(--primary));
    border-color: hsl(var(--primary));
}

.checkbox-label input:checked + .checkbox-custom::after {
    content: "✓";
    color: #fff;
    font-size: 12px;
    font-weight: 700;
}

.add-card-section .btn-glow {
    padding: 16px 32px;
    margin-top: 8px;
}

@media (max-width: 520px) {
    .form-row {
        grid-template-columns: 1fr;
    }
}
</style>

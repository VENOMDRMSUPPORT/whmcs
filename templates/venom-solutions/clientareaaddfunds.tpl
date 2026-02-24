{assign var=currentBalance value=$balance|default:$creditbalance|default:$clientsdetails.credit|default:'0.00'}

<div class="addfunds-page">
    <div class="container">
        <div class="page-header">
            <h1>Add Funds</h1>
            <p>Add credit to your account for future purchases</p>
        </div>

        <div class="balance-card glass-card">
            <div class="balance-info">
                <span class="balance-label">Current Balance</span>
                <span class="balance-value gradient-text">{$currentBalance}</span>
            </div>
        </div>

        <div class="addfunds-content">
            <div class="amount-section glass-card">
                <h2>Select Amount</h2>
                <div class="amount-options">
                    {if $amounts}
                        {foreach $amounts as $amount}
                            <button type="button" class="amount-btn" data-amount="{$amount}">{$amount}</button>
                        {/foreach}
                    {else}
                        <button type="button" class="amount-btn" data-amount="25">25</button>
                        <button type="button" class="amount-btn" data-amount="50">50</button>
                        <button type="button" class="amount-btn" data-amount="100">100</button>
                    {/if}
                </div>
                <div class="custom-amount">
                    <label>Or enter custom amount</label>
                    <div class="input-group">
                        <span class="currency">$</span>
                        <input type="number" name="amount" id="customAmount" placeholder="0.00" min="1">
                    </div>
                </div>
            </div>

            <div class="payment-section glass-card">
                <h2>Payment Method</h2>
                <div class="payment-methods">
                    <label class="method-card">
                        <input type="radio" name="payment" value="paypal" checked>
                        <div class="method-content">
                            <svg width="40" height="24" viewBox="0 0 40 24">
                                <rect width="40" height="24" rx="4" fill="#003087"/>
                                <text x="20" y="15" fill="white" font-size="8" text-anchor="middle" font-weight="bold">PayPal</text>
                            </svg>
                            <span>PayPal</span>
                        </div>
                    </label>
                    <label class="method-card">
                        <input type="radio" name="payment" value="stripe">
                        <div class="method-content">
                            <svg width="40" height="24" viewBox="0 0 40 24">
                                <rect width="40" height="24" rx="4" fill="#635BFF"/>
                                <text x="20" y="15" fill="white" font-size="7" text-anchor="middle" font-weight="bold">CARD</text>
                            </svg>
                            <span>Credit Card</span>
                        </div>
                    </label>
                    <label class="method-card">
                        <input type="radio" name="payment" value="coinbase">
                        <div class="method-content">
                            <svg width="40" height="24" viewBox="0 0 40 24">
                                <rect width="40" height="24" rx="4" fill="#0052FF"/>
                                <text x="20" y="15" fill="white" font-size="7" text-anchor="middle" font-weight="bold">CRYPTO</text>
                            </svg>
                            <span>Crypto</span>
                        </div>
                    </label>
                </div>

                <form method="post" action="{$WEB_ROOT}/clientarea.php?action=addfunds" class="payment-form">
                    {if $token}
                        <input type="hidden" name="token" value="{$token}">
                    {/if}
                    <input type="hidden" name="amount" id="selectedAmount">
                    <input type="hidden" name="paymentmethod" id="selectedPaymentMethod" value="paypal">
                    <button type="submit" class="btn-glow" style="width: 100%; padding: 16px;">
                        Add Funds
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var amountButtons = document.querySelectorAll('.amount-btn');
    var customAmountInput = document.getElementById('customAmount');
    var selectedAmountInput = document.getElementById('selectedAmount');
    var paymentOptions = document.querySelectorAll('.payment-methods input[type="radio"]');
    var selectedPaymentMethodInput = document.getElementById('selectedPaymentMethod');

    if (!selectedAmountInput || !customAmountInput) {
        return;
    }

    amountButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            amountButtons.forEach(function (b) {
                b.classList.remove('active');
            });
            btn.classList.add('active');
            customAmountInput.value = '';
            selectedAmountInput.value = btn.dataset.amount;
        });
    });

    customAmountInput.addEventListener('input', function () {
        amountButtons.forEach(function (b) {
            b.classList.remove('active');
        });
        selectedAmountInput.value = customAmountInput.value;
    });

    paymentOptions.forEach(function (option) {
        option.addEventListener('change', function () {
            if (selectedPaymentMethodInput && option.checked) {
                selectedPaymentMethodInput.value = option.value;
            }
        });
    });

    if (amountButtons.length && !selectedAmountInput.value) {
        amountButtons[0].click();
    }
});
</script>

<style>
.addfunds-page {
    max-width: 900px;
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

.balance-card {
    padding: 32px;
    border-radius: 16px;
    margin-bottom: 32px;
    text-align: center;
}

.balance-label {
    display: block;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 8px;
}

.balance-value {
    font-size: 3rem;
    font-weight: 900;
}

.addfunds-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 28px;
}

.amount-section,
.payment-section {
    padding: 32px;
    border-radius: 16px;
}

.amount-section h2,
.payment-section h2 {
    margin: 0 0 24px 0;
    font-size: 1.15rem;
    font-weight: 700;
}

.amount-options {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px;
    margin-bottom: 28px;
}

.amount-btn {
    padding: 16px;
    background: hsl(var(--primary) / 0.05);
    border: 1px solid hsl(var(--primary) / 0.2);
    border-radius: 12px;
    color: hsl(var(--foreground));
    font-size: 1.1rem;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.2s;
}

.amount-btn:hover {
    border-color: hsl(var(--primary) / 0.5);
}

.amount-btn.active {
    background: hsl(var(--primary) / 0.15);
    border-color: hsl(var(--primary));
    color: hsl(var(--primary));
}

.custom-amount label {
    display: block;
    font-size: 0.85rem;
    color: hsl(var(--muted-foreground));
    margin-bottom: 10px;
}

.input-group {
    display: flex;
    align-items: center;
    background: hsl(var(--input) / 0.4);
    border: 1px solid hsl(var(--border));
    border-radius: 10px;
    overflow: hidden;
}

.currency {
    padding: 14px 16px;
    background: hsl(var(--card) / 0.5);
    color: hsl(var(--muted-foreground));
    font-weight: 700;
}

.input-group input {
    border: none;
    background: transparent;
    padding: 14px;
    font-size: 1.1rem;
    font-weight: 700;
    width: 100%;
}

.payment-methods {
    display: grid;
    gap: 12px;
    margin-bottom: 28px;
}

.method-card {
    cursor: pointer;
}

.method-card input {
    display: none;
}

.method-content {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 18px 20px;
    background: hsl(var(--input) / 0.3);
    border: 2px solid hsl(var(--border));
    border-radius: 12px;
    transition: all 0.2s;
}

.method-card input:checked + .method-content {
    border-color: hsl(var(--primary));
    background: hsl(var(--primary) / 0.08);
}

.method-content span {
    font-weight: 600;
}

@media (max-width: 768px) {
    .addfunds-content {
        grid-template-columns: 1fr;
    }
    
    .amount-options {
        grid-template-columns: repeat(2, 1fr);
    }
}
</style>

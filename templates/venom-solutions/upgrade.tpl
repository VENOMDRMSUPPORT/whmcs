{assign var=currentServiceId value=$serviceid|default:$id|default:0}
{assign var=currentPlanName value=$currentproduct|default:$productname|default:$product|default:'Current Service'}
{assign var=currentPlanPrice value=$currentprice|default:$recurringamount|default:'--'}
{assign var=upgradeProducts value=$products|default:$upgrades}

<div class="client-unified-page">
    <div class="container client-unified-shell">
        <aside class="client-unified-side">
            <section class="client-unified-side-card glass-card">
                <h3>Plan Upgrade</h3>
                <p>Compare available plans and choose the next tier for better capacity.</p>
            </section>
            <section class="client-unified-side-card glass-card">
                <h3>Quick Actions</h3>
                <a href="{$WEB_ROOT}/clientarea.php?action=productdetails&id={$currentServiceId}" class="client-unified-side-link">Back to Service</a>
                <a href="{$WEB_ROOT}/clientarea.php?action=products" class="client-unified-side-link">All Services</a>
                <a href="{$WEB_ROOT}/supporttickets.php" class="client-unified-side-link">Ask Support</a>
            </section>
        </aside>

        <main class="client-unified-main">
            <div class="upgrade-page">
        <div class="page-header">
            <a href="{$WEB_ROOT}/clientarea.php?action=productdetails&id={$currentServiceId}" class="back-link">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/>
                </svg>
                Back to Service
            </a>
            <h1>Upgrade Your Plan</h1>
            <p>Choose a new plan for your service</p>
        </div>

        <div class="current-plan glass-card">
            <div class="plan-info">
                <span class="label">Current Plan</span>
                <h3>{$currentPlanName}</h3>
            </div>
            <div class="plan-price">
                <span class="label">Current Price</span>
                <span class="gradient-text">{$currentPlanPrice}</span>
            </div>
        </div>

        <div class="upgrade-options">
            <h2>Available Plans</h2>
            <div class="options-grid">
                {if $upgradeProducts}
                {foreach from=$upgradeProducts item=product}
                {assign var=upgradeId value=$product.id|default:$product.pid|default:$product.upgradeid|default:''}
                {assign var=isCurrentUpgrade value=$product.current|default:$product.iscurrent|default:0}
                <div class="option-card glass-card {if $isCurrentUpgrade}current{/if}">
                    {if $isCurrentUpgrade}
                    <div class="current-badge">Current Plan</div>
                    {/if}
                    <div class="option-header">
                        <h3>{$product.name|default:$product.productname|default:'Plan'}</h3>
                        <p>{$product.description|default:$product.desc|default:'Upgrade to this plan for more capacity and features.'}</p>
                    </div>
                    <div class="option-price">
                        <span class="gradient-text">{$product.price|default:$product.total|default:$product.newprice|default:'--'}</span>
                        <span>/ {$product.billingcycle|default:$product.cycle|default:'period'}</span>
                    </div>
                    <ul class="option-features">
                        {if $product.features}
                            {foreach from=$product.features item=feature}
                            <li>
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="20 6 9 17 4 12"/>
                                </svg>
                                {$feature}
                            </li>
                            {/foreach}
                        {else}
                            <li>
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="20 6 9 17 4 12"/>
                                </svg>
                                {$product.description|default:'Priority support and higher service limits.'}
                            </li>
                        {/if}
                    </ul>
                    {if !$isCurrentUpgrade && $upgradeId}
                    <form method="post" action="{$WEB_ROOT}/upgrade.php?type=package&id={$currentServiceId}">
                        {if $token}
                            <input type="hidden" name="token" value="{$token}">
                        {/if}
                        <input type="hidden" name="id" value="{$currentServiceId}">
                        <input type="hidden" name="newproductid" value="{$upgradeId}">
                        <button type="submit" class="btn-glow" style="width: 100%;">
                            Upgrade Now
                        </button>
                    </form>
                    {else}
                    <button class="btn-venom-outline" style="width: 100%;" disabled>
                        {if $isCurrentUpgrade}Current Plan{else}Unavailable{/if}
                    </button>
                    {/if}
                </div>
                {/foreach}
                {else}
                <div class="option-card glass-card current" style="grid-column: 1 / -1; text-align: center;">
                    <div class="option-header" style="margin-bottom: 0;">
                        <h3>No Upgrade Options Available</h3>
                        <p>Please contact support if you need a custom upgrade path.</p>
                    </div>
                </div>
                {/if}
            </div>
        </div>
            </div>
        </main>
    </div>
</div>

<style>
.upgrade-page {
    display: grid;
    gap: 24px;
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

.current-plan {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 28px 32px;
    border-radius: 16px;
    margin: 32px 0 40px;
}

.plan-info .label,
.plan-price .label {
    display: block;
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: hsl(var(--muted-foreground));
    margin-bottom: 6px;
}

.plan-info h3 {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 700;
}

.plan-price span:last-child {
    font-size: 1rem;
    color: hsl(var(--muted-foreground));
}

.upgrade-options h2 {
    margin: 0 0 28px 0;
    font-size: 1.35rem;
    font-weight: 800;
}

.options-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 24px;
}

.option-card {
    padding: 32px;
    border-radius: 20px;
    position: relative;
}

.option-card.current {
    border: 2px solid hsl(var(--primary));
    background: hsl(var(--primary) / 0.03);
}

.current-badge {
    position: absolute;
    top: -12px;
    left: 50%;
    transform: translateX(-50%);
    background: hsl(var(--primary));
    color: #fff;
    padding: 5px 16px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.option-header {
    margin-bottom: 24px;
}

.option-header h3 {
    margin: 0 0 8px 0;
    font-size: 1.35rem;
    font-weight: 800;
}

.option-header p {
    margin: 0;
    color: hsl(var(--muted-foreground));
    font-size: 0.9rem;
}

.option-price {
    margin-bottom: 24px;
}

.option-price .gradient-text {
    font-size: 2.5rem;
    font-weight: 900;
}

.option-price span:last-child {
    color: hsl(var(--muted-foreground));
}

.option-features {
    list-style: none;
    padding: 0;
    margin: 0 0 28px 0;
    display: grid;
    gap: 12px;
}

.option-features li {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 0.9rem;
}

.option-features svg {
    color: hsl(var(--primary));
    flex-shrink: 0;
}

@media (max-width: 640px) {
    .current-plan {
        flex-direction: column;
        gap: 20px;
        text-align: center;
    }
}
</style>

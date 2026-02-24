{assign var=clientRailMenu value=$currentClientMenu|default:''}
{if $clientRailMenu eq ''}
    {if $templatefile eq 'clientareaproducts' or $templatefile eq 'clientareaproductdetails' or $filename eq 'upgrade'}
        {assign var=clientRailMenu value='services'}
    {elseif $templatefile eq 'clientareainvoices' or $templatefile eq 'clientareaaddfunds' or $templatefile eq 'clientarearenewals' or $filename eq 'viewinvoice'}
        {assign var=clientRailMenu value='billing'}
    {elseif $templatefile eq 'clientareadetails' or $templatefile eq 'clientareachangepw' or $templatefile eq 'clientareasecurity' or $templatefile eq 'clientareacreditcard'}
        {assign var=clientRailMenu value='account'}
    {elseif $templatefile eq 'clientareahome'}
        {assign var=clientRailMenu value='dashboard'}
    {/if}
{/if}

<aside class="clientarea-left-rail" aria-label="Client area navigation">
    <div class="client-rail-card glass-card">
        <h3>Client Area</h3>
        <nav class="client-rail-nav">
            <a href="{$WEB_ROOT}/clientarea.php" class="client-rail-item{if $clientRailMenu eq 'dashboard'} is-active{/if}">
                <span>Dashboard</span>
            </a>
            <a href="{$WEB_ROOT}/clientarea.php?action=products" class="client-rail-item{if $clientRailMenu eq 'services'} is-active{/if}">
                <span>Services</span>
            </a>
            <a href="{$WEB_ROOT}/clientarea.php?action=invoices" class="client-rail-item{if $clientRailMenu eq 'billing'} is-active{/if}">
                <span>Billing</span>
            </a>
            <a href="{$WEB_ROOT}/supporttickets.php" class="client-rail-item{if $clientRailMenu eq 'tickets'} is-active{/if}">
                <span>Tickets</span>
            </a>
            <a href="{$WEB_ROOT}/clientarea.php?action=details" class="client-rail-item{if $clientRailMenu eq 'account'} is-active{/if}">
                <span>Account</span>
            </a>
        </nav>
    </div>

    <div class="client-rail-quick glass-card">
        <h4>Quick Actions</h4>
        <div class="client-quick-grid">
            <a href="{$WEB_ROOT}/cart.php" class="client-quick-link">New Order</a>
            <a href="{$WEB_ROOT}/clientarea.php?action=addfunds" class="client-quick-link">Add Funds</a>
            <a href="{$WEB_ROOT}/submitticket.php" class="client-quick-link">Open Ticket</a>
        </div>
    </div>
</aside>

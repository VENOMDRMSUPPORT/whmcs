<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>
    {include file="$template/includes/head.tpl"}
    <link href="{$WEB_ROOT}/templates/{$template}/css/venom-main.css" rel="stylesheet">
    <script defer src="{$WEB_ROOT}/templates/{$template}/js/venom-main.js"></script>
    {$headoutput}
</head>
{assign var=isAuthPage value=($filename eq 'login' or $filename eq 'register' or $filename eq 'pwreset')}
{assign var=isLandingPage value=($filename eq 'index')}
{assign var=useClientHeader value=($loggedin and not $isAuthPage and not $isLandingPage)}
{assign var=headerCartCount value=$cartitemcount|default:0}
{assign var=currentClientMenu value=''}
{if $templatefile eq 'clientareaproducts' or $templatefile eq 'clientareaproductdetails' or $filename eq 'upgrade'}
    {assign var=currentClientMenu value='services'}
{elseif $templatefile eq 'clientareainvoices' or $filename eq 'viewinvoice'}
    {assign var=currentClientMenu value='billing'}
{elseif $filename eq 'supporttickets' or $filename eq 'submitticket' or $filename eq 'viewticket' or $templatefile eq 'supportticketslist' or $templatefile eq 'supportticketsubmit'}
    {assign var=currentClientMenu value='tickets'}
{elseif $templatefile eq 'clientareadetails' or $templatefile eq 'clientareachangepw' or $templatefile eq 'clientareasecurity'}
    {assign var=currentClientMenu value='account'}
{elseif $templatefile eq 'clientareahome'}
    {assign var=currentClientMenu value='dashboard'}
{/if}

<body class="{if $useClientHeader}client-area{else}landing{/if} theme-dark">
    {$headeroutput}
    
    <div class="background-effects">
        <div class="bg-gradient"></div>
        <div class="grid-bg"></div>
        <div class="stars-layer" aria-hidden="true"></div>
        <div class="stars-layer-2" aria-hidden="true"></div>
    </div>

    <header class="venom-header {if $useClientHeader}venom-header-client{/if}">
        <div class="header-container">
            <a href="{if $useClientHeader}{$WEB_ROOT}/clientarea.php{else}{$WEB_ROOT}/index.php{/if}" class="header-brand">
                <span class="header-brand-lockup">
                    {if $useClientHeader}
                        {include file="$template/includes/logo.tpl" size="32px" textSize="1.18rem" gap="10px"}
                    {else}
                        {include file="$template/includes/logo.tpl" size="36px" textSize="1.3rem"}
                    {/if}
                    {if $useClientHeader}
                        <span class="client-area-badge">Client Area</span>
                    {/if}
                </span>
            </a>

            <nav class="header-nav" id="primary-nav">
                {if $useClientHeader}
                    <div class="client-main-nav">
                        <details class="client-main-nav-dropdown">
                            <summary>
                                <span class="client-main-nav-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="3" width="7" height="7" rx="1.5"></rect>
                                        <rect x="14" y="3" width="7" height="7" rx="1.5"></rect>
                                        <rect x="3" y="14" width="7" height="7" rx="1.5"></rect>
                                        <rect x="14" y="14" width="7" height="7" rx="1.5"></rect>
                                    </svg>
                                </span>
                                <span>Services</span>
                            </summary>
                            <div class="client-main-nav-panel">
                                <a href="{$WEB_ROOT}/clientarea.php?action=products"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1.5"></rect><rect x="14" y="3" width="7" height="7" rx="1.5"></rect><rect x="3" y="14" width="7" height="7" rx="1.5"></rect><rect x="14" y="14" width="7" height="7" rx="1.5"></rect></svg></span><span>My Services</span></a>
                                <a href="{$WEB_ROOT}/clientarea.php?action=renewals"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12a9 9 0 1 1-3-6.7"></path><path d="M21 3v6h-6"></path></svg></span><span>Renewals</span></a>
                                <a href="{$WEB_ROOT}/cart.php"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="20" r="1"></circle><circle cx="19" cy="20" r="1"></circle><path d="M2 3h3l2.68 11.39a2 2 0 0 0 2 1.61h7.72a2 2 0 0 0 2-1.6L21 7H6"></path></svg></span><span>Order New Service</span></a>
                            </div>
                        </details>
                        <details class="client-main-nav-dropdown">
                            <summary>
                                <span class="client-main-nav-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="1" y="4" width="22" height="16" rx="2"></rect>
                                        <line x1="1" y1="10" x2="23" y2="10"></line>
                                    </svg>
                                </span>
                                <span>Billing</span>
                            </summary>
                            <div class="client-main-nav-panel">
                                <a href="{$WEB_ROOT}/clientarea.php?action=invoices"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg></span><span>Invoices</span></a>
                                <a href="{$WEB_ROOT}/clientarea.php?action=addfunds"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14"></path><path d="M5 12h14"></path></svg></span><span>Add Funds</span></a>
                                <a href="{$WEB_ROOT}/clientarea.php?action=creditcard"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg></span><span>Payment Methods</span></a>
                                <a href="{$WEB_ROOT}/affiliates.php"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l2.6 5.3 5.9.9-4.3 4.1 1 5.8-5.2-2.8-5.2 2.8 1-5.8-4.3-4.1 5.9-.9L12 3z"></path></svg></span><span>Affiliates</span></a>
                            </div>
                        </details>
                        <details class="client-main-nav-dropdown">
                            <summary>
                                <span class="client-main-nav-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                                    </svg>
                                </span>
                                <span>Support</span>
                            </summary>
                            <div class="client-main-nav-panel">
                                <a href="{$WEB_ROOT}/supporttickets.php"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg></span><span>Support Tickets</span></a>
                                <a href="{$WEB_ROOT}/announcements.php"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 11l18-8v18l-18-8z"></path><path d="M11 13v5a2 2 0 0 0 4 0v-3"></path></svg></span><span>Announcements</span></a>
                                <a href="{$WEB_ROOT}/knowledgebase.php"><span class="client-main-nav-subicon" aria-hidden="true"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg></span><span>Knowledgebase</span></a>
                            </div>
                        </details>
                        <a href="{$WEB_ROOT}/submitticket.php" class="nav-link client-main-nav-link">
                            <span class="client-main-nav-icon" aria-hidden="true">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                                </svg>
                            </span>
                            <span>Open Ticket</span>
                        </a>
                    </div>

                    <div class="client-header-top">
                        <div class="client-header-tools">
                            <details class="client-notifications-dropdown">
                                <summary class="client-header-icon client-notifications-trigger" aria-label="Notifications">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"></path>
                                        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                                    </svg>
                                    <span class="header-alert-count">{count($clientAlerts)|default:0}</span>
                                </summary>
                                <div class="client-notifications-panel">
                                    <div class="client-notifications-head">Notifications</div>
                                    {foreach $clientAlerts as $alert}
                                        <a href="{$alert->getLink()}" class="client-notification-item client-notification-{$alert->getSeverity()}">
                                            <span class="client-notification-icon" aria-hidden="true">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <circle cx="12" cy="12" r="10"></circle>
                                                </svg>
                                            </span>
                                            <span class="client-notification-text">{$alert->getMessage()}</span>
                                        </a>
                                    {foreachelse}
                                        <div class="client-notification-empty">No notifications</div>
                                    {/foreach}
                                </div>
                            </details>

                            <a href="{$WEB_ROOT}/cart.php?a=view" class="client-header-icon client-header-cart" aria-label="Shopping Cart">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="9" cy="20" r="1"></circle>
                                    <circle cx="19" cy="20" r="1"></circle>
                                    <path d="M2 3h3l2.68 11.39a2 2 0 0 0 2 1.61h7.72a2 2 0 0 0 2-1.6L21 7H6"></path>
                                </svg>
                                <span class="header-cart-count">{$headerCartCount}</span>
                            </a>

                            <details class="client-account-dropdown">
                                <summary class="client-account-trigger">
                                    <span class="client-hello-label">Hello</span>
                                    <span class="client-hello-name">{$clientsdetails.firstname|default:'Demo'}</span>
                                    <span class="client-menu-caret" aria-hidden="true">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="m6 9 6 6 6-6"></path>
                                        </svg>
                                    </span>
                                </summary>
                                <div class="client-account-menu">
                                    <a href="{$WEB_ROOT}/clientarea.php?action=details" class="client-menu-item">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M20 21a8 8 0 0 0-16 0"></path>
                                                <circle cx="12" cy="7" r="4"></circle>
                                            </svg>
                                        </span>
                                        <span>Account Details</span>
                                    </a>
                                    <a href="{$WEB_ROOT}/index.php?rp=/user/manage" class="client-menu-item">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                <circle cx="8.5" cy="7" r="4"></circle>
                                                <path d="M20 8v6"></path>
                                                <path d="M23 11h-6"></path>
                                            </svg>
                                        </span>
                                        <span>User Management</span>
                                    </a>
                                    <a href="{$WEB_ROOT}/index.php?rp=/user/contacts" class="client-menu-item">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                <circle cx="9" cy="7" r="4"></circle>
                                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                            </svg>
                                        </span>
                                        <span>Contacts</span>
                                    </a>
                                    <a href="{$WEB_ROOT}/clientarea.php?action=emails" class="client-menu-item">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <rect x="3" y="5" width="18" height="14" rx="2"></rect>
                                                <path d="M3 7l9 6 9-6"></path>
                                            </svg>
                                        </span>
                                        <span>Email History</span>
                                    </a>
                                    <div class="client-menu-separator"></div>
                                    <a href="{$WEB_ROOT}/clientarea.php?action=details" class="client-menu-item">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M20 21a8 8 0 0 0-16 0"></path>
                                                <circle cx="12" cy="7" r="4"></circle>
                                            </svg>
                                        </span>
                                        <span>Your Profile</span>
                                    </a>
                                    <a href="{$WEB_ROOT}/clientarea.php?action=changepw" class="client-menu-item">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <rect x="3" y="11" width="18" height="10" rx="2"></rect>
                                                <path d="M7 11V8a5 5 0 0 1 10 0v3"></path>
                                            </svg>
                                        </span>
                                        <span>Change Password</span>
                                    </a>
                                    <div class="client-menu-separator"></div>
                                    <a href="{$WEB_ROOT}/logout.php" class="client-menu-item client-menu-item-danger">
                                        <span class="client-menu-item-icon" aria-hidden="true">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                                                <path d="M10 17l5-5-5-5"></path>
                                                <path d="M15 12H3"></path>
                                            </svg>
                                        </span>
                                        <span>Logout</span>
                                    </a>
                                </div>
                            </details>
                        </div>
                        <span class="client-login-meta">Logged in as: {$clientsdetails.email|default:$email|default:'client@example.com'}</span>
                    </div>

                {else}
                    <div class="nav-links">
                        <a href="{$WEB_ROOT}/index.php" class="nav-link">
                            <span class="nav-link-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M3 10.5L12 3l9 7.5"></path>
                                    <path d="M5 9.5V21h14V9.5"></path>
                                </svg>
                            </span>
                            <span class="nav-link-label">Home</span>
                        </a>
                        <a href="{$WEB_ROOT}/index.php#features" class="nav-link">
                            <span class="nav-link-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="3" y="3" width="7" height="7" rx="1.5"></rect>
                                    <rect x="14" y="3" width="7" height="7" rx="1.5"></rect>
                                    <rect x="3" y="14" width="7" height="7" rx="1.5"></rect>
                                    <rect x="14" y="14" width="7" height="7" rx="1.5"></rect>
                                </svg>
                            </span>
                            <span class="nav-link-label">Features</span>
                        </a>
                        <a href="{$WEB_ROOT}/index.php#pricing" class="nav-link">
                            <span class="nav-link-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M12 1v22"></path>
                                    <path d="M17 5.5a4.5 4.5 0 0 0-4.5-3.5H10a4 4 0 0 0 0 8h4a4 4 0 0 1 0 8h-2.5A4.5 4.5 0 0 1 7 14.5"></path>
                                </svg>
                            </span>
                            <span class="nav-link-label">Pricing</span>
                        </a>
                    </div>

                    <div class="nav-actions">
                        <a href="{$WEB_ROOT}/cart.php?a=view" class="btn-venom-outline header-cart-btn" aria-label="Shopping Cart">
                            <span class="header-cart-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="9" cy="20" r="1"></circle>
                                    <circle cx="19" cy="20" r="1"></circle>
                                    <path d="M2 3h3l2.68 11.39a2 2 0 0 0 2 1.61h7.72a2 2 0 0 0 2-1.6L21 7H6"></path>
                                </svg>
                            </span>
                            <span>Cart</span>
                            <span class="header-cart-count">{$headerCartCount}</span>
                        </a>
                        {if $loggedin}
                            <a href="{$WEB_ROOT}/clientarea.php" class="btn-glow nav-cta">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                                    <rect x="3" y="3" width="7" height="7" rx="1.5"></rect>
                                    <rect x="14" y="3" width="7" height="7" rx="1.5"></rect>
                                    <rect x="3" y="14" width="7" height="7" rx="1.5"></rect>
                                    <rect x="14" y="14" width="7" height="7" rx="1.5"></rect>
                                </svg>
                                <span>Client Area</span>
                            </a>
                        {else}
                            <a href="{$WEB_ROOT}/login.php" class="btn-venom-outline nav-link-secondary nav-action-link">
                                <span class="nav-link-icon" aria-hidden="true">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                                        <path d="M10 17l5-5-5-5"></path>
                                        <path d="M15 12H3"></path>
                                    </svg>
                                </span>
                                <span class="nav-link-label">Login</span>
                            </a>
                            <a href="{$WEB_ROOT}/register.php" class="btn-glow nav-cta">Get Started</a>
                        {/if}
                    </div>
                {/if}
            </nav>

            {if not $useClientHeader}
                <button class="mobile-menu-toggle" type="button" aria-label="Toggle menu" aria-controls="primary-nav" aria-expanded="false">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
            {/if}
        </div>
    </header>

    <div class="main-body-content">

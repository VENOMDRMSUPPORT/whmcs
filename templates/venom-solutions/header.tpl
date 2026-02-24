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
            <a href="{$WEB_ROOT}/index.php" class="header-brand">
                {include file="$template/includes/logo.tpl" size="36px" textSize="1.3rem"}
                {if $useClientHeader}
                    <span class="client-area-badge">Client Area</span>
                {/if}
            </a>

            <nav class="header-nav" id="primary-nav">
                {if $useClientHeader}
                    <div class="nav-links nav-links-client">
                        <a href="{$WEB_ROOT}/clientarea.php" class="nav-link{if $filename eq 'clientarea'} is-active{/if}">Dashboard</a>
                        <a href="{$WEB_ROOT}/clientarea.php?action=products" class="nav-link{if $templatefile eq 'clientareaproducts' or $templatefile eq 'clientareaproductdetails'} is-active{/if}">Services</a>
                        <a href="{$WEB_ROOT}/clientarea.php?action=invoices" class="nav-link{if $templatefile eq 'clientareainvoices' or $filename eq 'viewinvoice'} is-active{/if}">Billing</a>
                        <a href="{$WEB_ROOT}/supporttickets.php" class="nav-link{if $filename eq 'supporttickets' or $filename eq 'submitticket' or $filename eq 'viewticket'} is-active{/if}">Tickets</a>
                    </div>

                    <div class="nav-actions nav-actions-client">
                        <a href="{$WEB_ROOT}/clientarea.php?action=details" class="client-profile-chip" title="Account details">
                            <span class="client-profile-avatar" aria-hidden="true">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M20 21a8 8 0 0 0-16 0"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </span>
                            <span class="client-profile-content">
                                <span class="client-profile-label">Logged in as</span>
                                <span class="client-profile-name">{$clientsdetails.firstname|default:'Client'} {$clientsdetails.lastname|default:''}</span>
                            </span>
                        </a>
                        <a href="{$WEB_ROOT}/logout.php" class="btn-venom-outline nav-link-secondary client-logout-link">Logout</a>
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
                        {if $loggedin}
                            <a href="{$WEB_ROOT}/clientarea.php" class="btn-glow nav-cta">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                                    <rect x="3" y="3" width="7" height="7" rx="1.5"></rect>
                                    <rect x="14" y="3" width="7" height="7" rx="1.5"></rect>
                                    <rect x="3" y="14" width="7" height="7" rx="1.5"></rect>
                                    <rect x="14" y="14" width="7" height="7" rx="1.5"></rect>
                                </svg>
                                <span>Dashboard</span>
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

            <button class="mobile-menu-toggle" type="button" aria-label="Toggle menu" aria-controls="primary-nav" aria-expanded="false">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </header>

    <div class="main-body-content">

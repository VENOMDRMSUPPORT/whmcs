{* VENOM Solutions — Password Reset Container (matches login page) *}
<div class="venom-auth-page venom-pwreset-page">
    <div class="venom-login-bg"></div>
    
    <div class="venom-login-center">
        <div class="venom-login-motion">
            <div class="venom-glass-card">
                <div class="venom-card-badge">
                    <i class="fas fa-key"></i>
                    <span>Password Reset</span>
                </div>
                <div class="venom-card-header">
                    <a href="{$WEB_ROOT}/" class="venom-logo-link venom-logo-stack">
                        <div class="animated-logo" style="width: 48px; height: 48px;">
                            <div class="animated-logo-glow"></div>
                            <div class="animated-logo-ring-outer"></div>
                            <div class="animated-logo-ring-inner"></div>
                            <div class="animated-logo-ring-decorative"></div>
                            <div class="animated-logo-inner">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M5 3L12 21L19 3" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M8 5L12 15L16 5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                </svg>
                            </div>
                        </div>
                        <span class="venom-brand-text">Venom <span class="text-gradient">DRM</span></span>
                    </a>
                    <p class="venom-card-subtitle">
                        {if $innerTemplate == 'email-prompt'}
                            {lang key='pwresetemailneeded'}
                        {elseif $innerTemplate == 'security-prompt'}
                            {lang key='pwresetsecurityquestionrequired'}
                        {elseif $innerTemplate == 'change-prompt'}
                            {lang key='pwresetenternewpw'}
                        {else}
                            {lang key='pwreset'}
                        {/if}
                    </p>
                </div>

                <div class="venom-flash-area">
                    {include file="$template/includes/flashmessage.tpl"}
                    {if $loggedin && $innerTemplate}
                        {include file="$template/includes/alert.tpl" type="error" msg="{lang key='noPasswordResetWhenLoggedIn'}" textcenter=true}
                    {elseif $successMessage}
                        {include file="$template/includes/alert.tpl" type="success" msg=$successTitle textcenter=true}
                        <p class="venom-text-muted" style="margin: 0.75rem 0 0;">{$successMessage}</p>
                    {/if}
                </div>

                {if $innerTemplate && !$loggedin && !$successMessage}
                    {include file="$template/password-reset-$innerTemplate.tpl"}
                {/if}

                <div class="venom-card-footer">
                    <span class="venom-footer-muted">{lang key='userLogin.notRegistered'} </span>
                    <a href="{$WEB_ROOT}/register.php" class="venom-footer-link">{lang key='userLogin.createAccount'}</a>
                    <span class="venom-footer-muted"> | </span>
                    <a href="{$WEB_ROOT}/login.php" class="venom-footer-link">{lang key='loginbutton'}</a>
                </div>
            </div>
        </div>
    </div>
</div>

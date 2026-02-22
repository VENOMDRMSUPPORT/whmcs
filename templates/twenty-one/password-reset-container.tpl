<div class="venom-pwreset-page venom-auth-page">

    {* Background — matches login/landing 1:1 *}
    <div class="venom-login-bg"></div>

    {* Centered card *}
    <div class="venom-login-center">
        <div class="venom-login-motion">

            <div class="venom-glass-card">

                {* Card header *}
                <div class="venom-card-header">
                    <a href="{$WEB_ROOT}/" class="venom-logo-link">
                        <div class="venom-card-logo animated-logo" style="width:64px;height:64px;">
                            <div class="animated-logo-glow"></div>
                            <div class="animated-logo-ring-outer"></div>
                            <div class="animated-logo-ring-inner"></div>
                            <div class="animated-logo-ring-decorative"></div>
                            <div class="animated-logo-inner">
                                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="filter:drop-shadow(0 0 20px #06b6d4);">
                                    <path d="M5 3L12 21L19 3" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M8 5L12 15L16 5" stroke="#06b6d4" stroke-width="1.5" stroke-linecap="round"/>
                                </svg>
                            </div>
                        </div>
                    </a>
                    <h1 class="venom-card-title">{lang key='pwreset'}</h1>
                    <p class="venom-card-subtitle">
                        {if $innerTemplate == 'email-prompt'}{lang key='pwresetemailneeded'}
                        {elseif $innerTemplate == 'security-prompt'}{lang key='pwresetsecurityquestionrequired'}
                        {elseif $innerTemplate == 'change-prompt'}{lang key='pwresetenternewpw'}
                        {elseif $successMessage}{$successTitle}
                        {else}{lang key='pwresetemailneeded'}{/if}
                    </p>
                </div>

                {* Content *}
                {if $loggedin && $innerTemplate}
                    <div class="venom-flash-area">
                        {include file="$template/includes/alert.tpl" type="error" msg="{lang key='noPasswordResetWhenLoggedIn'}" textcenter=true}
                    </div>
                {else}
                    {if $successMessage}
                        <div class="venom-flash-area">
                            {include file="$template/includes/alert.tpl" type="success" msg=$successTitle textcenter=true}
                        </div>
                        <p class="venom-footer-muted">{$successMessage}</p>
                    {else}
                        {if $innerTemplate}
                            {include file="$template/password-reset-$innerTemplate.tpl"}
                        {/if}
                    {/if}
                {/if}

                {* Back to login *}
                <div class="venom-card-footer">
                    <a href="{$WEB_ROOT}/index.php?rp=/login" class="venom-footer-link">&larr; {lang key='loginbutton'}</a>
                </div>

            </div>

        </div>
    </div>

</div>

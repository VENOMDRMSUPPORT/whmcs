{* VENOM Solutions — Professional Login Page *}
<div class="venom-auth-page venom-login-page">
    <div class="venom-login-bg"></div>
    
    <div class="venom-login-center">
        <div class="venom-login-motion">
            <div class="venom-glass-card">
                <div class="venom-card-badge">
                    <i class="fas fa-lock"></i>
                    <span>Secure Access</span>
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
                    <p class="venom-card-subtitle">{lang key='userLogin.signInToContinue'}</p>
                </div>

                <div class="providerLinkingFeedback"></div>
                
                <div class="venom-flash-area">
                    {include file="$template/includes/flashmessage.tpl"}
                </div>

                <form method="post" action="{routePath('login-validate')}" class="venom-form" role="form">
                    <div class="venom-field">
                        <label for="inputEmail" class="venom-label">{lang key='clientareaemail'}</label>
                        <div class="venom-input-wrap">
                            <span class="venom-input-icon"><i class="fas fa-user"></i></span>
                            <input type="email" class="venom-auth-input" name="username" id="inputEmail" placeholder="{lang key='enteremail'}" autofocus>
                        </div>
                    </div>

                    <div class="venom-field">
                        <label for="inputPassword" class="venom-label">{lang key='clientareapassword'}</label>
                        <div class="venom-input-wrap">
                            <span class="venom-input-icon"><i class="fas fa-key"></i></span>
                            <input type="password" class="venom-auth-input venom-password-input pw-input" name="password" id="inputPassword" placeholder="{lang key='clientareapassword'}" autocomplete="off">
                            <button class="venom-pw-toggle btn-reveal-pw" type="button" tabindex="-1">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="venom-remember-field">
                        <label class="venom-remember-inline">
                            <input type="checkbox" name="rememberme" class="venom-checkbox-input-minimal" />
                            <span>{lang key='loginrememberme'}</span>
                        </label>
                        <a href="{routePath('password-reset-begin')}" class="venom-forgot-link">{lang key='forgotpw'}</a>
                    </div>

                    {if $captcha->isEnabled()}
                        <div class="venom-captcha-wrap">
                            <div class="venom-captcha-block">
                                {include file="$template/includes/captcha.tpl"}
                            </div>
                        </div>
                    {/if}

                    <div class="venom-form-submit">
                        <button id="login" type="submit" class="venom-btn-submit{$captcha->getButtonClass($captchaForm)}">
                            {lang key='loginbutton'}
                        </button>
                    </div>
                </form>

                {if $linkableProviders}
                    <div class="venom-divider"><span>{lang key='remoteAuthn.titleOr'}</span></div>
                    {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
                {/if}

                <div class="venom-card-footer">
                    <span class="venom-footer-muted">{lang key='userLogin.notRegistered'} </span>
                    <a href="{$WEB_ROOT}/register.php" class="venom-footer-link">{lang key='userLogin.createAccount'}</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(function($) {
        // Password reveal toggle
        $('.btn-reveal-pw').on('click', function() {
            var $input = $(this).siblings('.pw-input');
            var $icon = $(this).find('i');
            
            if ($input.attr('type') === 'password') {
                $input.attr('type', 'text');
                $icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                $input.attr('type', 'password');
                $icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });
    });
</script>

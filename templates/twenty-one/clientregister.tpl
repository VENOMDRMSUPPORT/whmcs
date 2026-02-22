{if in_array('state', $optionalFields)}
    <script>
        var statesTab = 10,
            stateNotRequired = true;
    </script>
{/if}

<script src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
<script src="{$BASE_PATH_JS}/PasswordStrength.js"></script>
<script>
    window.langPasswordStrength = "{lang key='pwstrength'}";
    window.langPasswordWeak = "{lang key='pwstrengthweak'}";
    window.langPasswordModerate = "{lang key='pwstrengthmoderate'}";
    window.langPasswordStrong = "{lang key='pwstrengthstrong'}";
    jQuery(document).ready(function() {
        jQuery("#inputNewPassword1").keyup(registerFormPasswordStrengthFeedback);
    });
</script>

<div class="venom-login-page venom-auth-page venom-register-page">
    {* Background — matches landing page 1:1 *}
    <div class="venom-login-bg"></div>

    {* Centered card wrapper *}
    <div class="venom-login-center venom-register-center">
        <div class="venom-login-motion venom-register-motion">

            <div class="venom-glass-card venom-register-card">

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
                    <h1 class="venom-card-title">{lang key='clientregistertitle'}</h1>
                    <p class="venom-card-subtitle">{lang key='orderForm.createAccount'}</p>
                </div>

                {* Error/Status Messages *}
                <div class="venom-flash-area">
                    {if $registrationDisabled}
                        {include file="$template/includes/alert.tpl" type="error" msg="{lang key='registerCreateAccount'}"|cat:' <strong><a href="'|cat:"$WEB_ROOT"|cat:'/cart.php" class="alert-link">'|cat:"{lang key='registerCreateAccountOrder'}"|cat:'</a></strong>'}
                    {/if}

                    {if $errormessage}
                        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
                    {/if}
                </div>

                {if !$registrationDisabled}
                    <div id="registration" class="venom-form-wrap">
                        <form method="post" class="using-password-strength" action="{$smarty.server.PHP_SELF}" role="form" name="orderfrm" id="frmCheckout">
                            <input type="hidden" name="register" value="true"/>

                            <div id="containerNewUserSignup">
                                {include file="$template/includes/linkedaccounts.tpl" linkContext="registration"}

                                {* Section 1: Personal Information - Accordion *}
                                <details class="venom-accordion" open>
                                    <summary class="venom-accordion-header">
                                        <span class="venom-accordion-title">
                                            <i class="venom-accordion-icon fas fa-user-circle"></i>
                                            {lang key='orderForm.personalInformation'}
                                        </span>
                                        <i class="venom-accordion-arrow fas fa-chevron-down"></i>
                                    </summary>
                                    <div class="venom-accordion-body">
                                        <div class="venom-grid">
                                        <div class="venom-field">
                                            <label for="inputFirstName">{lang key='orderForm.firstName'}</label>
                                            <input type="text" name="firstname" id="inputFirstName" class="venom-input" placeholder="{lang key='orderForm.firstName'}" value="{$clientfirstname}" {if !in_array('firstname', $optionalFields)}required{/if} autofocus>
                                        </div>
                                        <div class="venom-field">
                                            <label for="inputLastName">{lang key='orderForm.lastName'}</label>
                                            <input type="text" name="lastname" id="inputLastName" class="venom-input" placeholder="{lang key='orderForm.lastName'}" value="{$clientlastname}" {if !in_array('lastname', $optionalFields)}required{/if}>
                                        </div>
                                        <div class="venom-field">
                                            <label for="inputEmail">{lang key='orderForm.emailAddress'}</label>
                                            <input type="email" name="email" id="inputEmail" class="venom-input" placeholder="{lang key='orderForm.emailAddress'}" value="{$clientemail}">
                                        </div>
                                        <div class="venom-field input-phone-wrap">
                                            <label for="inputPhone">{lang key='orderForm.phoneNumber'}</label>
                                            <input type="tel" name="phonenumber" id="inputPhone" class="venom-input input-phone" placeholder="{lang key='orderForm.phoneNumber'}" value="{$clientphonenumber}">
                                        </div>
                                    </div>
                                </div>
                                </details>

                                {* Section 2: Billing Address - Accordion *}
                                <details class="venom-accordion">
                                    <summary class="venom-accordion-header">
                                        <span class="venom-accordion-title">
                                            <i class="venom-accordion-icon fas fa-map-marked-alt"></i>
                                            {lang key='orderForm.billingAddress'}
                                        </span>
                                        <i class="venom-accordion-arrow fas fa-chevron-down"></i>
                                    </summary>
                                    <div class="venom-accordion-body">
                                        <div class="venom-grid">
                                            <div class="venom-field full-width">
                                                <label for="inputCompanyName">{lang key='orderForm.companyName'} <span class="venom-text-muted">({lang key='orderForm.optional'})</span></label>
                                                <input type="text" name="companyname" id="inputCompanyName" class="venom-input" placeholder="{lang key='orderForm.companyName'}" value="{$clientcompanyname}">
                                            </div>
                                            <div class="venom-field full-width">
                                                <label for="inputAddress1">{lang key='orderForm.streetAddress'}</label>
                                                <input type="text" name="address1" id="inputAddress1" class="venom-input" placeholder="{lang key='orderForm.streetAddress'}" value="{$clientaddress1}" {if !in_array('address1', $optionalFields)}required{/if}>
                                            </div>
                                            <div class="venom-field full-width">
                                                <label for="inputAddress2">{lang key='orderForm.streetAddress2'} <span class="venom-text-muted">({lang key='orderForm.optional'})</span></label>
                                                <input type="text" name="address2" id="inputAddress2" class="venom-input" placeholder="{lang key='orderForm.streetAddress2'}" value="{$clientaddress2}">
                                            </div>
                                            <div class="venom-field">
                                                <label for="inputCity">{lang key='orderForm.city'}</label>
                                                <input type="text" name="city" id="inputCity" class="venom-input" placeholder="{lang key='orderForm.city'}" value="{$clientcity}" {if !in_array('city', $optionalFields)}required{/if}>
                                            </div>
                                            <div class="venom-field">
                                                <label id="inputStateIcon" for="state">{lang key='orderForm.state'}</label>
                                                <input type="text" name="state" id="state" class="venom-input" placeholder="{lang key='orderForm.state'}" value="{$clientstate}" {if !in_array('state', $optionalFields)}required{/if}>
                                            </div>
                                            <div class="venom-field">
                                                <label for="inputPostcode">{lang key='orderForm.postcode'}</label>
                                                <input type="text" name="postcode" id="inputPostcode" class="venom-input" placeholder="{lang key='orderForm.postcode'}" value="{$clientpostcode}" {if !in_array('postcode', $optionalFields)}required{/if}>
                                            </div>
                                            <div class="venom-field">
                                                <label id="inputCountryIcon" for="inputCountry">{lang key='orderForm.country'}</label>
                                                <select name="country" id="inputCountry" class="venom-input venom-select">
                                                    {foreach $clientcountries as $countryCode => $countryName}
                                                        <option value="{$countryCode}"{if (!$clientcountry && $countryCode eq $defaultCountry) || ($countryCode eq $clientcountry)} selected="selected"{/if}>
                                                            {$countryName}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            {if $showTaxIdField}
                                                <div class="venom-field full-width">
                                                    <label for="inputTaxId">{$taxLabel} <span class="venom-text-muted">({lang key='orderForm.optional'})</span></label>
                                                    <input type="text" name="tax_id" id="inputTaxId" class="venom-input" placeholder="{$taxLabel}" value="{$clientTaxId}">
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </details>

                                {* Custom Fields / Currency *}
                                {if $customfields || $currencies}
                                    <details class="venom-accordion">
                                        <summary class="venom-accordion-header">
                                            <span class="venom-accordion-title">
                                                <i class="venom-accordion-icon fas fa-list-alt"></i>
                                                {lang key='orderadditionalrequiredinfo'}
                                            </span>
                                            <i class="venom-accordion-arrow fas fa-chevron-down"></i>
                                        </summary>
                                        <div class="venom-accordion-body">
                                            <div class="venom-grid">
                                                {if $customfields}
                                                    {foreach $customfields as $customfield}
                                                        <div class="venom-field {if $customfield.type eq 'textarea'}full-width{/if}">
                                                            <label for="customfield{$customfield.id}">{$customfield.name} {$customfield.required}</label>
                                                            <div class="venom-custom-field-control">
                                                                {$customfield.input}
                                                                {if $customfield.description}
                                                                    <span class="venom-field-help">{$customfield.description}</span>
                                                                {/if}
                                                            </div>
                                                        </div>
                                                    {/foreach}
                                                {/if}
                                                
                                                {if $currencies}
                                                    <div class="venom-field">
                                                        <label for="inputCurrency">{lang key='currency'}</label>
                                                        <select id="inputCurrency" name="currency" class="venom-input venom-select">
                                                            {foreach $currencies as $curr}
                                                                <option value="{$curr.id}"{if !$smarty.post.currency && $curr.default || $smarty.post.currency eq $curr.id } selected{/if}>{$curr.code}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>
                                    </details>
                                {/if}
                            </div>

                            {* Section 3: Account Security - Accordion *}
                            <details class="venom-accordion">
                                <summary class="venom-accordion-header">
                                    <span class="venom-accordion-title">
                                        <i class="venom-accordion-icon fas fa-lock"></i>
                                        {lang key='orderForm.accountSecurity'}
                                    </span>
                                    <i class="venom-accordion-arrow fas fa-chevron-down"></i>
                                </summary>
                                <div class="venom-accordion-body">
                                    <div id="containerNewUserSecurity" {if $remote_auth_prelinked && !$securityquestions } class="w-hidden"{/if}>
                                        <div class="venom-section">
                                            <div id="containerPassword" class="{if $remote_auth_prelinked && $securityquestions}hidden{/if}">
                                                <div id="passwdFeedback" class="venom-alert text-center w-hidden"></div>
                                                
                                                <div class="venom-grid">
                                                    <div class="venom-field">
                                                        <div class="venom-field-header">
                                                            <label for="inputNewPassword1">{lang key='clientareapassword'}</label>
                                                            <a href="#" class="venom-link generate-password" data-targetfields="inputNewPassword1,inputNewPassword2"><i class="fas fa-magic"></i> Auto-create</a>
                                                        </div>
                                                        <div class="venom-input-wrap">
                                                            <input type="password" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" class="venom-input" placeholder="{lang key='clientareapassword'}" autocomplete="off"{if $remote_auth_prelinked} value="{$password}"{/if}>
                                                            <button type="button" class="venom-pw-toggle" onclick="venomTogglePw('inputNewPassword1', this)"><i class="fas fa-eye"></i></button>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="venom-field">
                                                        <label for="inputNewPassword2">{lang key='clientareaconfirmpassword'}</label>
                                                        <div class="venom-input-wrap">
                                                            <input type="password" name="password2" id="inputNewPassword2" class="venom-input" placeholder="{lang key='clientareaconfirmpassword'}" autocomplete="off"{if $remote_auth_prelinked} value="{$password}"{/if}>
                                                            <button type="button" class="venom-pw-toggle" onclick="venomTogglePw('inputNewPassword2', this)"><i class="fas fa-eye"></i></button>
                                                        </div>
                                                    </div>

                                                    <div class="venom-field full-width">
                                                        <div class="password-strength-meter venom-pw-meter">
                                                            <div class="progress">
                                                                <div class="progress-bar bg-success bg-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="passwordStrengthMeterBar"></div>
                                                            </div>
                                                            <span id="passwordStrengthTextLabel" class="venom-text-muted">{lang key='pwstrength'}: {lang key='pwstrengthenter'}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            {if $securityquestions}
                                                <div class="venom-grid" style="margin-top: 1.25rem;">
                                                    <div class="venom-field full-width">
                                                        <label for="inputSecurityQId">{lang key='clientareasecurityquestion'}</label>
                                                        <select name="securityqid" id="inputSecurityQId" class="venom-input venom-select">
                                                            <option value="">{lang key='clientareasecurityquestion'}</option>
                                                            {foreach $securityquestions as $question}
                                                                <option value="{$question.id}"{if $question.id eq $securityqid} selected{/if}>
                                                                    {$question.question}
                                                                </option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <div class="venom-field full-width">
                                                        <label for="inputSecurityQAns">{lang key='clientareasecurityanswer'}</label>
                                                        <div class="venom-input-wrap">
                                                            <input type="password" name="securityqans" id="inputSecurityQAns" class="venom-input" placeholder="{lang key='clientareasecurityanswer'}" autocomplete="off">
                                                            <button type="button" class="venom-pw-toggle" onclick="venomTogglePw('inputSecurityQAns', this)"><i class="fas fa-eye"></i></button>
                                                        </div>
                                                    </div>
                                                </div>
                                            {/if}

                                        </div>
                                    </div>
                                </div>
                            </details>

                            {* Marketing Opt In *}
                            {if $showMarketingEmailOptIn}
                                <div class="venom-optin">
                                    <label class="venom-checkbox-label">
                                        <input type="checkbox" name="marketingoptin" value="1"{if $marketingEmailOptIn} checked{/if} class="venom-checkbox">
                                        <span style="font-size: 0.9rem;">
                                            <strong class="venom-text-bright">{lang key='emailMarketing.joinOurMailingList'}</strong><br>
                                            <span class="venom-text-muted">{$marketingEmailOptInMessage}</span>
                                        </span>
                                    </label>
                                </div>
                            {/if}

                            {* CAPTCHA - wrapped for styling *}
                            <div class="venom-captcha-wrap">
                                <div class="venom-captcha-block">
                                    {include file="$template/includes/captcha.tpl"}
                                </div>
                            </div>

                            {* Terms of Service *}
                            {if $accepttos}
                                <div class="venom-optin" style="margin-top: 1.5rem;">
                                    <label class="venom-checkbox-label">
                                        <input type="checkbox" name="accepttos" class="venom-checkbox accepttos">
                                        <span style="font-size: 0.9rem;">{lang key='ordertosagreement'} <a href="{$tosurl}" target="_blank" class="venom-link">{lang key='ordertos'}</a></span>
                                    </label>
                                </div>
                            {/if}

                            {* Submit *}
                            <div class="venom-form-actions">
                                <button class="venom-btn-submit {$captcha->getButtonClass($captchaForm)}" type="submit">
                                    {lang key='clientregistertitle'} <i class="fas fa-arrow-right" style="margin-left: 0.5rem;"></i>
                                </button>
                            </div>

                        </form>
                    </div> {* #registration *}
                {/if}

                {* Footer - Login Link *}
                {if !$registrationDisabled}
                <div class="venom-card-footer text-center">
                    <span class="venom-text-muted">Already registered?&nbsp;</span>
                    <a href="{$WEB_ROOT}/login.php" class="venom-link" style="font-weight: 600;">Login here</a>
                </div>
                {/if}

            </div> {* .venom-glass-card *}
        </div> {* .venom-register-motion *}
    </div> {* .venom-login-center *}
</div> {* .venom-login-page *}

{literal}
<script>
function venomTogglePw(inputId, btn) {
    var input = document.getElementById(inputId);
    var isText = input.type === 'text';
    input.type = isText ? 'password' : 'text';
    var icon = btn.querySelector('i');
    if (isText) {
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
        btn.style.color = '#8899aa';
    } else {
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
        btn.style.color = '#06b6d4';
    }
}
</script>
{/literal}

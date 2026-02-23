{* VENOM Solutions — Password Reset Change Prompt *}
<form class="venom-form using-password-strength" method="POST" action="{routePath('password-reset-change-perform')}">
    <input type="hidden" name="answer" id="answer" value="{$securityAnswer}" />

    <div class="venom-field">
        <label for="inputNewPassword1" class="venom-label">{lang key='newpassword'}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon"><i class="fas fa-lock"></i></span>
            <input type="password" name="newpw" id="inputNewPassword1" class="venom-auth-input venom-password-input pw-input" autocomplete="off" placeholder="{lang key='newpassword'}">
            <button class="venom-pw-toggle btn-reveal-pw" type="button" tabindex="-1">
                <i class="fas fa-eye"></i>
            </button>
        </div>
    </div>

    <div class="venom-field">
        <label for="inputNewPassword2" class="venom-label">{lang key='confirmnewpassword'}</label>
        <div class="venom-input-wrap">
            <span class="venom-input-icon"><i class="fas fa-lock"></i></span>
            <input type="password" name="confirmpw" id="inputNewPassword2" class="venom-auth-input venom-password-input pw-input" autocomplete="off" placeholder="{lang key='confirmnewpassword'}">
            <button class="venom-pw-toggle btn-reveal-pw" type="button" tabindex="-1">
                <i class="fas fa-eye"></i>
            </button>
        </div>
        <div id="inputNewPassword2Msg" class="venom-field-help"></div>
    </div>

    <div class="venom-field">
        <label class="venom-label">{lang key='pwstrength'}</label>
        <div class="venom-pw-meter">
            <div class="progress" style="height: 6px; background: rgba(30, 41, 59, 0.6); border-radius: 999px; overflow: hidden;">
                <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="passwordStrengthMeterBar" style="border-radius: 999px; transition: width 0.3s ease;"></div>
            </div>
            <p class="venom-pw-label" id="passwordStrengthTextLabel">{lang key='pwstrength'}: {lang key='pwstrengthenter'}</p>
        </div>
    </div>

    <div class="venom-form-submit">
        <button type="submit" name="submit" class="venom-btn-submit">
            {lang key='clientareasavechanges'}
        </button>
    </div>
</form>

<script src="{$BASE_PATH_JS}/PasswordStrength.js"></script>
<script>
    window.langPasswordStrength = "{lang key='pwstrength'}";
    window.langPasswordWeak = "{lang key='pwstrengthweak'}";
    window.langPasswordModerate = "{lang key='pwstrengthmoderate'}";
    window.langPasswordStrong = "{lang key='pwstrengthstrong'}";
    
    jQuery(document).ready(function($) {
        // Password strength meter
        $('#inputNewPassword1').keyup(function() {
            var password = $(this).val();
            var strength = 0;
            
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            var $bar = $('#passwordStrengthMeterBar');
            var $label = $('#passwordStrengthTextLabel');
            
            $bar.css('width', (strength * 20) + '%');
            
            if (strength <= 1) {
                $bar.css('background', '#ef4444');
                $label.text(window.langPasswordStrength + ': ' + window.langPasswordWeak);
            } else if (strength <= 3) {
                $bar.css('background', '#f59e0b');
                $label.text(window.langPasswordStrength + ': ' + window.langPasswordModerate);
            } else {
                $bar.css('background', '#22c55e');
                $label.text(window.langPasswordStrength + ': ' + window.langPasswordStrong);
            }
        });
        
        // Password toggle
        $('.venom-pw-toggle').on('click', function() {
            var $input = $(this).siblings('input');
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

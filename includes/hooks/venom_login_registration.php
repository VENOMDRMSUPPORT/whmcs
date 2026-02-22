<?php
/**
 * VENOM DRM - Login Page Registration Link
 *
 * Passes registrationDisabled to the login template so the "Get Started"
 * link is hidden when admin disables client registration (Setup > General Settings).
 * Matches WHMCS behavior: clientregister.tpl uses the same variable.
 *
 * @package VENOM_DRM
 * @location includes/hooks/venom_login_registration.php
 */

if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

add_hook('ClientAreaPageLogin', 1, function ($vars) {
    $allowReg = \WHMCS\Database\Capsule::table('tblconfiguration')
        ->where('setting', 'AllowClientRegister')
        ->value('value');

    $registrationDisabled = ($allowReg !== 'on');

    return [
        'registrationDisabled' => $registrationDisabled,
    ];
});

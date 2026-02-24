    </div>

    {assign var=isAuthPage value=($filename eq 'login' or $filename eq 'register' or $filename eq 'pwreset')}
    {assign var=isLandingPage value=($filename eq 'index')}
    {assign var=useClientFooter value=($loggedin and not $isAuthPage and not $isLandingPage)}
    {assign var=localeCurrencyBaseUrl value=$currentpagelinkback|default:$WEB_ROOT}
    {assign var=localeCurrencySeparator value='?'}
    {if strstr($localeCurrencyBaseUrl, '?')}
        {assign var=localeCurrencySeparator value='&'}
    {/if}

    {if $useClientFooter}
        <footer class="venom-client-footer">
            <div class="footer-container client-footer-container">
                <p class="client-footer-copy">&copy; {$date_year} Venom Solutions. All rights reserved.</p>

                <div class="client-footer-right">
                    <div class="client-footer-payments" aria-label="Accepted payment methods">
                        <span class="payment-chip" title="Visa" aria-label="Visa">
                        <img src="https://cdn.simpleicons.org/visa/5F8BFF" alt="Visa" class="payment-logo payment-logo-visa" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="Mastercard" aria-label="Mastercard">
                        <img src="https://cdn.simpleicons.org/mastercard/FF5C5C" alt="Mastercard" class="payment-logo payment-logo-mastercard" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="PayPal" aria-label="PayPal">
                        <img src="https://cdn.simpleicons.org/paypal/00B5FF" alt="PayPal" class="payment-logo payment-logo-paypal" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="USDT" aria-label="USDT">
                        <img src="https://cdn.simpleicons.org/tether/37E4B7" alt="USDT" class="payment-logo payment-logo-usdt" loading="lazy" decoding="async">
                        </span>
                        <span class="payment-chip" title="Bitcoin" aria-label="Bitcoin">
                        <img src="https://cdn.simpleicons.org/bitcoin/FFC247" alt="Bitcoin" class="payment-logo payment-logo-btc" loading="lazy" decoding="async">
                        </span>
                    </div>

                    <div class="client-footer-controls">
                        {if $languagechangeenabled && count($locales) > 1}
                            {assign var=activeFlagCode value='us'}
                            {assign var=activeLocaleKey value=$activeLocale.language|lower}
                            {assign var=activeLocaleName value=$activeLocale.localisedName|lower}
                            {if $activeLocaleKey eq 'english' || strstr($activeLocaleName, 'english')}
                                {assign var=activeFlagCode value='us'}
                            {elseif $activeLocaleKey eq 'arabic' || strstr($activeLocaleName, 'arab')}
                                {assign var=activeFlagCode value='sa'}
                            {elseif $activeLocaleKey eq 'french' || strstr($activeLocaleName, 'fran')}
                                {assign var=activeFlagCode value='fr'}
                            {elseif $activeLocaleKey eq 'spanish' || strstr($activeLocaleName, 'espa')}
                                {assign var=activeFlagCode value='es'}
                            {elseif $activeLocaleKey eq 'german' || strstr($activeLocaleName, 'deut')}
                                {assign var=activeFlagCode value='de'}
                            {elseif $activeLocaleKey eq 'italian' || strstr($activeLocaleName, 'ital')}
                                {assign var=activeFlagCode value='it'}
                            {elseif $activeLocaleKey eq 'turkish' || strstr($activeLocaleName, 'türk') || strstr($activeLocaleName, 'turk')}
                                {assign var=activeFlagCode value='tr'}
                            {elseif $activeLocaleKey eq 'russian' || strstr($activeLocaleName, 'рус')}
                                {assign var=activeFlagCode value='ru'}
                            {elseif $activeLocaleKey eq 'portuguese-br'}
                                {assign var=activeFlagCode value='br'}
                            {elseif $activeLocaleKey eq 'portuguese-pt' || strstr($activeLocaleKey, 'portugu') || strstr($activeLocaleName, 'portugu')}
                                {assign var=activeFlagCode value='pt'}
                            {elseif $activeLocaleKey eq 'chinese' || strstr($activeLocaleName, '中文') || strstr($activeLocaleName, 'chinese')}
                                {assign var=activeFlagCode value='cn'}
                            {elseif strstr($activeLocaleKey, 'dutch') || strstr($activeLocaleName, 'neder')}
                                {assign var=activeFlagCode value='nl'}
                            {elseif strstr($activeLocaleKey, 'azer') || strstr($activeLocaleName, 'azərbay') || strstr($activeLocaleName, 'azeri') || strstr($activeLocaleName, 'azerbaijani')}
                                {assign var=activeFlagCode value='az'}
                            {elseif strstr($activeLocaleKey, 'catal') || strstr($activeLocaleName, 'catal')}
                                {assign var=activeFlagCode value='es'}
                            {elseif strstr($activeLocaleKey, 'croat') || strstr($activeLocaleName, 'hrvat')}
                                {assign var=activeFlagCode value='hr'}
                            {elseif strstr($activeLocaleKey, 'czech') || strstr($activeLocaleName, 'češt') || strstr($activeLocaleName, 'cest')}
                                {assign var=activeFlagCode value='cz'}
                            {elseif strstr($activeLocaleKey, 'dan') || strstr($activeLocaleName, 'dansk')}
                                {assign var=activeFlagCode value='dk'}
                            {elseif strstr($activeLocaleKey, 'eston') || strstr($activeLocaleName, 'eston')}
                                {assign var=activeFlagCode value='ee'}
                            {elseif strstr($activeLocaleKey, 'persian') || strstr($activeLocaleName, 'persian') || strstr($activeLocaleName, 'فار')}
                                {assign var=activeFlagCode value='ir'}
                            {elseif strstr($activeLocaleKey, 'hebrew') || strstr($activeLocaleName, 'עבר')}
                                {assign var=activeFlagCode value='il'}
                            {elseif strstr($activeLocaleKey, 'hungar') || strstr($activeLocaleName, 'magyar')}
                                {assign var=activeFlagCode value='hu'}
                            {elseif strstr($activeLocaleKey, 'maced') || strstr($activeLocaleName, 'maced')}
                                {assign var=activeFlagCode value='mk'}
                            {elseif strstr($activeLocaleKey, 'norweg') || strstr($activeLocaleName, 'norweg')}
                                {assign var=activeFlagCode value='no'}
                            {elseif strstr($activeLocaleKey, 'roman') || strstr($activeLocaleName, 'român') || strstr($activeLocaleName, 'roman')}
                                {assign var=activeFlagCode value='ro'}
                            {elseif strstr($activeLocaleKey, 'ukrain') || strstr($activeLocaleName, 'укра')}
                                {assign var=activeFlagCode value='ua'}
                            {elseif strstr($activeLocaleKey, 'slovak') || strstr($activeLocaleName, 'sloven')}
                                {assign var=activeFlagCode value='sk'}
                            {elseif strstr($activeLocaleKey, 'slovene') || strstr($activeLocaleName, 'slovenšč')}
                                {assign var=activeFlagCode value='si'}
                            {/if}
                            <button type="button" class="client-footer-picker-trigger" data-modal-open="footer-locale-modal" aria-haspopup="dialog" aria-controls="footer-locale-modal">
                                <img src="https://flagcdn.com/20x15/{$activeFlagCode}.png" alt="{$activeLocale.localisedName|default:'English'} flag" loading="lazy" decoding="async">
                                <span class="client-footer-picker-label">{$activeLocale.localisedName|default:'English'}</span>
                            </button>
                        {/if}

                        <button type="button" class="client-footer-top js-back-to-top" aria-label="Back to top">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="m18 15-6-6-6 6"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </footer>

        {if $languagechangeenabled && count($locales) > 1}
            <div class="client-locale-modal" id="footer-locale-modal" role="dialog" aria-modal="true" aria-labelledby="footer-locale-modal-title" hidden>
                <div class="client-locale-modal-backdrop" data-modal-close="footer-locale-modal"></div>
                <div class="client-locale-modal-card" role="document">
                    <div class="client-locale-modal-head">
                        <h3 id="footer-locale-modal-title">Language</h3>
                        <button type="button" class="client-locale-modal-close" data-modal-close="footer-locale-modal" aria-label="Close language selector">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M18 6 6 18"></path>
                                <path d="m6 6 12 12"></path>
                            </svg>
                        </button>
                    </div>

                    <div class="client-locale-modal-body">
                        <span class="client-footer-picker-title">Language</span>
                        <div class="client-locale-grid">
                            {foreach $locales as $locale}
                                    {assign var=flagCode value='us'}
                                    {assign var=localeKey value=$locale.language|lower}
                                    {assign var=localeName value=$locale.localisedName|lower}
                                    {assign var=skipLocale value=(strstr($localeKey, 'swed') || strstr($localeName, 'svenska'))}
                                    {if !$skipLocale && ($localeKey eq 'english' || strstr($localeName, 'english'))}
                                        {assign var=flagCode value='us'}
                                    {elseif !$skipLocale && ($localeKey eq 'arabic' || strstr($localeName, 'arab'))}
                                        {assign var=flagCode value='sa'}
                                    {elseif !$skipLocale && ($localeKey eq 'french' || strstr($localeName, 'fran'))}
                                        {assign var=flagCode value='fr'}
                                    {elseif !$skipLocale && ($localeKey eq 'spanish' || strstr($localeName, 'espa'))}
                                        {assign var=flagCode value='es'}
                                    {elseif !$skipLocale && ($localeKey eq 'german' || strstr($localeName, 'deut'))}
                                        {assign var=flagCode value='de'}
                                    {elseif !$skipLocale && ($localeKey eq 'italian' || strstr($localeName, 'ital'))}
                                        {assign var=flagCode value='it'}
                                    {elseif !$skipLocale && ($localeKey eq 'turkish' || strstr($localeName, 'türk') || strstr($localeName, 'turk'))}
                                        {assign var=flagCode value='tr'}
                                    {elseif !$skipLocale && ($localeKey eq 'russian' || strstr($localeName, 'рус'))}
                                        {assign var=flagCode value='ru'}
                                    {elseif !$skipLocale && $localeKey eq 'portuguese-br'}
                                        {assign var=flagCode value='br'}
                                    {elseif !$skipLocale && $localeKey eq 'portuguese-pt'}
                                        {assign var=flagCode value='pt'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'portugu') || strstr($localeName, 'portugu'))}
                                        {assign var=flagCode value='pt'}
                                    {elseif !$skipLocale && ($localeKey eq 'chinese' || strstr($localeName, '中文') || strstr($localeName, 'chinese'))}
                                        {assign var=flagCode value='cn'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'azer') || strstr($localeName, 'azərbay') || strstr($localeName, 'azeri'))}
                                        {assign var=flagCode value='az'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'catal') || strstr($localeName, 'catal'))}
                                        {assign var=flagCode value='es'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'croat') || strstr($localeName, 'hrvat'))}
                                        {assign var=flagCode value='hr'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'czech') || strstr($localeName, 'češt') || strstr($localeName, 'cest'))}
                                        {assign var=flagCode value='cz'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'dan') || strstr($localeName, 'dansk'))}
                                        {assign var=flagCode value='dk'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'dutch') || strstr($localeName, 'neder'))}
                                        {assign var=flagCode value='nl'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'eston') || strstr($localeName, 'eston'))}
                                        {assign var=flagCode value='ee'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'persian') || strstr($localeName, 'persian') || strstr($localeName, 'فار'))}
                                        {assign var=flagCode value='ir'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'hebrew') || strstr($localeName, 'עבר'))}
                                        {assign var=flagCode value='il'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'hungar') || strstr($localeName, 'magyar'))}
                                        {assign var=flagCode value='hu'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'maced') || strstr($localeName, 'maced'))}
                                        {assign var=flagCode value='mk'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'norweg') || strstr($localeName, 'norweg'))}
                                        {assign var=flagCode value='no'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'roman') || strstr($localeName, 'român') || strstr($localeName, 'roman'))}
                                        {assign var=flagCode value='ro'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'ukrain') || strstr($localeName, 'укра'))}
                                        {assign var=flagCode value='ua'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'slovak') || strstr($localeName, 'sloven'))}
                                        {assign var=flagCode value='sk'}
                                    {elseif !$skipLocale && (strstr($localeKey, 'slovene') || strstr($localeName, 'slovenšč'))}
                                        {assign var=flagCode value='si'}
                                    {/if}

                                    {assign var=targetCurrencyCode value='USD'}
                                    {if $flagCode eq 'fr' || $flagCode eq 'de' || $flagCode eq 'es' || $flagCode eq 'it' || $flagCode eq 'nl' || $flagCode eq 'pt' || $flagCode eq 'ee' || $flagCode eq 'sk' || $flagCode eq 'si' || $flagCode eq 'hr'}
                                        {assign var=targetCurrencyCode value='EUR'}
                                    {elseif $flagCode eq 'dk'}
                                        {assign var=targetCurrencyCode value='DKK'}
                                    {elseif $flagCode eq 'no'}
                                        {assign var=targetCurrencyCode value='NOK'}
                                    {elseif $flagCode eq 'cz'}
                                        {assign var=targetCurrencyCode value='CZK'}
                                    {elseif $flagCode eq 'hu'}
                                        {assign var=targetCurrencyCode value='HUF'}
                                    {elseif $flagCode eq 'ro'}
                                        {assign var=targetCurrencyCode value='RON'}
                                    {elseif $flagCode eq 'mk'}
                                        {assign var=targetCurrencyCode value='MKD'}
                                    {elseif $flagCode eq 'tr'}
                                        {assign var=targetCurrencyCode value='TRY'}
                                    {elseif $flagCode eq 'ru'}
                                        {assign var=targetCurrencyCode value='RUB'}
                                    {elseif $flagCode eq 'ua'}
                                        {assign var=targetCurrencyCode value='UAH'}
                                    {elseif $flagCode eq 'il'}
                                        {assign var=targetCurrencyCode value='ILS'}
                                    {elseif $flagCode eq 'az'}
                                        {assign var=targetCurrencyCode value='AZN'}
                                    {elseif $flagCode eq 'cn'}
                                        {assign var=targetCurrencyCode value='CNY'}
                                    {elseif $flagCode eq 'br'}
                                        {assign var=targetCurrencyCode value='BRL'}
                                    {/if}

                                    {assign var=targetCurrencyId value=''}
                                    {if $currencies}
                                        {foreach $currencies as $selectCurrencyForLocale}
                                            {if $selectCurrencyForLocale.code|upper eq $targetCurrencyCode}
                                                {assign var=targetCurrencyId value=$selectCurrencyForLocale.id}
                                            {/if}
                                        {/foreach}
                                    {/if}

                                    {if !$skipLocale}
                                        <a class="client-locale-option" href="{$localeCurrencyBaseUrl}{$localeCurrencySeparator}language={$locale.language}{if $targetCurrencyId neq ''}&currency={$targetCurrencyId}{/if}">
                                            <img src="https://flagcdn.com/20x15/{$flagCode}.png" alt="{$locale.localisedName} flag" loading="lazy" decoding="async">
                                            <span>{$locale.localisedName}</span>
                                        </a>
                                    {/if}
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    {else}
        <footer class="venom-footer">
            <div class="footer-container">
                <div class="footer-grid">
                    <div class="footer-brand">
                        <a href="{$WEB_ROOT}/index.php" style="display: inline-flex; align-items: center; gap: 10px; text-decoration: none; margin-bottom: 18px;">
                            {include file="$template/includes/logo.tpl" size="32px" textSize="1rem" gap="8px"}
                        </a>
                        <p class="footer-description">
                            Professional service management platform built for providers.
                            Scalable licensing, automation, and real-time monitoring in one powerful panel.
                        </p>
                        <div class="footer-contact">
                            <a href="mailto:support@venom-solutions.com" class="footer-contact-item">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                                support@venom-solutions.com
                            </a>
                            <div class="footer-contact-item">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                                </svg>
                                24/7 Live Chat Support
                            </div>
                        </div>
                    </div>

                    <div class="footer-links">
                        <div class="footer-column">
                            <h4>Quick Access</h4>
                            <ul>
                                <li><a href="{$WEB_ROOT}/index.php">Home</a></li>
                                <li><a href="{$WEB_ROOT}/index.php#pricing">Pricing</a></li>
                                                                <li><a href="{$WEB_ROOT}/register.php">Create Account</a></li>
                                <li><a href="{$WEB_ROOT}/clientarea.php">Client Area</a></li>
                            </ul>
                        </div>
                        <div class="footer-column">
                            <h4>Support</h4>
                            <ul>
                                <li><a href="{$WEB_ROOT}/knowledgebase.php">Knowledgebase</a></li>
                                <li><a href="{$WEB_ROOT}/announcements.php">Announcements</a></li>
                                <li><a href="{$WEB_ROOT}/supporttickets.php">Support Tickets</a></li>
                                <li><a href="{$WEB_ROOT}/submitticket.php">Open Ticket</a></li>
                                <li><a href="{$WEB_ROOT}/contact.php">Contact Us</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="footer-bottom">
                    <p>&copy; {$date_year} Venom Solutions. All rights reserved.</p>
                    <div class="footer-payment-stack">
                        <div class="footer-secure">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#34d399" stroke-width="2">
                                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                                <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                                <line x1="12" y1="22.08" x2="12" y2="12"></line>
                            </svg>
                            <span>Secure Payments</span>
                        </div>

                        <div class="footer-payments" aria-label="Accepted payment methods">
                            <span class="payment-chip" title="Visa" aria-label="Visa">
                                <img src="https://cdn.simpleicons.org/visa/5F8BFF" alt="Visa" class="payment-logo payment-logo-visa" loading="lazy" decoding="async">
                            </span>
                            <span class="payment-chip" title="Mastercard" aria-label="Mastercard">
                                <img src="https://cdn.simpleicons.org/mastercard/FF5C5C" alt="Mastercard" class="payment-logo payment-logo-mastercard" loading="lazy" decoding="async">
                            </span>
                            <span class="payment-chip" title="PayPal" aria-label="PayPal">
                                <img src="https://cdn.simpleicons.org/paypal/00B5FF" alt="PayPal" class="payment-logo payment-logo-paypal" loading="lazy" decoding="async">
                            </span>
                            <span class="payment-chip" title="USDT" aria-label="USDT">
                                <img src="https://cdn.simpleicons.org/tether/37E4B7" alt="USDT" class="payment-logo payment-logo-usdt" loading="lazy" decoding="async">
                            </span>
                            <span class="payment-chip" title="Bitcoin" aria-label="Bitcoin">
                                <img src="https://cdn.simpleicons.org/bitcoin/FFC247" alt="Bitcoin" class="payment-logo payment-logo-btc" loading="lazy" decoding="async">
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    {/if}

    {$footeroutput}
</body>
</html>

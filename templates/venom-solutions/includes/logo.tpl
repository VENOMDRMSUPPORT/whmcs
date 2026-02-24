<div
    class="venom-logo"
    style="--logo-size: {$size|default:'40px'}; --logo-gap: {$gap|default:'12px'}; --logo-text-size: {$textSize|default:'1.2rem'};"
>
    <span class="venom-logo-icon" aria-hidden="true">
        <span class="venom-logo-glow"></span>
        <span class="venom-logo-ring"></span>
        <svg class="venom-logo-svg" viewBox="0 0 24 24" fill="none">
            <path d="M5 3L12 21L19 3" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" />
            <path d="M8 5L12 15L16 5" stroke="hsl(var(--primary))" stroke-width="1.5" stroke-linecap="round" />
        </svg>
    </span>
    {if $showText|default:true}
        <span class="venom-logo-text">
            <span class="venom-logo-name">{$text|default:'Venom'}</span>
            <span class="venom-logo-sub">{$subText|default:'Solutions'}</span>
        </span>
    {/if}
</div>

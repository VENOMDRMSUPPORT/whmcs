<div class="maintenance-page">
    <div class="container">
        <div class="maintenance-card glass-card">
            {include file="$template/includes/logo.tpl" size="54px" textSize="1.6rem" gap="14px"}
            <p class="maintenance-label">SYSTEM MAINTENANCE</p>
            <h1>We Will Be Back Shortly</h1>
            <p>
                We are currently applying infrastructure upgrades to deliver a faster
                and more reliable experience.
            </p>
            <div class="maintenance-meta">
                <div>
                    <span class="meta-title">Estimated Return</span>
                    <span class="meta-value">30 - 60 minutes</span>
                </div>
                <div>
                    <span class="meta-title">Status Updates</span>
                    <span class="meta-value">support@venom-solutions.com</span>
                </div>
            </div>
            <a href="{$WEB_ROOT}/index.php" class="btn-venom-outline">Refresh Homepage</a>
        </div>
    </div>
</div>

<style>
.maintenance-page {
    min-height: 78vh;
    display: grid;
    place-items: center;
    padding: 32px 20px;
}

.maintenance-card {
    max-width: 680px;
    margin: 0 auto;
    border-radius: 22px;
    padding: 48px 34px;
    text-align: center;
}

.maintenance-label {
    margin-top: 22px;
    color: hsl(var(--primary));
    letter-spacing: 2px;
    font-size: 0.78rem;
    font-weight: 800;
}

.maintenance-card h1 {
    margin: 12px 0;
    font-size: clamp(1.8rem, 5vw, 2.5rem);
}

.maintenance-card p {
    color: hsl(var(--muted-foreground));
    max-width: 500px;
    margin: 0 auto;
}

.maintenance-meta {
    margin: 28px 0;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
}

.maintenance-meta div {
    border: 1px solid hsl(var(--border) / 0.7);
    border-radius: 12px;
    padding: 16px 12px;
    background: hsl(var(--card) / 0.35);
}

.meta-title {
    display: block;
    font-size: 0.72rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: hsl(var(--muted-foreground));
}

.meta-value {
    display: block;
    margin-top: 4px;
    font-size: 0.92rem;
    color: hsl(var(--foreground));
    font-weight: 700;
}

@media (max-width: 600px) {
    .maintenance-meta {
        grid-template-columns: 1fr;
    }
}
</style>

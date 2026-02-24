<div class="error-page">
    <div class="container">
        <div class="error-card glass-card">
            {include file="$template/includes/logo.tpl" size="56px" textSize="1.7rem" gap="14px"}
            <p class="error-code">404</p>
            <h1>Page Not Found</h1>
            <p class="error-description">
                The page you requested is not available or may have been moved.
            </p>
            <div class="error-actions">
                <a href="{$WEB_ROOT}/index.php" class="btn-glow">Back to Home</a>
                <a href="{$WEB_ROOT}/clientarea.php" class="btn-venom-outline">Go to Dashboard</a>
            </div>
        </div>
    </div>
</div>

<style>
.error-page {
    min-height: 78vh;
    display: grid;
    place-items: center;
    padding: 32px 20px;
}

.error-card {
    max-width: 620px;
    margin: 0 auto;
    text-align: center;
    border-radius: 22px;
    padding: 48px 34px;
}

.error-code {
    margin-top: 22px;
    font-family: var(--font-mono);
    font-size: 0.9rem;
    letter-spacing: 3px;
    color: hsl(var(--primary));
}

.error-card h1 {
    margin: 10px 0;
    font-size: clamp(1.9rem, 5vw, 2.6rem);
}

.error-description {
    color: hsl(var(--muted-foreground));
    max-width: 440px;
    margin: 0 auto 28px auto;
}

.error-actions {
    display: flex;
    gap: 12px;
    justify-content: center;
    flex-wrap: wrap;
}
</style>

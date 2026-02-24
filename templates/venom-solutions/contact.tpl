{assign var=contactSuccess value=$success|default:$successfulmsg|default:$sent|default:0}

<div class="contact-page">
    <div class="contact-shell">
        <aside class="contact-side">
            <div class="contact-side-content">
                {include file="$template/includes/logo.tpl" size="40px" textSize="1.35rem" gap="12px"}
                <h2>Let's Build Something Great</h2>
                <p>Reach out for sales, technical support, or custom deployment guidance. Our team responds quickly and clearly.</p>

                <ul class="contact-benefits">
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        24/7 support ticket assistance
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Fast pre-sales response for new clients
                    </li>
                    <li>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Clear onboarding and migration guidance
                    </li>
                </ul>

                <div class="contact-methods">
                    <div class="contact-method-item">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                        <span>support@venom-solutions.com</span>
                    </div>
                    <div class="contact-method-item">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                        <span>Live chat available 24/7</span>
                    </div>
                </div>
            </div>
        </aside>

        <div class="contact-form-card glass-card">
            <div class="tech-corner corner-tl"></div>
            <div class="tech-corner corner-tr"></div>
            <div class="tech-corner corner-bl"></div>
            <div class="tech-corner corner-br"></div>

            <div class="contact-floating-badge">
                <span class="contact-floating-badge-dot"></span>
                <span>Contact Us</span>
            </div>

            <div class="contact-form-head">
                <h1>Send a Message</h1>
            </div>

                {if $contactSuccess}
                <div class="alert alert-success">
                    <span>Thank you! Your message has been sent.</span>
                </div>
                {/if}
                {if $errormessage}
                <div class="alert alert-error">
                    <span>{$errormessage}</span>
                </div>
                {/if}
                
                <form method="post" action="{$WEB_ROOT}/contact.php">
                    {if $token}
                        <input type="hidden" name="token" value="{$token}">
                    {/if}
                    <div class="form-group">
                        <label>Name</label>
                        <div class="input-shell">
                            <span class="input-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M20 21a8 8 0 0 0-16 0"></path>
                                    <circle cx="12" cy="8" r="4"></circle>
                                </svg>
                            </span>
                            <input class="input-control" type="text" name="name" value="{$name|default:''}" placeholder="Your name" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <div class="input-shell">
                            <span class="input-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="3" y="5" width="18" height="14" rx="2"></rect>
                                    <path d="M3 7l9 6 9-6"></path>
                                </svg>
                            </span>
                            <input class="input-control" type="email" name="email" value="{$email|default:''}" placeholder="your@email.com" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <div class="input-shell">
                            <span class="input-icon" aria-hidden="true">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M4 7h16"></path>
                                    <path d="M4 12h16"></path>
                                    <path d="M4 17h10"></path>
                                </svg>
                            </span>
                            <input class="input-control" type="text" name="subject" value="{$subject|default:''}" placeholder="How can we help?" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <textarea name="message" rows="5" placeholder="Your message..." required>{$message|default:''}</textarea>
                    </div>
                    <button type="submit" class="btn-glow">Send Message</button>
                </form>
        </div>
    </div>
</div>

<style>
.contact-page {
    min-height: calc(100vh - 220px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 48px 20px;
}

.contact-shell {
    width: 100%;
    max-width: 1240px;
    display: grid;
    grid-template-columns: minmax(320px, 460px) minmax(560px, 1fr);
    gap: 64px;
    align-items: stretch;
}

.contact-side {
    display: flex;
    align-items: center;
    padding: 20px 6px;
}

.contact-side-content {
    display: grid;
    gap: 18px;
    max-width: 360px;
}

.contact-side h2 {
    margin: 0;
    font-size: clamp(1.9rem, 3vw, 2.45rem);
    line-height: 1.08;
    letter-spacing: -0.8px;
}

.contact-side p {
    margin: 0;
    color: hsl(var(--muted-foreground));
    line-height: 1.8;
    font-size: 0.95rem;
}

.contact-benefits {
    list-style: none;
    margin: 8px 0 0;
    padding: 0;
    display: grid;
    gap: 10px;
}

.contact-benefits li {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 0.9rem;
    color: hsl(var(--foreground) / 0.95);
    line-height: 1.5;
}

.contact-benefits svg,
.contact-method-item svg {
    color: hsl(var(--primary));
    flex-shrink: 0;
    margin-top: 2px;
    filter: drop-shadow(0 0 6px hsl(var(--primary) / 0.35));
}

.contact-methods {
    margin-top: 8px;
    padding-top: 16px;
    border-top: 1px solid hsl(var(--border) / 0.5);
    display: grid;
    gap: 10px;
}

.contact-method-item {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    color: hsl(var(--muted-foreground));
    font-size: 0.9rem;
}

.contact-form-card {
    width: 100%;
    border-radius: 24px;
    padding: 72px 34px 36px;
    overflow: visible;
}

.contact-floating-badge {
    position: absolute;
    top: 0;
    left: 34px;
    transform: translateY(-50%);
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 15px;
    border-radius: 999px;
    border: 1px solid hsl(var(--primary) / 0.45);
    background: linear-gradient(135deg, hsl(var(--card) / 0.96) 0%, hsl(var(--primary) / 0.2) 100%);
    color: hsl(var(--foreground));
    font-size: 1rem;
    font-weight: 800;
    letter-spacing: -0.2px;
    box-shadow: 0 8px 22px hsl(var(--background) / 0.55), 0 0 16px hsl(var(--primary) / 0.25);
    z-index: 4;
}

.contact-form-card::before {
    content: "";
    position: absolute;
    top: -1px;
    left: 34px;
    width: 140px;
    height: 3px;
    background: hsl(var(--background));
    z-index: 3;
    pointer-events: none;
}

.contact-floating-badge-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: hsl(var(--primary));
    box-shadow: 0 0 10px hsl(var(--primary));
}

.contact-form-head {
    margin-bottom: 20px;
}

.contact-form-head h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 900;
    letter-spacing: -0.8px;
}

.form-group {
    margin-bottom: 16px;
}

.input-shell {
    display: grid;
    grid-template-columns: 46px 1fr;
    align-items: stretch;
    border: 1px solid hsl(var(--primary) / 0.24);
    border-radius: 12px;
    background: hsl(var(--card) / 0.56);
    overflow: hidden;
    transition: border-color 0.25s ease, box-shadow 0.25s ease;
}

.input-shell:focus-within {
    border-color: hsl(var(--primary) / 0.62);
    box-shadow: 0 0 0 3px hsl(var(--primary) / 0.12);
}

.input-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: hsl(var(--primary) / 0.14);
    color: hsl(var(--primary));
    border-right: 1px solid hsl(var(--primary) / 0.24);
}

.input-shell .input-control {
    width: 100%;
    border: none;
    border-radius: 0;
    background: hsl(var(--input) / 0.5);
    color: hsl(var(--foreground));
    font-size: 0.95rem;
    padding: 13px 16px;
    outline: none;
    box-shadow: none;
}

.input-shell .input-control::placeholder {
    color: hsl(var(--muted-foreground));
    opacity: 0.65;
}

.input-shell .input-control:focus {
    border: none;
    box-shadow: none;
}

.input-shell .input-control:-webkit-autofill,
.input-shell .input-control:-webkit-autofill:hover,
.input-shell .input-control:-webkit-autofill:focus {
    -webkit-text-fill-color: hsl(var(--foreground));
    -webkit-box-shadow: 0 0 0 1000px hsl(var(--input) / 0.5) inset;
    box-shadow: 0 0 0 1000px hsl(var(--input) / 0.5) inset;
    caret-color: hsl(var(--foreground));
    border: none;
    border-radius: 0;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
}

.form-group input,
.form-group textarea {
    width: 100%;
}

.contact-form-card .btn-glow {
    width: 100%;
    padding: 14px 16px;
    font-size: 1rem;
}

.alert {
    padding: 14px 16px;
    border-radius: 10px;
    margin-bottom: 24px;
}

.alert-success {
    background: rgba(34, 197, 94, 0.1);
    border: 1px solid rgba(34, 197, 94, 0.3);
    color: #4ade80;
}

.alert-error {
    background: rgba(239, 68, 68, 0.1);
    border: 1px solid rgba(239, 68, 68, 0.3);
    color: #f87171;
}

@media (max-width: 980px) {
    .contact-shell {
        grid-template-columns: 1fr;
        max-width: 680px;
        gap: 20px;
    }

    .contact-side {
        padding: 24px 22px;
    }
}

@media (max-width: 620px) {
    .contact-form-card {
        padding: 56px 22px 30px;
    }

    .contact-floating-badge {
        left: 22px;
        font-size: 0.9rem;
        padding: 9px 12px;
    }

    .contact-form-card::before {
        left: 22px;
        width: 124px;
    }

    .contact-side {
        display: none;
    }
}
</style>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VenomDRM — Server License Plans</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg:        #0d0f14;
      --surface:   #161b27;
      --border:    #2a3142;
      --accent:    #6c63ff;
      --accent2:   #00d4aa;
      --text:      #e4e6f0;
      --muted:     #7a849a;
      --danger:    #f05252;
      --radius:    12px;
      --max:       1100px;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
      line-height: 1.6;
    }

    a { color: var(--accent); text-decoration: none; }
    a:hover { text-decoration: underline; }

    /* ── NAV ── */
    nav {
      border-bottom: 1px solid var(--border);
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      background: var(--bg);
      z-index: 100;
    }
    .logo { font-size: 1.25rem; font-weight: 700; color: var(--accent); letter-spacing: .5px; }
    .nav-links { display: flex; gap: 1.5rem; font-size: .9rem; color: var(--muted); }
    .nav-links a { color: var(--muted); }
    .nav-links a:hover { color: var(--text); text-decoration: none; }

    /* ── HERO ── */
    .hero {
      max-width: var(--max);
      margin: 0 auto;
      padding: 6rem 2rem 4rem;
      text-align: center;
    }
    .badge {
      display: inline-block;
      background: rgba(108,99,255,.15);
      color: var(--accent);
      border: 1px solid rgba(108,99,255,.35);
      border-radius: 999px;
      font-size: .8rem;
      padding: .25rem .9rem;
      margin-bottom: 1.25rem;
      letter-spacing: .4px;
    }
    .hero h1 {
      font-size: clamp(2rem, 5vw, 3.5rem);
      font-weight: 800;
      line-height: 1.15;
      margin-bottom: 1.25rem;
    }
    .hero h1 span { color: var(--accent); }
    .hero p {
      max-width: 600px;
      margin: 0 auto 2.5rem;
      color: var(--muted);
      font-size: 1.1rem;
    }
    .hero-ctas { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }

    /* ── BUTTONS ── */
    .btn {
      display: inline-block;
      padding: .8rem 2rem;
      border-radius: var(--radius);
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: filter .2s, transform .1s;
      border: none;
    }
    .btn:hover { filter: brightness(1.12); transform: translateY(-1px); text-decoration: none; }
    .btn-primary  { background: var(--accent);  color: #fff; }
    .btn-outline  { background: transparent; color: var(--accent); border: 2px solid var(--accent); }
    .btn-demo     { background: var(--accent2); color: #0d1a16; }

    /* ── SECTION WRAPPER ── */
    section { max-width: var(--max); margin: 0 auto; padding: 4rem 2rem; }
    .section-label {
      text-align: center;
      font-size: .8rem;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      color: var(--accent);
      margin-bottom: .75rem;
    }
    .section-title {
      text-align: center;
      font-size: clamp(1.5rem, 3vw, 2.2rem);
      font-weight: 700;
      margin-bottom: .5rem;
    }
    .section-sub {
      text-align: center;
      color: var(--muted);
      margin-bottom: 3rem;
    }

    /* ── PRICING CARDS ── */
    .pricing-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1.5rem;
    }
    .card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 2rem;
      position: relative;
      transition: border-color .2s;
    }
    .card:hover { border-color: var(--accent); }
    .card.featured {
      border-color: var(--accent);
      box-shadow: 0 0 0 1px var(--accent), 0 8px 32px rgba(108,99,255,.2);
    }
    .card-badge {
      position: absolute;
      top: -1px; right: 1.5rem;
      background: var(--accent);
      color: #fff;
      font-size: .75rem;
      font-weight: 700;
      padding: .25rem .75rem;
      border-radius: 0 0 var(--radius) var(--radius);
      letter-spacing: .5px;
    }
    .card-badge.demo-badge { background: var(--accent2); color: #0d1a16; }
    .card h3 { font-size: 1.35rem; font-weight: 700; margin-bottom: .4rem; }
    .card .tagline { color: var(--muted); font-size: .9rem; margin-bottom: 1.5rem; }
    .price { font-size: 2.5rem; font-weight: 800; margin-bottom: .25rem; }
    .price sup { font-size: 1.25rem; vertical-align: super; }
    .price span { font-size: 1rem; font-weight: 400; color: var(--muted); }
    .price-note { font-size: .85rem; color: var(--muted); margin-bottom: 1.75rem; }
    .feature-list { list-style: none; margin-bottom: 2rem; }
    .feature-list li {
      padding: .45rem 0;
      border-bottom: 1px solid var(--border);
      font-size: .95rem;
      display: flex;
      align-items: center;
      gap: .6rem;
    }
    .feature-list li:last-child { border-bottom: none; }
    .feature-list li::before { content: '✓'; color: var(--accent2); font-weight: 700; flex-shrink: 0; }
    .feature-list li.warn::before { content: '⏱'; color: #f5a623; }

    /* Pricing cycles note */
    .cycle-table {
      width: 100%;
      border-collapse: collapse;
      font-size: .88rem;
      margin-top: 1rem;
      color: var(--muted);
    }
    .cycle-table td { padding: .4rem .6rem; border-bottom: 1px solid var(--border); }
    .cycle-table td:last-child { text-align: right; color: var(--text); }
    .cycle-table tr:last-child td { border-bottom: none; }
    .cycle-table .savings { color: var(--accent2); font-size: .78rem; }

    /* ── FAQ ── */
    .faq-list { display: flex; flex-direction: column; gap: .75rem; }
    details {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 1.15rem 1.5rem;
      cursor: pointer;
    }
    details[open] { border-color: var(--accent); }
    summary {
      font-weight: 600;
      list-style: none;
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 1rem;
    }
    summary::-webkit-details-marker { display: none; }
    summary::after { content: '+'; color: var(--accent); font-size: 1.25rem; flex-shrink: 0; }
    details[open] summary::after { content: '−'; }
    details p { margin-top: .85rem; color: var(--muted); font-size: .95rem; }

    /* ── CONTACT ── */
    .contact-box {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 2.5rem;
      text-align: center;
      max-width: 600px;
      margin: 0 auto;
    }
    .contact-box h3 { font-size: 1.5rem; margin-bottom: .75rem; }
    .contact-box p { color: var(--muted); margin-bottom: 1.75rem; }
    .contact-links { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }

    /* ── FOOTER ── */
    footer {
      border-top: 1px solid var(--border);
      padding: 2rem;
      text-align: center;
      color: var(--muted);
      font-size: .85rem;
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 600px) {
      nav { flex-direction: column; gap: .75rem; }
      .nav-links { gap: 1rem; }
      .hero { padding: 4rem 1.25rem 2.5rem; }
    }
  </style>
</head>
<body>

<!-- NAV -->
<nav>
  <div class="logo">⚡ VenomDRM</div>
  <div class="nav-links">
    <a href="#pricing">Pricing</a>
    <a href="#faq">FAQ</a>
    <a href="#contact">Contact</a>
    <a href="/clientarea.php">Client Area</a>
  </div>
</nav>

<!-- HERO -->
<div class="hero">
  <div class="badge">Software Only · No Content Included</div>
  <h1>Your <span>Server License</span>,<br>Ready in Minutes</h1>
  <p>
    Deploy a Main Server License with a built-in Load Balancer.
    Start with a 7-day demo or go straight to the full plan.
  </p>
  <div class="hero-ctas">
    <a href="/cart.php?a=add&pid=3" class="btn btn-demo">Start 7-Day Demo — $50</a>
    <a href="/cart.php?a=add&pid=1" class="btn btn-primary">Buy Main License — $100/mo</a>
  </div>
</div>

<!-- PRICING -->
<section id="pricing">
  <p class="section-label">Plans</p>
  <h2 class="section-title">Simple, Transparent Pricing</h2>
  <p class="section-sub">No hidden fees. No setup charges. Cancel any time.</p>

  <div class="pricing-grid">

    <!-- DEMO CARD -->
    <div class="card">
      <div class="card-badge demo-badge">TRIAL</div>
      <h3>7-Day Demo License</h3>
      <p class="tagline">Full-featured trial, no commitment</p>
      <div class="price"><sup>$</sup>50<span> one-time</span></div>
      <p class="price-note">Access expires automatically after 7 days</p>
      <ul class="feature-list">
        <li>1x Main Server (demo)</li>
        <li>1x Load Balancer (demo)</li>
        <li class="warn">Valid for 7 days only</li>
        <li>One-time payment, no renewal</li>
        <li>Upgrade to Main License any time</li>
      </ul>
      <a href="/cart.php?a=add&pid=3" class="btn btn-demo" style="width:100%;text-align:center;">
        Start Demo
      </a>
    </div>

    <!-- MAIN LICENSE CARD -->
    <div class="card featured">
      <div class="card-badge">MOST POPULAR</div>
      <h3>Main Server License</h3>
      <p class="tagline">Full production-grade server license</p>
      <div class="price"><sup>$</sup>100<span> / month</span></div>
      <p class="price-note">Save up to 15% with annual billing</p>
      <ul class="feature-list">
        <li>1x Main Server</li>
        <li>1x Load Balancer — free, included</li>
        <li>Additional Load Balancers: $10/mo each</li>
        <li>Recurring subscription, cancel any time</li>
        <li>Multi-cycle billing options</li>
      </ul>

      <!-- Billing cycle table -->
      <table class="cycle-table">
        <tr><td>Monthly</td><td>$100.00</td></tr>
        <tr><td>Quarterly</td><td>$285.00 <span class="savings">save 5%</span></td></tr>
        <tr><td>Semi-Annually</td><td>$540.00 <span class="savings">save 10%</span></td></tr>
        <tr><td>Annually</td><td>$1,020.00 <span class="savings">save 15%</span></td></tr>
      </table>

      <br>
      <a href="/cart.php?a=add&pid=1" class="btn btn-primary" style="width:100%;text-align:center;">
        Buy Main License
      </a>
    </div>

  </div>
</section>

<!-- FAQ -->
<section id="faq">
  <p class="section-label">FAQ</p>
  <h2 class="section-title">Frequently Asked Questions</h2>
  <p class="section-sub">Everything you need to know before purchasing</p>

  <div class="faq-list">

    <details>
      <summary>What is included in the Main Server License?</summary>
      <p>
        The Main Server License includes access to 1x Main Server and 1x Load Balancer at no extra cost.
        If you need additional Load Balancers, you can add them during checkout or later from your client
        area at $10.00 per Load Balancer per month.
      </p>
    </details>

    <details>
      <summary>What happens after my 7-Day Demo expires?</summary>
      <p>
        Your demo service will be automatically suspended after 7 days.
        You can upgrade to the full Main Server License at any time from your client area
        — your data remains available for a short grace period before permanent removal.
      </p>
    </details>

    <details>
      <summary>Can I upgrade from the Demo to the Main License?</summary>
      <p>
        Yes. Once inside your client area, navigate to the Demo License service and click
        <strong>Upgrade/Downgrade</strong>. You will be directed to order the Main Server License.
        The $50 demo fee is not credited toward the Main License purchase.
      </p>
    </details>

    <details>
      <summary>Is there a setup fee?</summary>
      <p>
        No. There are zero setup fees on all plans — Demo, Monthly, Quarterly, Semi-Annually, and Annually.
        You only pay the advertised price.
      </p>
    </details>

    <details>
      <summary>What does "Software Only / No Content" mean?</summary>
      <p>
        This license covers the server software infrastructure only.
        No user content, media, or data is provided or managed as part of this license.
        You are responsible for deploying and managing your own content on the licensed server.
      </p>
    </details>

  </div>
</section>

<!-- CONTACT -->
<section id="contact">
  <div class="contact-box">
    <h3>Need Help?</h3>
    <p>
      Our support team is available to assist with pre-sales questions,
      billing, and technical issues.
    </p>
    <div class="contact-links">
      <a href="/submitticket.php" class="btn btn-primary">Open Support Ticket</a>
      <a href="/clientarea.php" class="btn btn-outline">Client Area</a>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <p>&copy; <?php echo date('Y'); ?> VenomDRM &mdash; Software only. No content included.</p>
  <p style="margin-top:.4rem;">
    <a href="/cart.php?a=add&pid=1">Buy Main License</a> &nbsp;·&nbsp;
    <a href="/cart.php?a=add&pid=3">Start Demo</a> &nbsp;·&nbsp;
    <a href="/clientarea.php">Client Login</a>
  </p>
</footer>

</body>
</html>

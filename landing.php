<?php
/**
 * VENOM Solutions — Landing Page
 *
 * This is the public-facing marketing/landing page for the root URL.
 * All WHMCS routing is handled by the original encrypted index.php.
 *
 * Session detection is used to show appropriate nav button for returning users.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$loggedIn = !empty($_SESSION['uid']) && (int) $_SESSION['uid'] > 0;
$authHref = '/clientarea.php';
$authLabel = $loggedIn ? 'Client Area' : 'Sign In';
$authClass = $loggedIn ? 'btn btn-primary nav-btn' : 'btn btn-outline nav-btn';
?>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Venom DRM — Streaming Infrastructure Licensing</title>
  <meta name="description" content="Software-only licensing portal for streaming infrastructure management. No media content included." />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
  <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
  <link rel="stylesheet" href="/assets/venom-landing.css?v=1" />
</head>
<body class="landing theme-dark">
  <script>
    if (/\?(static|screenshot)=1/.test(location.search)) document.body.classList.add('screenshot-mode');
  </script>
  <div class="landing-bg">
    <div class="mobile-menu-overlay" id="mobileMenuOverlay" aria-hidden="true"></div>
    <header class="nav-header">
      <div class="nav-container">
        <nav class="glass-card nav-content">
          <a href="/" class="nav-logo">
            <div class="animated-logo" style="width: 40px; height: 40px;">
              <div class="animated-logo-glow"></div>
              <div class="animated-logo-ring-outer"></div>
              <div class="animated-logo-ring-inner"></div>
              <div class="animated-logo-ring-decorative"></div>
              <div class="animated-logo-inner">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M5 3L12 21L19 3" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  <path d="M8 5L12 15L16 5" stroke="hsl(180, 100%, 55%)" stroke-width="1.5" stroke-linecap="round"/>
                </svg>
              </div>
            </div>
            <span class="nav-logo-text">Venom DRM</span>
          </a>
          <div class="nav-links">
            <a href="#features" class="nav-link">Features</a>
            <a href="#pricing" class="nav-link">Pricing</a>
            <a href="#how-it-works" class="nav-link">How It Works</a>
          </div>
          <div class="nav-actions">
            <a href="<?php echo htmlspecialchars($authHref); ?>" class="<?php echo htmlspecialchars($authClass); ?>"><?php echo htmlspecialchars($authLabel); ?></a>
          </div>
          <button type="button" class="mobile-menu-btn" id="mobileMenuBtn" aria-label="Toggle menu">
            <i data-lucide="menu" width="20" height="20"></i>
          </button>
        </nav>
        <div class="glass-card mobile-menu" id="mobileMenu">
          <div class="mobile-menu-links">
            <a href="#features" class="mobile-menu-link">
              <i data-lucide="home" width="16" height="16"></i>
              Features
            </a>
            <a href="#pricing" class="mobile-menu-link">
              <i data-lucide="tag" width="16" height="16"></i>
              Pricing
            </a>
            <a href="#how-it-works" class="mobile-menu-link">
              <i data-lucide="route" width="16" height="16"></i>
              How It Works
            </a>
          </div>
          <div class="mobile-menu-divider"></div>
          <div class="mobile-menu-actions">
            <a href="<?php echo htmlspecialchars($authHref); ?>" class="<?php echo htmlspecialchars($authClass); ?>" style="width: 100%; justify-content: center; gap: 0.5rem;">
              <i data-lucide="<?php echo $loggedIn ? 'layout-dashboard' : 'log-in'; ?>" width="16" height="16"></i>
              <?php echo htmlspecialchars($authLabel); ?>
            </a>
          </div>
        </div>
      </div>
    </header>
    <section class="hero-section">
      <div class="hero-container">
        <h1 class="hero-title fade-in delay-100">
          The Ultimate<br>
          <span class="gradient-text">Streaming Control Panel</span>
        </h1>
        <p class="hero-subtitle fade-in delay-200">
          License your streaming infrastructure software in minutes. After purchase, receive your
          <strong>portal URL</strong>, <strong>license key</strong>, and <strong>login credentials</strong> to start managing your servers.
        </p>
        <div class="hero-ctas fade-in delay-300">
          <a href="/cart.php?a=add&pid=1" class="btn btn-primary btn-lg hero-cta-primary">
            Purchase Main License
            <i data-lucide="arrow-right" width="20" height="20"></i>
          </a>
          <a href="/cart.php?a=add&pid=3" class="btn btn-ghost btn-lg hero-cta-secondary">
            <i data-lucide="play" width="20" height="20"></i>
            Start 7‑Day Demo — $50
          </a>
        </div>
        <div class="hero-stats">
          <div class="glass-card hero-stat fade-in delay-400">
            <i data-lucide="file-lock-2" class="hero-stat-icon" width="24" height="24"></i>
            <div class="hero-stat-value">Software</div>
            <div class="hero-stat-label">Only licensing</div>
          </div>
          <div class="glass-card hero-stat fade-in delay-500">
            <i data-lucide="key-round" class="hero-stat-icon" width="24" height="24"></i>
            <div class="hero-stat-value">Access</div>
            <div class="hero-stat-label">Delivered after purchase</div>
          </div>
          <div class="glass-card hero-stat fade-in delay-600">
            <i data-lucide="git-merge" class="hero-stat-icon" width="24" height="24"></i>
            <div class="hero-stat-value">1 LB</div>
            <div class="hero-stat-label">Included in main</div>
          </div>
        </div>
      </div>
    </section>
    <section id="features" class="features-section">
      <div class="features-container">
        <div class="section-header fade-in">
          <span class="section-badge">Enterprise‑Grade Features</span>
          <h2 class="section-title">Built for Reliable Software Licensing</h2>
          <p class="section-subtitle">
            Transparent, secure, and focused on what matters: licensing, access, and infrastructure controls.
          </p>
        </div>
        <div class="features-grid">
          <div class="feature-card glass-card-hover fade-in">
            <div class="feature-icon">
              <i data-lucide="badge-check" width="22" height="22"></i>
            </div>
            <h3 class="feature-title">License & Access Management</h3>
            <p class="feature-desc">
              Deliver portal URL, license key, username, and password per service. Manage lifecycle from one place.
            </p>
          </div>
          <div class="feature-card glass-card-hover fade-in delay-100">
            <div class="feature-icon">
              <i data-lucide="server" width="22" height="22"></i>
            </div>
            <h3 class="feature-title">Multi‑Server Support</h3>
            <p class="feature-desc">
              Organize multiple nodes under one license and keep your infrastructure scalable as you grow.
            </p>
          </div>
          <div class="feature-card glass-card-hover fade-in delay-200">
            <div class="feature-icon">
              <i data-lucide="shuffle" width="22" height="22"></i>
            </div>
            <h3 class="feature-title">Load Balancing</h3>
            <p class="feature-desc">
              1 Load Balancer is included. Add more anytime for $10/month each to distribute traffic and improve uptime.
            </p>
          </div>
          <div class="feature-card glass-card-hover fade-in delay-300">
            <div class="feature-icon">
              <i data-lucide="activity" width="22" height="22"></i>
            </div>
            <h3 class="feature-title">Monitoring & Logs</h3>
            <p class="feature-desc">
              Observe system health and key activity signals to troubleshoot issues faster.
            </p>
          </div>
          <div class="feature-card glass-card-hover fade-in delay-400">
            <div class="feature-icon">
              <i data-lucide="code" width="22" height="22"></i>
            </div>
            <h3 class="feature-title">API‑Ready</h3>
            <p class="feature-desc">
              Integrate with internal tooling or billing automation. Designed to support controlled API workflows.
            </p>
          </div>
          <div class="feature-card glass-card-hover fade-in delay-500">
            <div class="feature-icon">
              <i data-lucide="shield" width="22" height="22"></i>
            </div>
            <h3 class="feature-title">Abuse Controls</h3>
            <p class="feature-desc">
              Strict Acceptable Use enforcement to keep the service professional and reduce platform risk.
            </p>
          </div>
        </div>
      </div>
    </section>
    <section id="pricing" class="pricing-section">
      <div class="pricing-container">
        <div class="section-header fade-in">
          <span class="section-badge">Choose Your Plan</span>
          <h2 class="section-title">Simple, Transparent Pricing</h2>
          <p class="section-subtitle">
            Start with a paid demo or go straight to the main license. No setup fees.
          </p>
        </div>
        <div class="pricing-grid">
          <div class="pricing-card glass-card-hover fade-in">
            <h3 class="pricing-name">7‑Day Demo</h3>
            <p class="pricing-desc">Try the portal with full access credentials.</p>
            <div class="pricing-price">
              <span class="pricing-currency">$</span>50
              <span class="pricing-period">one‑time</span>
            </div>
            <ul class="pricing-features">
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Valid for 7 days</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Portal URL + credentials delivered after purchase</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Upgrade anytime</span>
              </li>
            </ul>
            <a href="/cart.php?a=add&pid=3" class="btn btn-outline pricing-btn">Start Demo</a>
          </div>
          <div class="pricing-card glass-card-hover popular gradient-border fade-in delay-100">
            <div class="pricing-badge">
              <i data-lucide="sparkles" width="14" height="14"></i>
              Recommended
            </div>
            <h3 class="pricing-name">Main License</h3>
            <p class="pricing-desc">For production infrastructure and scaling.</p>
            <div class="pricing-price">
              <span class="pricing-currency">$</span>100
              <span class="pricing-period">/month</span>
            </div>
            <ul class="pricing-features">
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Includes 1 Load Balancer</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Additional Load Balancers: $10/month each</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Monthly / Quarterly / Semi‑Annual / Annual billing</span>
              </li>
            </ul>
            <a href="/cart.php?a=add&pid=1" class="btn btn-primary pricing-btn">Purchase Main License</a>
          </div>
          <div class="pricing-card glass-card-hover fade-in delay-200">
            <h3 class="pricing-name">Enterprise</h3>
            <p class="pricing-desc">Custom solutions for large-scale deployments.</p>
            <div class="pricing-price">
              <span class="pricing-currency">Custom</span>
              <span class="pricing-period">Tailored pricing</span>
            </div>
            <ul class="pricing-features">
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Unlimited Load Balancers</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Dedicated infrastructure support</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Custom API integrations</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">Priority 24/7 support</span>
              </li>
              <li class="pricing-feature">
                <i data-lucide="check" class="pricing-feature-icon" width="20" height="20"></i>
                <span class="pricing-feature-text">SLA guarantees</span>
              </li>
            </ul>
            <a href="/contact.php" class="btn btn-outline pricing-btn">Contact Us</a>
          </div>
        </div>
        <div class="pricing-note fade-in delay-200">
          <span class="pricing-note-icon" aria-hidden="true">
            <i data-lucide="info" width="16" height="16"></i>
          </span>
          <span class="pricing-note-text">
            Need more Load Balancers? Add them during checkout under
            <strong class="pricing-note-highlight">Additional Load Balancers</strong>.
          </span>
        </div>
      </div>
    </section>
    <section class="licensing-section" id="how-it-works">
      <div class="licensing-container">
        <div class="section-header fade-in">
          <span class="section-badge">How It Works</span>
          <h2 class="section-title">Get Started in Minutes</h2>
          <p class="section-subtitle">
            A simple flow inspired by leading licensing providers: purchase → receive access → manage.
          </p>
        </div>
        <div class="licensing-grid">
          <div class="licensing-step glass-card-hover fade-in">
            <div class="licensing-step-icon">
              <i data-lucide="shopping-cart" width="20" height="20"></i>
              <span class="licensing-step-number">1</span>
            </div>
            <h3 class="licensing-step-title">Purchase a License</h3>
            <p class="licensing-step-desc">
              Choose the Demo or Main License and complete checkout inside the client area.
            </p>
          </div>
          <div class="licensing-step glass-card-hover fade-in delay-100">
            <div class="licensing-step-icon">
              <i data-lucide="mail" width="20" height="20"></i>
              <span class="licensing-step-number">2</span>
            </div>
            <h3 class="licensing-step-title">Receive Access Details</h3>
            <p class="licensing-step-desc">
              You receive your portal URL, license key, and login credentials after purchase.
            </p>
          </div>
          <div class="licensing-step glass-card-hover fade-in delay-200">
            <div class="licensing-step-icon">
              <i data-lucide="log-in" width="20" height="20"></i>
              <span class="licensing-step-number">3</span>
            </div>
            <h3 class="licensing-step-title">Log In to the Portal</h3>
            <p class="licensing-step-desc">
              Access the cloud portal to manage your license and infrastructure settings.
            </p>
          </div>
          <div class="licensing-step glass-card-hover fade-in delay-300">
            <div class="licensing-step-icon">
              <i data-lucide="shuffle" width="20" height="20"></i>
              <span class="licensing-step-number">4</span>
            </div>
            <h3 class="licensing-step-title">Scale with Load Balancing</h3>
            <p class="licensing-step-desc">
              Use the included Load Balancer, or add more to distribute traffic and improve availability.
            </p>
          </div>
        </div>
        <div class="licensing-cta fade-in delay-400">
          <a href="/cart.php?a=add&pid=3" class="btn btn-outline btn-lg">Start 7‑Day Demo</a>
          <a href="/cart.php?a=add&pid=1" class="btn btn-primary btn-lg">Purchase Main License</a>
        </div>
      </div>
    </section>
    <footer class="footer">
      <div class="footer-container">
        <div class="footer-grid">
          <div class="footer-brand">
            <a href="/" class="footer-logo">
              <div class="btn-glow footer-logo-icon" style="width: 36px; height: 36px;">
                <span style="font-weight: 700; font-size: 1.25rem;">V</span>
              </div>
              <span class="footer-logo-text">Venom DRM</span>
            </a>
            <p class="footer-desc">
              Software-only licensing portal for streaming infrastructure management.
              <strong>No media content included.</strong>
            </p>
          </div>

          <div class="footer-links-grid">
            <div>
              <h4 class="footer-links-title">Product</h4>
              <ul class="footer-links">
                <li><a href="#features" class="footer-link">Features</a></li>
                <li><a href="#pricing" class="footer-link">Pricing</a></li>
                <li><a href="#how-it-works" class="footer-link">How It Works</a></li>
                <li><a href="/contact.php" class="footer-link">Contact</a></li>
              </ul>
            </div>

            <div>
              <h4 class="footer-links-title">Legal</h4>
              <ul class="footer-links">
                <li><a href="/terms-of-service.php" class="footer-link">Terms of Service</a></li>
                <li><a href="/privacy-policy.php" class="footer-link">Privacy Policy</a></li>
                <li><a href="/refund-policy.php" class="footer-link">Refund Policy</a></li>
                <li><a href="/acceptable-use.php" class="footer-link">Acceptable Use</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="footer-bottom">
          <span>© 2026 VENOM Solutions. All rights reserved.</span>
          <span class="footer-badge">Software Only · No Content Included</span>
        </div>
      </div>
    </footer>
  </div>
  <script>
    // Initialize Lucide icons (guarded so nav JS still works if icon CDN fails)
    if (window.lucide && typeof window.lucide.createIcons === 'function') {
      window.lucide.createIcons();
    }
    // Mobile menu toggle is in venom-landing.js
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });
    // Add scroll effect to navigation
    const navHeader = document.querySelector('.nav-header');
    window.addEventListener('scroll', () => {
      if (window.scrollY > 50) {
        navHeader.style.background = 'hsl(222 47% 8% / 0.8)';
        navHeader.style.backdropFilter = 'blur(12px)';
      } else {
        navHeader.style.background = 'transparent';
        navHeader.style.backdropFilter = 'none';
      }
    });
    // Intersection Observer for fade-in animations
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.style.animationPlayState = 'running';
        }
      });
    }, observerOptions);
    document.querySelectorAll('.fade-in').forEach(el => {
      el.style.animationPlayState = 'paused';
      observer.observe(el);
    });
    // Trigger initial animations for elements in viewport
    setTimeout(() => {
      document.querySelectorAll('.fade-in').forEach(el => {
        const rect = el.getBoundingClientRect();
        if (rect.top < window.innerHeight) {
          el.style.animationPlayState = 'running';
        }
      });
    }, 100);
  </script>
  <script src="/assets/venom-landing.js?v=1" defer></script>
</body>
</html>

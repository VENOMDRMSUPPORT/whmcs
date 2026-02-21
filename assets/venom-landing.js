document.addEventListener('DOMContentLoaded', () => {
// Initialize Lucide icons
    if (window.lucide) { window.lucide.createIcons(); }

    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');

    const setMenuOpen = (open) => {
      if (mobileMenu) mobileMenu.classList.toggle('open', open);
      document.body.classList.toggle('menu-open', open);
      if (mobileMenuOverlay) mobileMenuOverlay.setAttribute('aria-hidden', !open);
    };

    if (mobileMenuBtn && mobileMenu) {
      mobileMenuBtn.addEventListener('click', () => {
        const isOpen = mobileMenu.classList.toggle('open');
        document.body.classList.toggle('menu-open', isOpen);
        if (mobileMenuOverlay) mobileMenuOverlay.setAttribute('aria-hidden', !isOpen);
      });

      if (mobileMenuOverlay) {
        mobileMenuOverlay.addEventListener('click', () => setMenuOpen(false));
      }

      // Close menu when clicking a link
      mobileMenu.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => setMenuOpen(false));
      });
    }

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
});

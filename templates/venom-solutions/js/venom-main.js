(function () {
    "use strict";

    function setMenuState(toggle, nav, isOpen) {
        nav.classList.toggle("active", isOpen);
        toggle.classList.toggle("active", isOpen);
        toggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
        document.body.classList.toggle("mobile-menu-open", isOpen);
    }

    function syncMobileHeaderOffset() {
        var header = document.querySelector(".venom-header");
        if (!header) {
            return;
        }

        var offset = Math.round(header.getBoundingClientRect().height);
        document.documentElement.style.setProperty("--venom-mobile-header-offset", offset + "px");
    }

    function initMobileMenu() {
        var menuToggle = document.querySelector(".mobile-menu-toggle:not(.client-area-menu-toggle)");
        var headerNav = document.querySelector(".venom-header:not(.venom-header-client) .header-nav");

        if (!menuToggle || !headerNav) {
            return;
        }

        syncMobileHeaderOffset();

        menuToggle.addEventListener("click", function () {
            var isOpen = !headerNav.classList.contains("active");
            setMenuState(menuToggle, headerNav, isOpen);
        });

        document.addEventListener("click", function (event) {
            if (!menuToggle.contains(event.target) && !headerNav.contains(event.target)) {
                setMenuState(menuToggle, headerNav, false);
            }
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                setMenuState(menuToggle, headerNav, false);
            }
        });

        headerNav.addEventListener("click", function (event) {
            var navLink = event.target.closest("a");
            if (!navLink) {
                return;
            }

            setMenuState(menuToggle, headerNav, false);
        });

        window.addEventListener("resize", function () {
            syncMobileHeaderOffset();
            if (window.innerWidth > 767 && headerNav.classList.contains("active")) {
                setMenuState(menuToggle, headerNav, false);
            }
        });
    }

    function initClientAreaMobileMenu() {
        var menuToggle = document.querySelector(".client-area-menu-toggle");
        var headerNav = document.querySelector(".venom-header-client .header-nav");

        if (!menuToggle || !headerNav) {
            return;
        }

        syncMobileHeaderOffset();

        menuToggle.addEventListener("click", function () {
            var isOpen = !headerNav.classList.contains("active");
            headerNav.classList.toggle("active", isOpen);
            menuToggle.classList.toggle("active", isOpen);
            menuToggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
            document.body.classList.toggle("mobile-menu-open", isOpen);
        });

        document.addEventListener("click", function (event) {
            if (!menuToggle.contains(event.target) && !headerNav.contains(event.target)) {
                headerNav.classList.remove("active");
                menuToggle.classList.remove("active");
                menuToggle.setAttribute("aria-expanded", "false");
                document.body.classList.remove("mobile-menu-open");
            }
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                headerNav.classList.remove("active");
                menuToggle.classList.remove("active");
                menuToggle.setAttribute("aria-expanded", "false");
                document.body.classList.remove("mobile-menu-open");
            }
        });

        headerNav.addEventListener("click", function (event) {
            var navLink = event.target.closest("a");
            if (!navLink) {
                return;
            }
            headerNav.classList.remove("active");
            menuToggle.classList.remove("active");
            menuToggle.setAttribute("aria-expanded", "false");
            document.body.classList.remove("mobile-menu-open");
        });

        window.addEventListener("resize", function () {
            syncMobileHeaderOffset();
            if (window.innerWidth > 767 && headerNav.classList.contains("active")) {
                headerNav.classList.remove("active");
                menuToggle.classList.remove("active");
                menuToggle.setAttribute("aria-expanded", "false");
                document.body.classList.remove("mobile-menu-open");
            }
        });
    }

    function initSmoothScroll() {
        var anchors = document.querySelectorAll('a[href^="#"]');

        anchors.forEach(function (anchor) {
            anchor.addEventListener("click", function (event) {
                var href = anchor.getAttribute("href");
                if (!href || href === "#") {
                    return;
                }

                var target = document.querySelector(href);
                if (!target) {
                    return;
                }

                event.preventDefault();
                target.scrollIntoView({ behavior: "smooth", block: "start" });
            });
        });
    }

    function initCopyButtons() {
        var copyButtons = document.querySelectorAll("[data-copy]");
        if (!copyButtons.length || !navigator.clipboard) {
            return;
        }

        copyButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                var value = button.getAttribute("data-copy");
                if (!value) {
                    return;
                }

                navigator.clipboard.writeText(value).then(function () {
                    button.classList.add("copied");
                    setTimeout(function () {
                        button.classList.remove("copied");
                    }, 900);
                }).catch(function () {
                    button.classList.remove("copied");
                });
            });
        });
    }

    function initBackToTop() {
        var triggers = document.querySelectorAll(".js-back-to-top");
        if (!triggers.length) {
            return;
        }

        triggers.forEach(function (trigger) {
            trigger.addEventListener("click", function () {
                window.scrollTo({ top: 0, behavior: "smooth" });
            });
        });
    }

    function initClientMenuDropdown() {
        var dropdowns = document.querySelectorAll(".client-menu-dropdown, .client-account-dropdown, .client-notifications-dropdown, .client-main-nav-dropdown");
        if (!dropdowns.length) {
            return;
        }

        dropdowns.forEach(function (clientMenu) {
            var menuTrigger = clientMenu.querySelector("summary");

            document.addEventListener("click", function (event) {
                if (!clientMenu.open) {
                    return;
                }

                if (!clientMenu.contains(event.target)) {
                    clientMenu.removeAttribute("open");
                }
            });

            document.addEventListener("keydown", function (event) {
                if (event.key !== "Escape" || !clientMenu.open) {
                    return;
                }

                clientMenu.removeAttribute("open");
                if (menuTrigger) {
                    menuTrigger.focus();
                }
            });
        });
    }

    function initFooterLocaleModal() {
        var modal = document.getElementById("footer-locale-modal");
        var openButtons = document.querySelectorAll("[data-modal-open='footer-locale-modal']");

        if (!modal || !openButtons.length) {
            return;
        }

        function closeModal() {
            modal.hidden = true;
            document.body.classList.remove("locale-modal-open");
        }

        function openModal() {
            modal.hidden = false;
            document.body.classList.add("locale-modal-open");
        }

        openButtons.forEach(function (button) {
            button.addEventListener("click", openModal);
        });

        modal.addEventListener("click", function (event) {
            if (event.target.closest("[data-modal-close='footer-locale-modal']")) {
                closeModal();
            }
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape" && !modal.hidden) {
                closeModal();
            }
        });
    }

    function initThemeSystem() {
        if (!document.body.classList.contains("client-area")) {
            return;
        }

        var themeToggle = document.querySelector(".js-theme-toggle");
        var accentButtons = document.querySelectorAll("[data-accent]");

        if (themeToggle) {
            themeToggle.addEventListener("click", function () {
                var currentTheme = localStorage.getItem("venom-theme") || "dark";
                var newTheme = currentTheme === "dark" ? "light" : "dark";

                localStorage.setItem("venom-theme", newTheme);
                document.body.classList.remove("theme-dark", "theme-light");
                document.body.classList.add("theme-" + newTheme);
            });
        }

        accentButtons.forEach(function (btn) {
            btn.addEventListener("click", function () {
                var accent = btn.getAttribute("data-accent");
                localStorage.setItem("venom-accent", accent);

                // Remove all possible accent classes
                document.body.classList.remove("accent-purple", "accent-blue", "accent-orange", "accent-green");

                if (accent !== "cyan") {
                    document.body.classList.add("accent-" + accent);
                }

                // Update active state in UI
                accentButtons.forEach(function (b) { b.classList.remove("is-active"); });
                btn.classList.add("is-active");
            });
        });
    }

    // Apply theme immediately to prevent flicker
    (function applyInitialTheme() {
        if (typeof localStorage === 'undefined') return;

        // We can't check body class yet if this runs too early, 
        // but we can check if we are in client area by looking at URL or 
        // just trust that the CSS is scoped anyway.
        // However, the best is to run this as soon as body exists.
        var theme = localStorage.getItem("venom-theme") || "dark";
        var accent = localStorage.getItem("venom-accent") || "cyan";

        document.documentElement.classList.add("theme-" + theme);
        if (accent !== "cyan") {
            document.documentElement.classList.add("accent-" + accent);
        }

        // Also apply to body once it's available
        document.addEventListener("DOMContentLoaded", function () {
            if (!document.body.classList.contains("client-area")) return;

            document.body.classList.remove("theme-dark", "theme-light");
            document.body.classList.add("theme-" + theme);

            if (accent !== "cyan") {
                document.body.classList.add("accent-" + accent);
            }

            // Mark active accent in UI
            var activeBtn = document.querySelector('[data-accent="' + accent + '"]');
            if (activeBtn) activeBtn.classList.add("is-active");
        });
    })();

    document.addEventListener("DOMContentLoaded", function () {
        initMobileMenu();
        initClientAreaMobileMenu();
        initSmoothScroll();
        initCopyButtons();
        initClientMenuDropdown();
        initBackToTop();
        initFooterLocaleModal();
        initThemeSystem();
    });
})();

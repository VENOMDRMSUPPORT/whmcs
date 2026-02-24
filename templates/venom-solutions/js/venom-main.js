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
        var menuToggle = document.querySelector(".mobile-menu-toggle");
        var headerNav = document.querySelector(".header-nav");

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
            if (window.innerWidth > 768 && headerNav.classList.contains("active")) {
                setMenuState(menuToggle, headerNav, false);
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

    document.addEventListener("DOMContentLoaded", function () {
        initMobileMenu();
        initSmoothScroll();
        initCopyButtons();
    });
})();

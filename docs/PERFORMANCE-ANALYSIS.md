# Template Performance Analysis

## Summary

Based on Chrome DevTools timing for `clientarea.php` (~33.5 seconds total), the bottlenecks are:

| Phase | Duration | % of Total |
|-------|----------|------------|
| Initial Connection | 7.56s | 22.5% |
| Waiting (TTFB) | 4.05s | 12.1% |
| Content Download | 20.00s | 59.6% |

---

## 1. Root Causes

### A. Server-Side (Waiting: 4.05s)

- **PHP execution**: WHMCS bootstrap, Smarty rendering, hooks
- **Database queries**: Client stats, services, tickets, announcements
- **Hooks**: `venom_disable_hosting_domains_servers.php` runs on every ClientAreaPage

**Evidence needed**: Add `?XDEBUG_PROFILE=1` or enable WHMCS debug log to measure query time.

### B. Network (Initial Connection: 7.56s)

- Cold PHP-FPM / web server
- Slow DNS
- Firewall / proxy latency
- Server overload

**Evidence needed**: Test from same network vs remote; compare first load vs cached.

### C. Frontend (Content Download: 20.00s)

- **Large HTML**: Inline CSS in templates (e.g. `clientareahome.tpl` ~300 lines of `<style>`)
- **Many CSS files** (10+ per page):
  - `open-sans-family.css`
  - `bootstrap.min.css` (CDN)
  - `all.min.css` (60KB)
  - `fontawesome.min.css` (200KB)
  - `fontawesome-solid.min.css`
  - `fontawesome-regular.min.css`
  - `fontawesome-light.min.css`
  - `fontawesome-brands.min.css`
  - `fontawesome-duotone.min.css`
  - `venom-main.css` (72KB)

- **Font Awesome usage in venom-solutions**: Mostly `fas` (solid) and `far` (regular). `fal` (light) and `fad` (duotone) used in few places.

---

## 2. Recommended Fixes (Priority Order)

### High Impact

1. **Reduce Font Awesome loading** (venom-solutions `head.tpl`)
   - Load only `fontawesome-solid` + `fontawesome-regular` for client area
   - Drop `fontawesome-light`, `fontawesome-brands`, `fontawesome-duotone` if not needed on most pages
   - Or: replace FA icons with inline SVGs (header already does this)

2. **Enable gzip/Brotli compression** (server config)
   - Nginx: `gzip on; gzip_types text/css application/javascript;`
   - Apache: `mod_deflate`

3. **Move inline CSS to external file** (`clientareahome.tpl`, etc.)
   - Extract `<style>` blocks to `venom-main.css` or page-specific CSS
   - Enables caching and reduces HTML size

### Medium Impact

4. **Server-side profiling**
   - Enable WHMCS debug / slow query log
   - Optimize heavy DB queries
   - Consider OPcache for PHP

5. **CDN for static assets**
   - Serve `venom-main.css`, `scripts.min.js`, Font Awesome from CDN with long cache headers

6. **Lazy-load non-critical CSS**
   - Load Font Awesome or secondary CSS with `media="print" onload="this.media='all'"` for below-fold content

### Lower Impact

7. **Reduce `all.min.css` scope**
   - WHMCS bundles intl-tel-input, DataTables, etc. Load only on pages that need them.

8. **Preconnect to CDN**
   - Add `<link rel="preconnect" href="https://cdn.jsdelivr.net">` for Bootstrap CDN

---

## 3. Quick Wins (Template-Only)

All changes in `templates/venom-solutions/`:

- [ ] Trim Font Awesome in `includes/head.tpl` (keep solid + regular only)
- [ ] Extract inline styles from `clientareahome.tpl` to `css/venom-main.css`
- [ ] Add `rel="preconnect"` for Bootstrap CDN

---

## 4. Verification

After changes:

1. Clear browser cache, disable cache in DevTools
2. Reload `clientarea.php`
3. Compare: Initial Connection, Waiting (TTFB), Content Download
4. Check total CSS size in Network tab (transfer size)

<todos title="Todos" rule="Review steps frequently throughout the conversation and DO NOT stop between steps unless they explicitly require it.">
- No current todos
</todos>

<!-- Auto-generated todo section -->
<!-- Add your custom Copilot instructions below -->

## LANGUAGE POLICY — STRICTLY ENFORCED

**All project files must be written in English only.**

This applies without exception to:
- All source code files (PHP, JS, CSS, SQL, etc.)
- Code comments and inline documentation
- Commit messages
- Changelog and documentation files (`.docs/`, `README`, etc.)
- Variable names, function names, class names
- Database values that are developer-facing (config keys, log messages, etc.)
- Any file added to this repository

**Arabic or any other non-English language is strictly forbidden** inside
project files. When generating, editing, or reviewing any file in this
workspace, always use English only. If existing content contains Arabic text,
translate it to English before proceeding.

Violation of this rule means the contribution must be rejected or rewritten.

## DOMAIN SPECIALIZATION

Prioritize professional implementation standards for:

- WHMCS template customization (`templates/`, order forms, client area views)
- WHMCS hooks and module-safe logic (`includes/hooks/`, module extensions)
- Frontend theme systems with multi-color palettes and semantic design tokens
- Responsive UI quality, accessibility (contrast/focus), and upgrade-safe changes

When implementing theme changes:

- Prefer CSS variable tokens over hard-coded colors
- Keep component styles consistent across all accent palettes
- Preserve existing project structure and avoid unnecessary framework changes

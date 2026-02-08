---
name: rams
description: Run accessibility and visual design review
---

# Rams Design Review

## Agent Delegation
You MUST delegate the exploratory testing of user journeys and the validation of accessibility compliance to the `qa-engineer` sub-agent.

## MANDATES

- **SMART BRANCHING** — Before creating a branch, check the current environment.
    *   **Trunk Check**: ONLY create a new branch if the current branch is a "trunk" branch (e.g., `main`, `master`).
    *   **Existing Branch**: If already on a non-trunk branch (e.g., a feature branch or a branch with an open PR), continue working on the current branch.
    *   **Lineage Check**: If on a trunk branch and a new branch is needed, check the ticket's lineage:
        *   If this is a sub-task (child of a Story/Feature), check if a branch for the **Parent Ticket** already exists. If so, switch to it. If not, create the branch using the **Parent Ticket's ID**.
        *   If this is a Feature/Story (child of Epic) or Standalone, create/use a branch for **This Ticket**.
    *   **Naming Convention**: `design-fix/<anchor-ticket-id>-<short-desc>`

## Mode

If `$ARGUMENTS` is provided, analyze that specific file.
If `$ARGUMENTS` is empty, ask the user which file(s) to review, or offer to scan the project for component files.

---

## 1. Accessibility Review (WCAG 2.1)

### Critical (Must Fix)

| Check                       | WCAG  | What to look for                                                                 |
| --------------------------- | ----- | -------------------------------------------------------------------------------- |
| Images without alt          | 1.1.1 | `<img>` without `alt` attribute                                                  |
| Icon-only buttons           | 4.1.2 | `<button>` with only SVG/icon, no `aria-label`                                   |
| Form inputs without labels  | 1.3.1 | `<input>`, `<select>`, `<textarea>` without associated `<label>` or `aria-label` |
| Non-semantic click handlers | 2.1.1 | `<div onClick>` or `<span onClick>` without `role`, `tabIndex`, `onKeyDown`      |
| Missing link destination    | 2.1.1 | `<a>` without `href` using only `onClick`                                        |

### Serious (Should Fix)

| Check                     | WCAG  | What to look for                                                    |
| ------------------------- | ----- | ------------------------------------------------------------------- |
| Focus outline removed     | 2.4.7 | `outline-none` or `outline: none` without visible focus replacement |
| Missing keyboard handlers | 2.1.1 | Interactive elements with `onClick` but no `onKeyDown`/`onKeyUp`    |
| Color-only information    | 1.4.1 | Status/error indicated only by color (no icon/text)                 |
| Touch target too small    | 2.5.5 | Clickable elements smaller than 44x44px                             |

### Moderate (Consider Fixing)

| Check                            | WCAG  | What to look for                            |
| -------------------------------- | ----- | ------------------------------------------- |
| Heading hierarchy                | 1.3.1 | Skipped heading levels (h1 → h3)            |
| Positive tabIndex                | 2.4.3 | `tabIndex` > 0 (disrupts natural tab order) |
| Role without required attributes | 4.1.2 | `role="button"` without `tabIndex="0"`      |

---

## 2. Visual Design Review

### Layout & Spacing

- Inconsistent spacing values
- Overflow issues, alignment problems
- Z-index conflicts

### Typography

- Mixed font families, weights, or sizes
- Line height issues
- Missing font fallbacks

### Color & Contrast

- Contrast ratio below 4.5:1
- Missing hover/focus states
- Dark mode inconsistencies

### Components

- Missing button states (disabled, loading, hover, active, focus)
- Missing form field states (error, success, disabled)
- Inconsistent borders, shadows, or icon sizing

---

## Output Format

```
═══════════════════════════════════════════════════
RAMS DESIGN REVIEW: [filename]
═══════════════════════════════════════════════════

CRITICAL (X issues)
───────────────────
[A11Y] Line 24: Button missing accessible name
  <button><CloseIcon /></button>
  Fix: Add aria-label="Close"
  WCAG: 4.1.2

SERIOUS (X issues)
──────────────────
...

═══════════════════════════════════════════════════
SUMMARY: X critical, X serious, X moderate
Score: XX/100
═══════════════════════════════════════════════════
```

---

## Guidelines

1. Read the file(s) first before making assessments
2. Be specific with line numbers and code snippets
3. Provide fixes, not just problems
4. Prioritize critical accessibility issues first

If asked, offer to fix the issues directly.

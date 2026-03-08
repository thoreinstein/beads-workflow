---
name: plan-review
description: Review and update an existing implementation plan stored in Obsidian. Takes an issue ID as argument (e.g. /plan-review <issue-id>). Updates the Obsidian note in-place. NEVER creates local plan files.
---

## Review/Update Implementation Plan

**Argument:** Issue ID (e.g. `<issue-id>`)

**Target note:** `working/<project-name>/plans/<issue-id>-plan.md` (in Obsidian)

**Path Logic:**
1. **Project Name**: Use the `BEADS_PROJECT_NAME` env var or the current directory name.
2. **Note Path**: `working/<project-name>/plans/<issue-id>-plan.md`

### HARD CONSTRAINTS — VIOLATIONS ARE NEVER ACCEPTABLE

<EXTREMELY_IMPORTANT>

**DO NOT use `write_file` or `replace` tools on ANY `.md` file.** Not in `docs/`, not anywhere. Zero local markdown writes.

**The ONLY write action permitted is `obsidian_create_note`** to update the plan note at the target path above. If you find yourself reaching for any other write tool, STOP — you are off track.

</EXTREMELY_IMPORTANT>

### Permissions

- **READ any codebase file** for analysis context (glob, search_file_content, read_file, run_shell_command for non-destructive commands).
- **READ the Obsidian plan** using `obsidian_read_note`.
- **WRITE ONLY via `obsidian_create_note`** to update the plan note at the target path.
- **NO local file writes** of any kind. No `docs/`, no temporary files.
- **NO beads updates** (no `bd update`, `bd close`, etc.).
- **NO build/test/lint commands.**

### Workflow

1. **Find the plan note** using `obsidian_search_notes` with the issue ID. The expected path is `working/<project-name>/plans/<issue-id>-plan.md`.
2. **Read the existing plan** using `obsidian_read_note`. This skill assumes a plan already exists (created via `/analyze`). If the note does not exist, inform the user and stop.
3. **Gather context** by reading relevant codebase files (handlers, templates, configs, tests — whatever the plan needs). Use glob/search_file_content/read_file freely.
4. **Review the plan** against the codebase. Look for:
   - Stale references (files moved, renamed, or deleted since the plan was written)
   - Missing implementation details (vague steps that need file paths and line numbers)
   - Incorrect assumptions about existing code structure
   - Missing risks or dependencies
   - Phases that could be reordered or parallelized
5. **Update the plan note in Obsidian** using `obsidian_create_note` at the same path (this overwrites the existing note). Preserve the existing structure; refine, don't rewrite. You MUST call `obsidian_create_note` before finishing — a review without an update is incomplete.
6. **Confirm** what you changed and stop. Do not proceed to implementation.

### Completion Checklist

Before you finish, verify:
- [ ] You called `obsidian_read_note` to read the plan
- [ ] You called `obsidian_create_note` to write the updated plan back
- [ ] You did NOT use `write_file` or `replace` on any markdown file

### Plan Format Reference

```markdown
# Implementation Plan: <issue-id> - <title>

## Executive Summary

<1-2 paragraphs: what, why, scope boundaries>

## Tickets in Scope

| ID  | Title | Status | Dependencies | Parallelizable |
| --- | ----- | ------ | ------------ | -------------- |

## Implementation Phases

### Phase N: <name>

**Tickets:** <ids>

- **Work:** <bullet list of specific steps with file paths and line numbers>
- **Files:** <list of files to modify>
- **Verification:** <how to confirm this phase works>

## Risk Assessment

- **Risk:** <what could go wrong>
  - **Mitigation:** <how to prevent/handle it>

## Out of Scope

- <items explicitly excluded>
```

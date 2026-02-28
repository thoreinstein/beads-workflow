---
name: plan-review
description: Review and update an existing implementation plan in the second brain. Takes an issue ID as argument (e.g. /plan-review <issue-id>). Read-only access to codebase; the ONLY file you may create or edit is the plan file.
---

## Review/Update Implementation Plan

**Argument:** Issue ID (e.g. `<issue-id>`)

**Target file:** `working/<project-name>/plans/<issue-id>-plan.md`

**Path Logic:**
1. **Vault Location**: Use the `OBSIDIAN_VAULT_PATH` environment variable.
2. **Project Name**: Use the `BEADS_PROJECT_NAME` env var or the current directory name.
3. **Full Path**: `${OBSIDIAN_VAULT_PATH}/working/<project-name>/plans/<issue-id>-plan.md`

### Permissions — READ THIS FIRST

- **You may READ any file in the codebase** for analysis context.
- **You may NOT edit, create, or delete ANY file in the codebase.**
- **You may NOT update beads issues** (no `bd update`, `bd close`, etc.).
- **You may NOT run build, test, lint, or any other code-affecting commands.**
- **The ONLY file you are authorized to write is the plan file above.** No exceptions.

### Workflow

1. **Determine the plan file path** from the issue ID argument and the environment variables above.
2. **Read the existing plan.** This skill assumes a plan already exists (created via `/analyze`). If the file does not exist, inform the user and stop.
3. **Gather context** by reading relevant codebase files (handlers, templates, configs, tests — whatever the plan needs). Use Glob/Grep/Read freely.
4. **Review the plan** against the codebase. Look for:
   - Stale references (files moved, renamed, or deleted since the plan was written)
   - Missing implementation details (vague steps that need file paths and line numbers)
   - Incorrect assumptions about existing code structure
   - Missing risks or dependencies
   - Phases that could be reordered or parallelized
5. **Update the plan file** with your findings. Preserve the existing structure; refine, don't rewrite.
6. **Confirm** what you changed and stop. Do not proceed to implementation.

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

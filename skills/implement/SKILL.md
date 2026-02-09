---
name: implement
description: Full implementation mode - end-to-end feature implementation with phased execution, parallel work streams, verification gates, and atomic commits per phase
---

# Implement

## Agent Delegation
You MUST delegate complex architectural decisions and security-critical code implementations to the `principal-engineer` sub-agent. For system-wide dependency mapping and comprehensive feature implementation, utilize the `codebase_investigator`. For unit test creation and test strategy, delegate to the `sdet` sub-agent.

## HARD CONSTRAINTS (NON-NEGOTIABLE)

- **SCOPE IS LOCKED** — Only implement what is in the plan from `/analyze`. Nothing more.
- **NO SCOPE CREEP** — Do not implement work from other tickets, even if it seems related or helpful.
- **TICKET TRACKING IS MANDATORY** — Update ticket status (in-progress/done) as you work.
- **EPIC CLOSURE RULES** — Never close an epic while child tickets remain open.
- **SMART BRANCHING** — Before creating a branch, check the current environment.
    *   **Trunk Check**: ONLY create a new branch if the current branch is a "trunk" branch (e.g., `main`, `master`).
    *   **Existing Branch**: If already on a non-trunk branch (e.g., a feature branch or a branch with an open PR), continue working on the current branch.
    *   **Lineage Check**: If on a trunk branch and a new branch is needed, check the ticket's lineage:
        *   If this is a sub-task (child of a Story/Feature), check if a branch for the **Parent Ticket** already exists. If so, switch to it. If not, create the branch using the **Parent Ticket's ID**.
        *   If this is a Feature/Story (child of Epic) or Standalone, create/use a branch for **This Ticket**.
    *   **Naming Convention**: `feat/<anchor-ticket-id>-<short-desc>` or `fix/...`
- **MERGE BEFORE CLOSE** — A ticket status can only be changed to 'done' AFTER the Pull Request containing its changes has been successfully merged into the trunk branch. This ensures that any review feedback is addressed while the ticket is still 'in-progress'.
- **VERIFY BEFORE COMMIT** — No code shall be committed until all verification steps (tests, lint, build, etc.) have passed successfully. If any check fails, you MUST resolve the issues and re-verify before attempting to commit.
- **NO --NO-VERIFY** — Never, under any circumstances, use the `--no-verify` flag with git commit. Pre-commit hooks must always run and pass. If they fail, fix the code. No exceptions, even if explicitly requested.

### Scope Creep Self-Check

Before writing ANY code, ask:
1. Is this in the implementation plan? → NO = don't implement
2. Is this ticket in scope for this phase? → NO = don't implement
3. Am I adding something "nice to have"? → YES = note as follow-up, don't implement

If you discover related work, add it to "Discovered Follow-Up Items" and continue with scoped work.

## When to Use

- Building new features end-to-end
- Complex multi-component implementations
- Features requiring coordination across backend, frontend, and infrastructure
- Any implementation benefiting from structured phases and checkpoints

## Ticket Status Management (Beads Projects)

```bash
# Starting work on a ticket
bd update <ticket-id> --status in-progress

# Completing a ticket (ONLY AFTER PR MERGE)
bd update <ticket-id> --status done

# Verify epic children before closing
bd show <epic-id> --json  # All children must be status:done (merged)
```

### Status Update Rules

| Event | Action |
| ----- | ------ |
| Starting implementation | Mark parent ticket in-progress |
| Starting a child ticket in a phase | Mark child in-progress |
| Pull Request Merged | Mark affected tickets done |
| ALL children done → close epic | Mark epic done |

**NEVER close an epic while children are still open.**

## Phase Execution Loop

Every phase follows this exact sequence:

```
┌─────────────────────────────────────────────────────────────┐
│  PHASE EXECUTION LOOP                                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   1. PLAN     → Define work for this phase                  │
│                 Mark phase tickets as in_progress           │
│                                                             │
│   2. WORK     → Execute the phase work                      │
│                 ⚠️  ONLY work in the plan — no extras        │
│                                                             │
│   3. VERIFY   → Run verification checklist                  │
│                 Tests pass, lints clean, build succeeds     │
│                                                             │
│   4. COMMIT   → Create atomic commit for phase              │
│                 Include ticket IDs in commit message        │
│                                                             │
│   5. UPDATE   → Mark tickets done ONLY after merge          │
│                 Keep in_progress while PR is pending        │
│                                                             │
│   6. PROCEED  → Move to next phase                          │
│                                                             │
│   ⚠️  DO NOT PROCEED UNTIL COMMIT SUCCEEDS AND TICKETS      │
│       ARE UPDATED (IF MERGED)                               │
│                                                             │
│   ⚠️  NEVER mark a ticket done until its changes are        │
│       merged into the trunk branch.                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Phase Overview

| Phase | Name | Description |
|-------|------|-------------|
| 1 | Requirements Analysis | Gather context, clarify requirements, set up tracking |
| 2 | Architecture Decision | Evaluate approaches, document decisions (if needed) |
| 3 | Parallel Implementation | Execute implementation across work streams |
| 4 | Integration | Integrate components, resolve conflicts |
| 5 | Verification | Run full verification checklist |
| 6 | Documentation & Cleanup | Update docs, clean up tracking, summarize |

See `references/implement-phases.md` for detailed phase instructions.

## Task Tracking Setup

Define ALL phases upfront before starting implementation:

```
Phase 1: Requirements Analysis
  - [ ] Gather context
  - [ ] Clarify requirements
  - [ ] Commit planning artifacts

Phase 2: Architecture Decision (if needed)
  - [ ] Evaluate approaches
  - [ ] Document decision
  - [ ] Commit architecture docs

Phase 3: Implementation
  - [ ] [Specific implementation tasks from plan]
  - [ ] Write tests
  - [ ] Commit implementation
  - [ ] Update ticket status → in-progress (keep until PR merge)

Phase 4: Integration
  - [ ] Integrate components
  - [ ] Commit integration

Phase 5: Verification
  - [ ] Run verification checklist
  - [ ] Commit fixes

Phase 6: Documentation & Cleanup
  - [ ] Update documentation
  - [ ] Create implementation summary
  - [ ] Document follow-up items
  - [ ] Verify all tickets closed
  - [ ] Final commit
```

## Verification Checklist

```
┌─────────────────────────────────────────────────────────────┐
│  VERIFICATION CHECKLIST                                     │
├─────────────────────────────────────────────────────────────┤
│  [ ] Static analysis clean on all changed files             │
│  [ ] All tests pass (unit, integration, e2e)                │
│  [ ] Linter passes with no warnings                         │
│  [ ] Build succeeds                                         │
│  [ ] Type checking passes (if applicable)                   │
│  [ ] Security review completed (if needed)                  │
│  [ ] Performance acceptable (no regressions)                │
└─────────────────────────────────────────────────────────────┘
```

## Epic Completion Gate

```
┌─────────────────────────────────────────────────────────────┐
│  EPIC COMPLETION GATE                                       │
├─────────────────────────────────────────────────────────────┤
│  [ ] ALL child tickets are status: done (merged)            │
│  [ ] All phases in the plan are complete                    │
│  [ ] All commits are pushed and PRs merged                  │
│  [ ] No uncommitted changes remain                          │
│  [ ] Implementation summary documented                      │
│  [ ] Final commit completed (if needed)                     │
│  [ ] Follow-up items captured                               │
│                                                             │
│  ⚠️  MERGE ALL PRs BEFORE CLOSING EPIC                      │
│  ⚠️  DO NOT CLOSE EPIC IF ANY CHILD IS STILL OPEN           │
└─────────────────────────────────────────────────────────────┘
```

## Prerequisites

1. **GUARD: No Acceptance Criteria → STOP**
   - If the ticket has no AC, inform the user they must refine before implementing.
2. **Load Implementation Plan**: Plans MUST be read from Obsidian using `obsidian_read_note`.
   - **Path Logic**:
     1. **Identify Project Name**: Use the `BEADS_PROJECT_NAME` env var or the current directory name.
     2. **Construct Path**: `working/<project-name>/plans/<ticket-id>-plan.md`
3. **Epic Scope Guard**:
   - Epics with 4+ children require user confirmation to proceed in a single run.

## Phase Execution Sequence

Every phase follows this exact sequence:

```
Branch → Plan → Work → Verify → Commit → Update Tickets → Proceed
```

0. **Branch**: Check for an existing feature branch. If none exists, create one based on the **Smart Branching** rules (Feature/Story level).
1. **Plan**: Define work for this phase and mark tickets as `in-progress`.
2. **Work**: Execute ONLY work defined in the plan.
3. **Verify**: Run tests, lints, and builds. No code shall be committed until all verification steps pass.
4. **Commit**: Create atomic commit for the phase. Git hooks must always run; never use `--no-verify`.
5. **Update Tickets**: Mark completed tickets as `done` ONLY after successful merge. Keep tickets `in-progress` if a PR is pending or review is required.
6. **Proceed**: Move to the next phase only after commit and ticket updates (or merge confirmation).

---

## Constraints

- **Scope is the plan**: Only implement what `/analyze` planned
- **Atomic commits per phase**: Each phase MUST end with a commit
- **No skipping phases**: Follow the sequence even for small features
- **Verification gates**: Do not commit code or proceed to the next phase until all verification checks pass.
- **No --no-verify**: Never bypass git hooks. If hooks fail, the code is not ready to be committed.
- **Track everything**: Update ticket status in real-time, not at the end
- **Clean completion**: No uncommitted changes, all tickets closed
- **No premature closure**: Epic stays open until all children are merged and done
- **Merge is Done**: A ticket is only 'done' when its code is in the trunk branch.

## Implementation Output

At completion, document the implementation:

**Path Logic:**
1. **Identify Project Name**: Use the `BEADS_PROJECT_NAME` env var or the current directory name.
2. **Construct Path**: `working/<project-name>/summaries/<ticket-id>-summary.md`
3. **Save**: Save the summary to this path using `write_file`.

```markdown
## Implementation Summary

### What Was Built
[Brief description of the feature]

### Tickets Completed
| Ticket | Title | Status |
| ------ | ----- | ------ |
| ... | ... | done (merged) |

### Files Changed
- `path/to/file` — [what changed]

### Architecture Decisions
[Key decisions made and rationale]

### Testing
- [Tests added]
- [Coverage notes]

### Verification
- [ ] All diagnostics clean
- [ ] Tests passing
- [ ] Build succeeds
- [ ] PR merged into trunk branch

### Commits Made
- [Commit hash] — [Phase X: description]

### Known Limitations
[Any constraints or future work]

### Discovered Follow-Up Items
| Item | Related Ticket | Why Not In Scope |
| ---- | -------------- | ---------------- |
| ... | ... | Not in plan |

### Next Steps
[Follow-up tasks if any]
```

See `references/templates/implementation-summary.md` for the full template.

## Example

```
Feature: Add user notification preferences (EPIC-123)

Child Tickets: STORY-124, STORY-125, STORY-126

Phase 1: Requirements Analysis
  ✓ Loaded plan from working/<project>/plans/EPIC-123-plan.md
  ✓ Marked EPIC-123 as in-progress
  ✓ Committed: docs/specs/notification-prefs.md

Phase 2: Architecture Decision
  ✓ Decision: separate preferences table
  ✓ Committed: docs/adr/007-notification-preferences.md

Phase 3: Implementation
  STORY-124 (backend):
    ✓ Marked STORY-124 in-progress
    ✓ Created preferences table migration
    ✓ Added PreferencesService
    ✓ Committed: feat(STORY-124): add notification preferences backend
    ✓ PR Created and Merged ✓
    ✓ Marked STORY-124 done

  STORY-125 (frontend):
    ✓ Marked STORY-125 in-progress
    ✓ Added preferences UI component
    ✓ Committed: feat(STORY-125): add notification preferences UI
    ✓ PR Created and Merged ✓
    ✓ Marked STORY-125 done

Phase 4: Integration
  STORY-126:
    ✓ Marked STORY-126 in-progress
    ✓ Connected UI to API
    ✓ Added e2e tests
    ✓ Committed: chore(STORY-126): integrate notification preferences
    ✓ PR Created and Merged ✓
    ✓ Marked STORY-126 done

Phase 5: Verification
  ✓ All tests pass (47/47)
  ✓ Lint clean
  ✓ Build succeeds

Phase 6: Documentation & Cleanup
  ✓ Updated API docs
  ✓ Created implementation summary
  ✓ Verified all children done: STORY-124 ✓, STORY-125 ✓, STORY-126 ✓
  ✓ Committed: docs: notification preferences
  ✓ Marked EPIC-123 done (after final merge)

Implementation complete!
```

Begin by loading the implementation plan and marking the ticket as in-progress.

**Remember: The plan is the scope. Do not exceed it.**

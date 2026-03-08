---
name: fix-ci
description: Diagnose and fix CI failures using GitHub Actions logs. Iterates through diagnose-fix-verify cycles until CI passes (max 3 iterations).
---

# Fix CI

## Agent Delegation

For complex build failures or unfamiliar error patterns, delegate to the
`principal-engineer` sub-agent. For language-specific fixes, delegate to the
appropriate language-pro agent (e.g., `golang-pro` for Go build failures,
`typescript-pro` for TypeScript compilation errors).

## When to Use

- CI pipeline failures on the current branch
- Pre-merge check failures
- Flaky test investigation in CI
- Post-push build/lint/test failures

## Workflow

### Phase 1: Identify Failure

1. Run `gh run list --branch $(git branch --show-current) --limit 5` to find recent runs
2. Identify the failed run ID
3. Run `gh run view <run-id> --log-failed` to fetch failure logs
4. If multiple jobs failed, analyze each separately

### Phase 2: Diagnose

1. Analyze the failure logs — identify exact error messages
2. Categorize: build error, test failure, lint issue, dependency problem, timeout, flaky test
3. Map the failure to specific files and lines in the codebase
4. For flaky tests: check if test passed locally, look for race conditions or timing dependencies

### Phase 3: Fix

1. Apply the minimal fix — only change what is necessary
2. Run local verification: execute the same command that failed in CI
3. If the fix involves dependency changes, verify lock files are updated

### Phase 4: Verify

1. Commit the fix: `fix(ci): <description of what was fixed>`
2. Ask user for permission before pushing
3. After push, monitor with `gh run list --branch $(git branch --show-current) --limit 1 --json status,conclusion,databaseId`
4. If still failing, loop back to Phase 1 (max 3 iterations)
5. After 3 failed iterations, stop and present accumulated findings

## Iteration Tracking

| Iteration | Diagnosis | Fix Applied | Result |
|-----------|-----------|-------------|--------|
| 1 | | | |
| 2 | | | |
| 3 | | | |

## Constraints

- **Max 3 iterations** — if CI still fails after 3 attempts, stop and present findings
- **Minimal fixes only** — fix the CI failure, don't refactor surrounding code
- **Local verification first** — always run the failing command locally before pushing
- **Never skip checks** — no `--no-verify`, no skipping test suites
- **PUSH ONLY with user permission** — ask before pushing fixes to remote
- **No scope creep** — if the failure reveals a deeper issue, report it but don't fix it

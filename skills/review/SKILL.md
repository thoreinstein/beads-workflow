---
name: review
description: Comprehensive multi-agent code review with parallel specialist analysis, confidence filtering, and structured verdicts. Produces APPROVE, NEEDS WORK, or BLOCK.
---

# Code Review Mode (Deep Review)

## Agent Delegation

This skill spawns multiple specialist agents in parallel for thorough review.

### Language-Specific Reviewers (spawned based on detected languages)

| Language   | Agent               | Focus                                     |
| ---------- | ------------------- | ----------------------------------------- |
| Python     | python-reviewer     | Type safety, security, idiomatic patterns |
| Go         | golang-reviewer     | Error handling, concurrency, interfaces   |
| Bash       | bash-reviewer       | Quoting, POSIX compliance, security       |
| Nix        | nix-reviewer        | Reproducibility, flake hygiene, modules   |
| Lua        | lua-reviewer        | Neovim quality, metatables, performance   |
| Rust       | rust-reviewer       | Ownership, unsafe audit, error handling   |
| TypeScript | typescript-reviewer | Type safety, async correctness, security  |

### Always-On Reviewers (spawned for every review)

| Agent             | Focus                                    |
| ----------------- | ---------------------------------------- |
| security-engineer | OWASP Top 10, vulnerability analysis     |
| perf-reviewer     | Algorithmic complexity, resource leaks   |

## When to Use

- When reviewing pull requests or merge requests
- Before merging feature branches into main/trunk
- When asked to review specific files or changes
- For post-implementation quality checks

## Workflow

### Phase 1: Context Gathering

1. **Identify scope**: Determine files/commits to review via `git diff`
2. **Understand the change**: Review commit messages and PR description
3. **Detect languages**: Identify which languages are present in the diff
4. **Map dependencies**: Check what depends on changed files

### Phase 2: Parallel Specialist Review

1. **Detect languages** in the diff (file extensions, shebang lines)
2. **Spawn language-specific reviewer agents in parallel** for each detected language
3. **Always spawn**: `security-engineer` + `perf-reviewer`
4. Each agent produces structured findings with:
   - File path and line range
   - Severity (Critical/High/Medium/Low)
   - Confidence score (0-100)
   - Description of the issue
   - Concrete fix suggestion

### Phase 3: Synthesis

1. **Collect** all agent findings
2. **Deduplicate**: Merge findings referencing the same code location
3. **Filter**: Only include findings with confidence >= 80
4. **Sort** by severity (Critical > High > Medium > Low)
5. **Determine verdict**:
   - **APPROVE** — No critical/high issues, code is ready to merge
   - **NEEDS WORK** — Has issues that must be addressed before merge
   - **BLOCK** — Critical issues, security vulnerabilities, or fundamental design problems

### Phase 4: Output

Produce structured review and save to Obsidian.

**Path Logic:**
1. **Identify Project Name**: Use `BEADS_PROJECT_NAME` env var or current directory name
2. **Identify Review Target**: PR number (e.g., `PR-123`) or branch name
3. **Construct Path**: `working/<project-name>/reviews/<review-target>-review.md`

## Review Dimensions

### Correctness

- [ ] Logic is correct and handles all expected cases
- [ ] Edge cases are handled (null, empty, boundary values)
- [ ] Error states are handled appropriately
- [ ] Types are correct and conversions are safe

### Security

- [ ] No injection vulnerabilities (SQL, command, XSS)
- [ ] Input is validated and sanitized
- [ ] No secrets, credentials, or keys in code
- [ ] Authentication/authorization checks are correct

### Performance

- [ ] No unnecessary loops or redundant operations
- [ ] Algorithms are appropriate for the data size
- [ ] No N+1 queries or unbounded fetches
- [ ] Caching is used appropriately

### Reliability

- [ ] Errors are caught and handled gracefully
- [ ] Failures don't leave system in bad state
- [ ] Resources are properly cleaned up
- [ ] Timeouts are set for external calls

### Maintainability

- [ ] Code is readable and self-documenting
- [ ] Functions have single responsibility
- [ ] Naming is clear and consistent
- [ ] Follows project conventions and patterns

### Testing

- [ ] Tests exist for new/changed behavior
- [ ] Edge cases and error paths are tested
- [ ] Tests are deterministic
- [ ] Test names clearly describe what they verify

## Escalation Criteria

Flag for additional human review when:

| Concern          | Escalation Trigger                                              |
| ---------------- | --------------------------------------------------------------- |
| **Security**     | Any auth changes, crypto usage, user data handling              |
| **Reliability**  | Changes to error handling, retry logic, failure recovery        |
| **Performance**  | Changes to hot paths, database queries, algorithms at scale     |
| **Architecture** | New patterns, significant structural changes                    |
| **Testing**      | Reduced coverage, disabled tests, test infrastructure changes   |

## Constraints

- **Review only what's in scope** — don't expand to unrelated code
- **Be specific** — reference exact file:line for all findings
- **Provide fixes, not just criticisms** — every issue has a suggested resolution
- **Calibrate severity** — not everything is critical
- **Acknowledge good work** — positive feedback matters too
- **Confidence filtering** — only surface findings with >= 80 confidence
- **OBSIDIAN ARTIFACTS**: Save review to Obsidian using `obsidian_create_note`

---
name: code-review
description: Comprehensive code review with security, performance, and maintainability focus. Produces structured review with APPROVE, NEEDS WORK, or BLOCK verdict.
license: MIT
compatibility:
  - runtime:any
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(git:diff)
  - Bash(git:log)
  - Bash(git:show)
  - Bash(git:blame)
metadata:
  author: thoreinstein
  version: 1.0.0
---

# Code Review Mode

Perform a comprehensive code review with structured analysis across multiple dimensions.

## When to Use This Skill

- When reviewing pull requests or merge requests
- Before merging feature branches into main/trunk
- When asked to review specific files or changes
- During pair programming review sessions
- For post-implementation quality checks

## Workflow

### Phase 1: Context Gathering

1. **Identify the scope:**
   - Determine which files/commits to review (diff, specific files, or branch comparison)
   - Get the diff: `git diff` for the relevant range

2. **Understand the change:**
   - Review commit messages and PR description (if available)
   - Check git history for related recent changes
   - Identify the purpose and expected behavior of the change

3. **Map dependencies:**
   - Identify what other code depends on the changed files
   - Check for related test files
   - Note any configuration or schema changes

### Phase 2: Multi-Dimensional Review

Evaluate the code against each dimension in the Review Dimensions section below. For each dimension:

1. Walk through the relevant checklist
2. Note any issues with severity (Critical/High/Medium/Low)
3. Record the specific location (file:line)
4. Document suggested fixes

### Phase 3: Synthesis

Produce a structured review following the template in `references/code-review-template.md`.

1. **Determine verdict:**
   - **APPROVE** - No critical/high issues, code is ready to merge
   - **NEEDS WORK** - Has issues that must be addressed before merge
   - **BLOCK** - Has critical issues, security vulnerabilities, or fundamental design problems

2. **Organize findings** by severity
3. **Acknowledge strengths** - what's done well
4. **Provide actionable fixes** - not just problems, but solutions

## Review Dimensions

### Correctness

- [ ] Logic is correct and handles all expected cases
- [ ] Edge cases are handled (null, empty, boundary values)
- [ ] Assumptions are documented or validated
- [ ] Error states are handled appropriately
- [ ] Types are correct and conversions are safe

### Security

- [ ] No injection vulnerabilities (SQL, command, XSS)
- [ ] Input is validated and sanitized
- [ ] No secrets, credentials, or keys in code
- [ ] Authentication/authorization checks are correct
- [ ] Dependencies are secure and up-to-date

### Performance

- [ ] No unnecessary loops or redundant operations
- [ ] Algorithms are appropriate for the data size
- [ ] Memory usage is reasonable
- [ ] No N+1 queries or unbounded fetches
- [ ] Caching is used appropriately

### Reliability

- [ ] Errors are caught and handled gracefully
- [ ] Failures don't leave system in bad state
- [ ] Retry logic has backoff and limits
- [ ] Resources are properly cleaned up (connections, files, etc.)
- [ ] Timeouts are set for external calls

### Maintainability

- [ ] Code is readable and self-documenting
- [ ] Functions/methods have single responsibility
- [ ] Naming is clear and consistent
- [ ] No unnecessary duplication
- [ ] Follows project conventions and patterns

### Testing

- [ ] Tests exist for new/changed behavior
- [ ] Edge cases and error paths are tested
- [ ] Tests are deterministic (not flaky)
- [ ] Test names clearly describe what they verify
- [ ] Mocks/stubs are appropriate and not excessive

## Escalation Criteria

Flag for additional human review when:

| Concern          | Escalation Trigger                                                               |
| ---------------- | -------------------------------------------------------------------------------- |
| **Security**     | Any auth changes, crypto usage, user data handling, or potential vulnerabilities |
| **Reliability**  | Changes to error handling, retry logic, or failure recovery paths                |
| **Performance**  | Changes to hot paths, database queries, or algorithms with scale concerns        |
| **Architecture** | New patterns, significant structural changes, or cross-cutting concerns          |
| **Testing**      | Reduced coverage, disabled tests, or changes to test infrastructure              |

## Constraints

- **Review only what's in scope** - don't expand to unrelated code unless it's directly affected
- **Be specific** - reference exact file:line locations for all findings
- **Provide fixes, not just criticisms** - every issue should have a suggested resolution
- **Calibrate severity appropriately** - not everything is critical
- **Acknowledge good work** - positive feedback matters too

## Examples

### Example: Reviewing a New API Endpoint

**Scope:** PR adds `POST /api/users` endpoint in `internal/api/users.go`

**Phase 1 output:**
```
Files changed:
- internal/api/users.go (new handler)
- internal/api/routes.go (route registration)
- internal/db/users.go (new repository method)

Related tests: internal/api/users_test.go (new)
Purpose: Add user creation endpoint for onboarding flow
```

**Phase 2 findings:**

| Severity | Issue                                  | Location        | Fix                            |
| -------- | -------------------------------------- | --------------- | ------------------------------ |
| High     | SQL injection via unsanitized email    | db/users.go:45  | Use parameterized query        |
| Medium   | Missing rate limiting                  | api/users.go:23 | Add rate limiter middleware    |
| Low      | Error message exposes internal details | api/users.go:67 | Return generic error to client |

**Phase 3 verdict:**
```
Verdict: NEEDS WORK

Critical/High Issues:
- SQL injection vulnerability must be fixed before merge

What's Done Well:
- Clean separation between handler and repository
- Comprehensive input validation struct
- Good test coverage for happy path

Action Items:
1. [High] Fix SQL injection in db/users.go:45
2. [Medium] Add rate limiting to endpoint
3. [Low] Sanitize error messages returned to client
```

---

Begin by gathering context on the target files/commits before conducting the multi-dimensional review.

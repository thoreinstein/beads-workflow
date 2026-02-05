# Implement Phases - Detailed Instructions

This document provides detailed guidance for each phase of the implementation workflow.

---

## Phase 1: Requirements Analysis

**Goal:** Gather context and define scope before any implementation work.

### Step 1.1: Gather Context

Launch parallel exploration to understand the codebase:

- Find existing patterns relevant to the feature
- Find related code that might be affected
- Research best practices for the approach

### Step 1.2: Clarify Requirements

Answer these questions before proceeding:

- **What exactly needs to be built?** Define the deliverable clearly
- **What are the acceptance criteria?** How will we know it's done?
- **What constraints exist?** Time, compatibility, performance requirements
- **What patterns should be followed?** Existing conventions in the codebase

### Step 1.3: Set Up Task Tracking

Create a task list with ALL phases defined upfront:

```
Phase 1: Requirements Analysis
  - [ ] Gather context
  - [ ] Clarify requirements
  - [ ] Document scope
  - [ ] Commit planning artifacts

Phase 2: Architecture Decision
  - [ ] Evaluate approaches
  - [ ] Document decision
  - [ ] Commit architecture docs

Phase 3: Implementation
  - [ ] [Specific implementation tasks]
  - [ ] Write tests
  - [ ] Commit implementation

Phase 4: Integration
  - [ ] Integrate components
  - [ ] Resolve conflicts
  - [ ] Commit integration

Phase 5: Verification
  - [ ] Run full verification checklist
  - [ ] Fix any issues
  - [ ] Commit fixes

Phase 6: Documentation & Cleanup
  - [ ] Update documentation
  - [ ] Clean up tasks
  - [ ] Final commit
```

### Step 1.4: Commit Planning Artifacts

If any planning documents were created (specs, ADRs, etc.), commit them before proceeding.

---

## Phase 2: Architecture Decision (If Needed)

**Goal:** Make and document significant architectural decisions.

### When This Phase Is Needed

- New feature with multiple possible approaches
- Significant changes to existing architecture
- Performance-critical implementations
- Security-sensitive features
- Cross-cutting concerns affecting multiple modules

### Step 2.1: Evaluate Approaches

For significant features, consider:

- **Scalability**: Will this approach scale with expected growth?
- **Maintainability**: Is the solution easy to understand and modify?
- **Consistency**: Does it follow existing patterns in the codebase?
- **Performance**: Are there performance implications?
- **Security**: Are there security considerations?

### Step 2.2: Document the Decision

Create an Architecture Decision Record (ADR) or similar document:

```markdown
## Decision: [Title]

### Context
[Why this decision is needed]

### Options Considered
1. [Option A] - [pros/cons]
2. [Option B] - [pros/cons]

### Decision
[What was decided and why]

### Consequences
[What this decision means for the codebase]
```

### Step 2.3: Commit Architecture Docs

Commit the architecture decision before proceeding to implementation.

---

## Phase 3: Parallel Implementation

**Goal:** Execute implementation work, parallelizing where possible.

### Identify Work Streams

Group implementation tasks by domain and identify which can run in parallel:

```
┌─────────────────────────────────────────────────────────────┐
│  PARALLEL IMPLEMENTATION STREAMS                            │
├─────────────────────────────────────────────────────────────┤
│  BACKEND                     │  FRONTEND                    │
│  ├─ API/service code         │  └─ UI components            │
│  ├─ Database schema/queries  │      State management        │
│  ├─ Caching layer            │      Styling                 │
│  └─ Business logic           │                              │
├──────────────────────────────┼──────────────────────────────┤
│  INFRASTRUCTURE              │  QUALITY                     │
│  ├─ Kubernetes manifests     │  ├─ Unit tests               │
│  ├─ Terraform/IaC            │  ├─ Integration tests        │
│  ├─ CI/CD pipelines          │  ├─ Security review          │
│  └─ Configuration            │  ├─ Performance testing      │
│                              │  └─ Accessibility            │
└─────────────────────────────────────────────────────────────┘
```

### Delegation Guidelines

Route work to appropriate specialists based on domain:

| Domain | Specialist Focus |
|--------|------------------|
| Go APIs, CLIs | Go idioms, error handling, concurrency |
| Database | Schema design, query optimization, migrations |
| Frontend | Components, state, accessibility, responsiveness |
| Kubernetes | Manifests, Helm, resource limits, probes |
| Terraform | Modules, state management, provider configs |
| CI/CD | Pipelines, caching, security scanning |
| Testing | Test strategy, coverage, mocking patterns |
| Security | OWASP, authentication, authorization |
| Performance | Profiling, benchmarking, optimization |

### Implementation Checklist

For each work stream:

- [ ] Implement the feature code
- [ ] Write unit tests
- [ ] Write integration tests (if applicable)
- [ ] Update or add documentation comments
- [ ] Self-review the changes

### Step 3.4: Commit Implementation

Commit all implementation changes before proceeding to integration.

---

## Phase 4: Integration

**Goal:** Bring together all implementation work and resolve conflicts.

### Step 4.1: Integrate Components

- Wire up frontend to backend APIs
- Connect services to databases
- Configure infrastructure to deploy services
- Ensure all pieces work together

### Step 4.2: Resolve Conflicts

- Address any merge conflicts
- Resolve interface mismatches
- Fix integration test failures
- Ensure consistent behavior across modules

### Step 4.3: Integration Testing

Run integration tests to verify:

- Components communicate correctly
- Data flows end-to-end as expected
- Error handling works across boundaries
- Edge cases are handled properly

### Step 4.4: Commit Integration

Commit integration changes before proceeding to verification.

---

## Phase 5: Verification

**Goal:** Run full verification to ensure quality before completion.

### Verification Checklist

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
│  [ ] Documentation updated                                  │
│  [ ] No TODOs or FIXMEs left unaddressed                    │
└─────────────────────────────────────────────────────────────┘
```

### Running Verification

```bash
# Example verification commands (adjust for your stack)

# Tests
go test ./...
npm test

# Linting
golangci-lint run
npm run lint

# Build
go build ./...
npm run build

# Type checking
npm run type-check
```

### Fix Issues

If verification reveals issues:

1. Fix the issue
2. Re-run affected verification steps
3. Repeat until all checks pass

### Commit Verification Fixes

Commit any fixes made during verification.

---

## Phase 6: Documentation & Cleanup

**Goal:** Finalize documentation and clean up tracking artifacts.

### Step 6.1: Update Documentation

- Update README if needed
- Add/update API documentation
- Document any new configuration options
- Update architecture docs if patterns changed

### Step 6.2: Create Implementation Summary

Use the template at `references/templates/implementation-summary.md` to document:

- What was built
- Files changed
- Architecture decisions made
- Testing performed
- Known limitations
- Follow-up items

### Step 6.3: Clean Up Task Tracking

- Mark all tasks as completed
- Cancel any tasks that became unnecessary
- Archive or delete the task list

### Step 6.4: Final Verification

Confirm:

- [ ] No uncommitted changes remain
- [ ] All tasks marked complete or cancelled
- [ ] Implementation summary documented
- [ ] Ready for review/merge

### Step 6.5: Final Commit

Commit documentation updates.

---

## Phase Execution Summary

| Phase | Gate | Must Complete Before Proceeding |
|-------|------|--------------------------------|
| 1. Requirements | Commit | Scope defined, tracking set up |
| 2. Architecture | Commit | Decision documented (if needed) |
| 3. Implementation | Commit | Code complete, tests written |
| 4. Integration | Commit | Components integrated, conflicts resolved |
| 5. Verification | Commit | All checks pass |
| 6. Documentation | Commit | Docs updated, cleanup complete |

**Remember:** Each phase ends with a commit. Do not proceed to the next phase until the current phase is committed.

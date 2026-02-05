# Bugfix Phases - Detailed Instructions

This document provides detailed guidance for each phase of the bugfix workflow.

## Phase 1: Context Gathering & Architecture Analysis (5-10 min)

### Step 1.1: Check for Architecture Documentation

Look for existing architecture documentation (e.g., `docs/architecture/data-model.md`). If it doesn't exist and would be helpful, consider generating it first.

### Step 1.2: Read Architecture for Context

Perform deep analysis of architecture to understand bug context:

**Database Layer Analysis**:
- Read ERD and entity relationships
- Understand foreign key constraints
- Check indexes and query patterns
- Identify potential N+1 query scenarios
- Review validation rules and constraints

**Service Layer Analysis**:
- Understand DTO structures and validation
- Review domain model business logic
- Check data transformation patterns
- Identify error handling approaches
- Analyze dependency injection patterns

**API Layer Analysis**:
- Review endpoint implementations
- Check request/response DTOs
- Understand middleware and error handling
- Analyze authentication/authorization flows
- Review rate limiting and validation

**UI Layer Analysis**:
- Understand component data flows
- Review state management patterns
- Check form validation logic
- Analyze error display mechanisms
- Review data fetching strategies

**Data Flow Analysis**:
- Trace end-to-end data flow for affected feature
- Identify all transformation points
- Check validation at each layer
- Review error propagation
- Understand state synchronization

### Step 1.3: Gather Bug Context

Collect comprehensive information about the bug:

**User-Provided Information**:
- Bug description
- Steps to reproduce
- Expected behavior
- Actual behavior
- Error messages/stack traces
- Environment (dev/staging/prod)

**System Context** (auto-detected):
- Technology stack
- Affected components (from architecture analysis)
- Related entities and data flows
- Recent code changes (if available via git)

**Create Bug Context Document** using template: `references/templates/context.md`

---

## Phase 2: Diagnostic Instrumentation (10-15 min)

**CRITICAL**: Add instrumentation FIRST, before attempting fixes.

### Step 2.1: Add Targeted Diagnostic Logs

**Database Layer Diagnostics**:
```typescript
// Add query logging
console.log("[DEBUG] Query executing:", {
  query: "SELECT * FROM users WHERE id = $1",
  params: [userId],
  timestamp: new Date().toISOString(),
});

// Log query results
console.log("[DEBUG] Query result:", {
  rowCount: result.rows.length,
  executionTime: `${endTime - startTime}ms`,
  data: result.rows,
});
```

**Service Layer Diagnostics**:
```typescript
// Add service entry/exit logging
console.log("[DEBUG] Service method called:", {
  service: "UserService",
  method: "updateProfile",
  input: sanitizeForLog(input),
  timestamp: new Date().toISOString(),
});

// Log validation results
console.log("[DEBUG] Validation result:", {
  isValid: validationResult.isValid,
  errors: validationResult.errors,
});
```

**API Layer Diagnostics**:
```typescript
// Add request/response logging
console.log("[DEBUG] API request:", {
  method: req.method,
  path: req.path,
  query: req.query,
  body: sanitizeForLog(req.body),
});

console.log("[DEBUG] API response:", {
  statusCode: res.statusCode,
  body: sanitizeForLog(responseBody),
  executionTime: `${Date.now() - startTime}ms`,
});
```

**UI Layer Diagnostics**:
```typescript
// Add component state logging
console.log("[DEBUG] Component state:", {
  component: "UserProfile",
  prevState: prevState,
  nextState: nextState,
  trigger: "useEffect",
});
```

### Step 2.2: Add Error Boundaries and Handlers

```typescript
try {
  const result = await processPayment(paymentData);
} catch (error) {
  console.error("[DEBUG] Error caught:", {
    location: "PaymentService.processPayment",
    error: {
      name: error.name,
      message: error.message,
      stack: error.stack,
      cause: error.cause,
    },
    input: sanitizeForLog(paymentData),
  });
  throw error;
}
```

### Step 2.3: Diagnostic Checklist

Verify instrumentation covers:
- [ ] Database layer: Query logging, result logging, execution time
- [ ] Service layer: Entry/exit, validation, transformations
- [ ] API layer: Request/response, middleware, error handling
- [ ] UI layer: State changes, API calls, store updates
- [ ] Cross-cutting: Error boundaries, data flow checkpoints

---

## Phase 3: Reproduce & Analyze (10-15 min)

### Step 3.1: Attempt to Reproduce Bug

Document reproduction attempt:
- Steps executed with exact parameters
- Environment state (database, user context, external dependencies)
- Result: Reproduced / Unable to reproduce / Partial reproduction

### Step 3.2: Collect Diagnostic Output

Save all diagnostic logs using template: `references/templates/diagnostic-logs.md`

### Step 3.3: Analyze Diagnostic Data

Review logs to identify patterns:

**Data Flow Analysis**:
- Where does data enter the system?
- How is it transformed at each layer?
- Where does the error first occur?
- What data is missing or malformed?

**Timing Analysis**:
- Performance bottlenecks identified?
- Timeout issues?
- Race conditions?

**State Analysis**:
- What is the state before error?
- What state change triggers error?
- Is state synchronized across layers?

---

## Phase 4: Hypothesis Generation & Distillation (10-15 min)

### Step 4.1: Generate 5-7 Hypotheses

Based on diagnostic data and architecture analysis, generate comprehensive list of possible causes. For each hypothesis document:

- **Likelihood**: High / Medium / Low
- **Evidence**: What diagnostic data supports this?
- **Data Flow Point**: Where in the flow does this occur?
- **Affected Layer**: Which architectural layer?

Example hypothesis format:
```markdown
### Hypothesis 1: N+1 Query Problem
**Likelihood**: High
**Evidence**:
- Diagnostic logs show sequential queries
- User entity loaded without relationships
- Performance degrades with more records

**Data Flow Point**: Database → Service layer
**Affected Layer**: Repository/ORM
```

### Step 4.2: Distill to 1-2 Most Likely Causes

Apply systematic analysis to narrow down:

**Distillation Criteria**:
1. **Evidence Strength**: How much diagnostic data supports this?
2. **Architecture Alignment**: Does architecture documentation confirm this pattern?
3. **Data Flow Analysis**: Does timeline support this hypothesis?
4. **Probability**: Based on error type and context

Document distilled causes with confidence percentages and explain why alternatives were ruled out.

### Step 4.3: Validate Hypotheses with Diagnostic Data

Cross-reference distilled hypotheses with diagnostic logs:
- Check specific log lines that support/contradict hypothesis
- Verify timeline matches expected behavior
- Confirm data flow matches hypothesis

---

## Phase 5: User Confirmation (CRITICAL - MANDATORY)

### Step 5.1: Present Diagnosis to User

Use template: `references/templates/diagnosis-report.md`

**STOP HERE** - Do NOT implement fix until user confirms.

### Step 5.2: Wait for User Response

**DO NOT PROCEED** until user explicitly confirms:
- "Yes, fix it"
- "Diagnosis looks correct, proceed"
- "Implement the fix"

**If user provides additional context**:
- Update diagnostic logs
- Re-run hypothesis generation
- Present updated diagnosis

**If user says diagnosis is wrong**:
- Ask for specific feedback
- Add more targeted diagnostics
- Re-analyze with new information

---

## Phase 6: Implement Fix (ONLY AFTER CONFIRMATION)

### Step 6.1: Create Fix Implementation Plan

Document:
- Files to change with specific line numbers
- Nature of each change
- Tests to add
- Documentation updates needed
- Risk assessment and rollback plan

### Step 6.2: Implement Fix with Tests

- Implement the primary fix
- Add defensive measures (null checks, validation)
- Write unit tests for fix
- Write tests for edge cases

### Step 6.3: Remove Diagnostic Logs

**IMPORTANT**: Clean up all diagnostic instrumentation added in Phase 2.

Cleanup checklist:
- [ ] No `console.log('[DEBUG]` statements remain
- [ ] No temporary error handlers added
- [ ] No performance timing code left
- [ ] Original error handling restored

**Keep only**:
- Existing production logging
- New defensive null checks (these are permanent improvements)

---

## Phase 7: Testing & Verification (10-15 min)

### Step 7.1: Test Fix Locally

```bash
# Run affected tests
npm test -- [affected-test-file]

# Run integration tests
npm test -- [integration-test-file]

# Build verification
npm run build

# Type checking
npm run type-check
```

### Step 7.2: Verify Bug Resolution

Reproduce original bug scenario and verify:
- Original steps now work correctly
- Error no longer occurs
- Edge cases handled properly
- No performance degradation

### Step 7.3: Run Full Test Suite

Verify no regressions:
- All existing tests pass
- New tests for fix pass
- No unintended side effects

---

## Phase 8: Documentation (10 min)

### Step 8.1: Update Architecture Documentation

If pattern or best practice identified, update architecture docs with:
- New patterns discovered
- Pitfalls to avoid
- Recommended approaches

### Step 8.2: Create Bug Resolution Document

Use template: `references/templates/resolution.md`

Document:
- Summary of fix
- Root cause explanation
- Files changed
- Testing performed
- Prevention strategies

---

## Final Checklist

### Diagnosis Phase
- [ ] Architecture documentation read
- [ ] Bug context gathered and documented
- [ ] Diagnostic instrumentation added
- [ ] Bug reproduced successfully
- [ ] Diagnostic data collected

### Hypothesis Phase
- [ ] 5-7 hypotheses generated
- [ ] Hypotheses distilled to 1-2 most likely
- [ ] Validation with diagnostic data completed
- [ ] Diagnosis presented to user
- [ ] User confirmed diagnosis

### Fix Phase
- [ ] Fix implemented with tests
- [ ] All tests passing
- [ ] No regressions detected
- [ ] Diagnostic logs removed
- [ ] Bug verified as resolved

### Documentation Phase
- [ ] Architecture docs updated (if applicable)
- [ ] Resolution document created

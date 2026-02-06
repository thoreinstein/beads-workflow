---
name: refactor
description: Analyze code and suggest refactoring opportunities with blast radius assessment, risk evaluation, and recommended order of operations
---

# Refactor

## Agent Delegation
You MUST delegate the assessment of system-wide dependencies and long-term architectural impact of refactoring choices to the `software-architect` sub-agent.

## When to Use

- Reviewing code for improvement opportunities
- Planning a refactoring initiative
- Assessing technical debt in a codebase area
- Evaluating complexity, duplication, or coupling concerns
- Understanding blast radius before making changes

## Input

- **Target**: file path, directory/package, or function/component name
- **Optional**: specific concern (duplication, complexity, coupling, testability, etc.)

## Investigation Strategy

### Track 1: Codebase Exploration

- Map dependencies and call sites for target code
- Identify blast radius of potential changes
- Find related code with similar patterns
- Assess test coverage of affected areas

### Track 2: Code Analysis

- Deep analysis of code smells and patterns
- Identify refactoring opportunities
- Assess complexity metrics
- Evaluate maintainability concerns

## Refactoring Patterns

### Universal Patterns

| Pattern | Description |
|---------|-------------|
| Extract function/method | Pull out reusable logic |
| Inline function/variable | Remove unnecessary indirection |
| Rename | Improve clarity (with blast radius assessment) |
| Move | Relocate to better home (file, package, module) |
| Replace conditional with polymorphism | Simplify branching |
| Introduce parameter object | Group related parameters |
| Dependency inversion | Decouple via interfaces/abstractions |

### Go-Specific Patterns

| Pattern | Description |
|---------|-------------|
| Extract interface | Define behavior contracts |
| Consolidate error handling | Reduce repetitive error checks |
| Replace concrete with interface | Improve testability |
| Extract middleware | Separate cross-cutting concerns |
| Table-driven refactor | Convert repetitive code to data-driven |

### Frontend-Specific Patterns

| Pattern | Description |
|---------|-------------|
| Extract component | Break down large components |
| Extract custom hook | Reuse stateful logic |
| Lift state up | Move state to common ancestor |
| Push state down | Colocate state with usage |
| Extract render function | Simplify complex JSX |
| Memoization | Optimize re-renders |

## Output

Document the analysis using the template at `references/templates/refactor-analysis.md`.

The analysis should include:
- Code smells identified with locations
- Suggested refactorings with risk assessment
- Blast radius for each change
- Recommended order of operations
- Test coverage assessment

## Constraints

- **Analysis only**: Do not execute refactorings - document recommendations
- **Blast radius required**: Every suggestion must include affected files/functions
- **Risk assessment required**: Every suggestion must be rated Low/Medium/High
- **Order matters**: Recommend sequence based on risk and dependencies
- **Test awareness**: Note test coverage and impact for each suggestion

## Example

```
Refactoring Analysis: pkg/auth/handler.go

Target:
- Path: pkg/auth/handler.go
- Scope: file
- Concern: complexity

Summary:
The auth handler has grown to 450 lines with 3 code smells identified.
Recommend extracting token validation and session management into
separate services. Low-risk changes that improve testability.

Code Smells Identified:

1. Long Function (validateAndCreateSession)
   - Location: handler.go:145-280
   - Description: 135-line function handling validation, session
     creation, and response formatting
   - Impact: Hard to test, multiple responsibilities

2. Feature Envy (token validation)
   - Location: handler.go:156-198
   - Description: Handler reaches into token package internals
   - Impact: Tight coupling, changes ripple across packages

Suggested Refactorings:

1. Extract TokenValidator service
   - Type: Extract
   - Target: handler.go:156-198
   - Rationale: Encapsulates token validation logic
   - Blast Radius: handler.go, handler_test.go
   - Risk: Low — isolated logic, good test coverage
   - Test Impact: Add TokenValidator unit tests

2. Extract SessionManager service
   - Type: Extract
   - Target: handler.go:200-250
   - Rationale: Separates session concerns from HTTP handling
   - Blast Radius: handler.go, session.go, handler_test.go
   - Risk: Medium — touches session storage
   - Test Impact: Update integration tests

Recommended Order:
1. TokenValidator first (lowest risk, no dependencies)
2. SessionManager second (depends on cleaner handler)
```

Begin by identifying the target code and any specific concerns to focus on.

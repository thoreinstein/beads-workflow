---
name: analyze
description: Deep analysis mode - thorough multi-phase investigation with expert consultation for complex problems requiring careful examination
---

# Deep Analysis Mode

## Agent Delegation
You MUST delegate system-wide dependency analysis and architectural mapping to the `codebase_investigator` sub-agent. For high-level design evaluations and technical trade-offs, consult the `software-architect`.

## HARD CONSTRAINTS (NON-NEGOTIABLE)

- **READ-ONLY MODE** — This skill is for analysis, not implementation
- **NO CODE WRITING** — Do not write, edit, or modify any source code
- **NO IMPLEMENTATION** — Do not implement features, fix bugs, or make changes
- **OUTPUT IS DOCUMENTATION** — Your deliverable is analysis/plan documents only

If you find yourself wanting to write code, STOP. Analysis produces documents, not software.

## When to Use This Skill

- Before major refactoring or architectural changes
- When evaluating unfamiliar code for risks or technical debt
- During security or performance audits
- When making build-vs-buy or technology decisions
- To produce a documented assessment for stakeholder review
- **As the `/analyze` command** to produce implementation plans for `/implement`

## Workflow

### Phase 1: Reconnaissance

Explore the target area to build context:

1. **Map the structure:**
   - Identify relevant files, modules, and their relationships
   - Understand the dependency graph and data flow

2. **Find patterns:**
   - Look for recurring code patterns (both good and concerning)
   - Identify conventions and deviations from them

3. **Gather context:**
   - Review git history for recent changes and contributors
   - Check for related documentation, comments, or TODOs

### Phase 2: Domain Analysis

Analyze the target across these dimensions:

| Domain           | Focus Areas                                      |
| ---------------- | ------------------------------------------------ |
| **Architecture** | System design, data flow, component dependencies |
| **Security**     | Vulnerabilities, threat model, input validation  |
| **Reliability**  | Scalability, failure modes, error handling       |
| **Performance**  | Bottlenecks, complexity, resource usage          |
| **Code Quality** | Patterns, anti-patterns, maintainability         |

### Phase 3: Deep Dive

Examine comprehensively:

- Edge cases and potential failure modes
- Performance implications under load
- Security attack surface
- Error handling completeness
- Testability and test coverage gaps
- Technical debt and maintenance burden

### Phase 4: Synthesis

Combine findings into a structured report following the template in `references/analysis-report-template.md`.

The report should include:

- **Executive Summary** - Key findings and top recommendation
- **Detailed Analysis** - By domain (architecture, security, performance, code quality)
- **Issues Found** - Prioritized as Critical (P0), High (P1), Medium (P2)
- **Recommendations** - Immediate actions, short-term improvements, long-term considerations
- **Trade-offs** - Analysis of different approaches with pros/cons

## Analysis Focus Areas

| Area                | What to Examine                         |
| ------------------- | --------------------------------------- |
| **Correctness**     | Logic errors, edge cases, assumptions   |
| **Security**        | Input validation, auth, data protection |
| **Performance**     | Complexity, caching, resource usage     |
| **Reliability**     | Error handling, failure modes, recovery |
| **Maintainability** | Readability, coupling, documentation    |
| **Testability**     | Coverage, mocking, isolation            |

## Implementation Plan Workflow

When using this skill to generate implementation plans for `/implement`:

### Step 1: Scope Check (GATE)

After fetching the ticket, determine its type and scope:

1. **Check if Epic:** Does it have child tickets/stories?
2. **Count children:** How many child tickets exist?

#### Scope Guard

| Condition | Action |
| --------- | ------ |
| **Single ticket (story/task)** | Proceed with analysis |
| **Epic with 1-3 children** | Proceed — manageable scope |
| **Epic with 4+ children** | **STOP** — Scope too large |

**If scope is too large:**
Ask the user for confirmation before proceeding with large epics, recommending analysis of individual stories instead.

### Step 2: Codebase Research

Research the implementation context for each ticket in scope to determine implementation order, parallelization opportunities, and shared concerns.

### Step 3: Implementation Mapping

For each ticket, identify specific files to modify, functions/components to change, schema changes, and test files.

### Step 4: Output - Implementation Plan

Produce a structured implementation plan using the following template:

```markdown
# Implementation Plan: <ticket-id>

## Executive Summary
[Summary of scope and approach]

## Tickets in Scope
| ID | Title | Status | Dependencies | Parallelizable |
| -- | ----- | ------ | ------------ | -------------- |

## Implementation Phases
### Phase 1: <name>
**Tickets:** <list of ticket IDs>
#### Ticket <ID>: <title>
- **Work:** [Specific actions]
- **Files:** [Files to modify]
- **Verification:** [How to verify]

[Repeat for other phases]

## Risk Assessment
[Risks and mitigations]
```

### Step 5: Save Plan (MANDATORY)

Plans MUST be saved using the Obsidian MCP tools (`obsidian_append_note`). Do NOT use local filesystem write tools.
**Path:** `{{BEADS_PLAN_DIR or "working/plans"}}/<ticket-id>-plan.md`

---

## Constraints

- **Read-only** — analyze code, do not modify it
- **Obsidian storage** — implementation plans must be stored in the Obsidian vault
- **No implementation** — produce plans, not code

---

Begin by performing reconnaissance on the target area before conducting domain analysis.

**Remember: Your output is documentation. Do not write code.**

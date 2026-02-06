---
name: refine
description: Refine epics and stories through cross-functional analysis and requirements gathering
---

# Refinement Skill

## Agent Delegation
You MUST delegate the requirements analysis, backlog refinement, and story breakdown tasks to the `agile-delivery-lead` sub-agent. Use their expertise to ensure stories are well-structured and provide clear business value.

## HARD CONSTRAINTS (NON-NEGOTIABLE)

- **INTERACTIVE MODE ONLY** — STOP after each phase and wait for the user to respond.
- **NO CODE READING** — This is a requirements refinement exercise.
- **NO SOLUTIONING** — Describe WHAT, never HOW.
- **--parent AND --description ARE MANDATORY** — All beads tickets MUST use these flags at creation.

## Workflow: Epic Refinement

### Phase 1: Title & Description
Critique the problem statement, scope boundaries, and user value. **STOP.**

### Phase 2: Acceptance Criteria
Refine existing AC for verifiability and edge cases. **STOP.**

### Phase 3: Gap Analysis
Identify cross-functional gaps (Security, Quality, etc.). **STOP.**

### Phase 4: Child Stories Breakdown
Propose a breakdown of 3-5 child stories. **STOP.**

### Phase 5: Execution
Create stories: `bd create --parent <epic-id> --description "<desc + AC>" "<title>"`

## Workflow: Story Refinement

### Phase 1: Description & AC
Ensure clear user value and testable AC. **STOP.**

### Phase 2: Gap Analysis
Check for error handling, data requirements, and edge cases. **STOP.**

### Phase 3: Breakdown Assessment
Determine if the story is small enough for one session (1-2 hours). If not, recommend breaking down into tasks. **STOP.**

### Phase 4: Execution
Create tasks or confirm "Ready for Dev".
`bd create --parent <story-id> --description "<desc + AC>" "<title>"`

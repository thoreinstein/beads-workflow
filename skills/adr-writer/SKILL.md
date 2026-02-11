---
name: adr-writer
description: Interactive discovery session to define ADR structure, capture key decisions, and generate ADR content adhering to adr.github.io standards.
---

# ADR Writer

## Agent Delegation

You MUST collaborate with the `software-architect` and `principal-engineer` sub-agents to ensure technical depth and architectural integrity.

- **software-architect**: Consult for trade-off analysis, technical direction, and alignment with system standards.
- **principal-engineer**: Consult for deep technical implications, second-order effects, and escape hatches.

## When to Use

- Capturing significant architectural decisions
- Documenting technical direction for a new feature or system
- Recording trade-offs made during a design session
- Ensuring long-term maintainability by making decisions explicit

## Input

- **ADR Title**: The primary decision being recorded.
- **Initial Context**: The problem statement or background for the decision.
- **Optional**: Related issue/ticket IDs, considered options.

## Workflow

### Phase 1: Discovery (Interactive)

1. Ask the Boss for the ADR title and initial context if not provided.
2. Identify the core problem and decision drivers (requirements, constraints, quality attributes).
3. List the options being considered.

### Phase 2: Consultation

1. **Architect Review**: Prompt the `software-architect` to analyze the trade-off space and ensure alignment with the system's long-term strategy.
2. **Principal Review**: Prompt the `principal-engineer` to identify risks, second-order effects, and potential failure modes of the proposed options.
3. Consolidate the feedback from both agents into the "Pros and Cons" and "Decision Drivers" sections.

### Phase 3: Drafting

1. Use the standard ADR template (based on adr.github.io).
2. Generate a draft ADR markdown file.
3. Ensure the "Decision Outcome" includes a strong justification and clearly listed consequences (Positive/Negative).

### Phase 4: Review & Finalization

1. Present the draft to the Boss for approval or revision.
2. Once approved, save the ADR to the `docs/adr/` directory (or the project's designated ADR location).
3. **Naming Convention**: `ADR-NNN-kebab-case-title.md` (where NNN is the next sequential number).

## Output Template

The ADR MUST follow the `adr.github.io` standard format:

```markdown
# [Title]

- Status: [Proposed | Accepted | Superseded by ADR-...]
- Deciders: [List of decision makers]
- Date: [YYYY-MM-DD]

Technical Story: [Optional: link to ticket/issue]

## Context and Problem Statement

[Describe the context and problem statement.]

## Decision Drivers

- [driver 1, e.g., a force, a requirement, a constraint, a quality attribute, ...]
- [driver 2, ...]

## Considered Options

- [option 1]
- [option 2]

## Decision Outcome

Chosen option: "[option 1]", because [justification].

### Positive Consequences

- [e.g., improvement of quality attribute, ...]

### Negative Consequences

- [e.g., compromising quality attribute, ...]

## Pros and Cons of the Options

### [option 1]

- Good, because [argument a]
- Bad, because [argument c]

### [option 2]

- Good, because [argument a]
- Bad, because [argument c]
```

## Constraints

- **Standards**: Always adhere to `adr.github.io` MADR (Markdown ADR) standards.
- **Consistency**: Ensure sequential numbering of ADRs.
- **Depth**: Never accept a "Decision Outcome" without a clear "Rationale" and "Consequences" section.
- **Collaboration**: Both architect and principal agents MUST be referenced in the decision-making process.

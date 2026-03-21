name: idd
description: Transform fuzzy ideas into Intent-Driven Development (IDD) artifacts and Intent-driven Beads.

---

# IDD Refinement Skill

## Goal

Transform a high-level "Idea" into a "Product" (Epic), "Intentions" (Features), and "Expectations" (Acceptance Criteria) using the IDD Framework.

## Agent Delegation

You MUST delegate the product discovery and intention mapping to the `agile-delivery-lead` and `prd-architect` sub-agents. They are the "Spec Authors" for the upstream context.

## Initial Step: The Idea

The user provides a fuzzy idea. Your job is to drive the **Descent of Detail**.

## HARD CONSTRAINTS (NON-NEGOTIABLE)

- **INTERACTIVE MODE ONLY** — STOP after each phase and wait for the user to respond.
- **NO SOLUTIONING** — Describe WHAT and WHY, never HOW.
- **CHAIN OF CONTEXT** — Every Intention MUST inherit the context of the Product.
- **MANDATORY OBSIDIAN RECORD** — All IDD artifacts (Product, Intention, Expectation) MUST be saved as a single note in the `refinements/` directory in Obsidian.

## Workflow: Idea to Intent-Driven Beads

### Phase 1: Product Definition (The "Why")

Critique the initial idea. Define the problem space, the value proposition, and the "North Star."
**STOP.** Ask the user if the "Product" vision is correct.

### Phase 2: Intention Mapping (The "What")

Break the Product down into 3-5 "Intentions" (Features). Each Intention must describe a specific capability that solves a part of the "Why."
**STOP.** Ask the user to select or refine the Intentions.

### Phase 3: Expectation Setting (The "How we know")

For the selected Intention(s), define the "Expectations." These are verifiable constraints and edge cases. This is where you define the "Completeness Gate."
**STOP.** Ask the user to confirm the Expectations.

### Phase 4: Boundary Mapping (The "What NOT to do")

Define the "Boundaries" for the upcoming implementation. What should the AI NOT touch? What architectural constraints must be respected?
**STOP.** Ask the user for any additional prohibitions.

### Phase 5: Bead Execution

Create the Intent-driven Beads using the following format:
`bd create --parent <product-id> --description "# [IDD Context]\n- **Intention:** <what>\n- **Expectations:** <how>\n- **Boundaries:** <not>\n" "<title>"`

## Obsidian Storage (MANDATORY)
Save the final "IDD Context" note to Obsidian:
`working/<project-name>/refinements/<product-name>-idd-context.md`

### Template for Obsidian Note:
```markdown
# IDD Context: <product-name>

## Product (Why)
...

## Intentions (What)
...

## Expectations (How)
...

## Boundaries (What NOT to do)
...

## References
- [ ] No parent context (Initial Idea)
```

## Constraints

- **INTERACTIVE MODE ONLY** — STOP after each phase.
- **NO CODE READING** — This is a requirements and intent exercise.
- **NO SOLUTIONING** — Describe WHAT, never HOW.
- **LOCAL FILESYSTEM RESTRICTION**: Never use `write_file` for documentation.

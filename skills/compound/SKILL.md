---
name: compound
description: Extract lessons, patterns, and architectural truths to compound team knowledge
---

# Compounding Knowledge

## Agent Delegation
You MUST delegate the identification of architectural truths, patterns, and long-term design consequences to the `software-architect` sub-agent. They are the authority on how these lessons influence the system's technical direction.

## Workflow

### Phase 1: The Retrospective

Analyze the work done for the ticket. Identify:

1.  **The "Trap":** What was harder than expected? What "bit" us?
2.  **The "Pattern":** What new design pattern did we establish?
3.  **The "Decision":** What architectural choice did we make that binds us?

**Interactive Step:**
Ask the user for their perspective on what should be remembered and what new patterns were established.

### Phase 2: Knowledge Crystalization

Formulate **Knowledge Artifacts**:

1.  **Pattern**: A reusable code structure or standard.
    - *Path*: `Knowledge/Patterns/<Name>.md`
2.  **Trap**: A warning about a specific system behavior or "gotcha."
    - *Path*: `Knowledge/Traps/<Name>.md`
3.  **Decision**: An architectural record (ADR-lite).
    - *Path*: `Knowledge/Decisions/<Name>.md`

### Phase 3: The Compounding (Execution)

Use `obsidian_append_note` to store artifacts in the Obsidian vault.
**Path**: `Knowledge/[Patterns|Traps|Decisions]/<Title>.md`
**Tags**: Include `#compound #learning #<ticket-id>`.

## Constraints

- **NO CODE CHANGES** — Analysis and documentation only.
- **TRUTH ONLY** — Document actual occurrences and decisions.
- **USE OBSIDIAN** — All artifacts must be stored in the Obsidian vault.

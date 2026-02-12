---
name: compound
description: Extract lessons, patterns, and architectural truths to compound team knowledge
---

# Compounding Knowledge

## Agent Delegation
You MUST delegate the identification of architectural truths, patterns, and long-term design consequences to the `software-architect` sub-agent. They are the authority on how these lessons influence the system's technical direction.

## Workflow

### Phase 1: The Retrospective

Analyze the work done for the ticket by conducting a multi-stage review to surface pitfalls in the workflow:

1.  **Requirement vs. Strategy Review:** Review the original bead description and Acceptance Criteria (AC) against the plan generated during the `analyze` phase.
2.  **Strategy vs. Execution Review:** Review the plan from the `analyze` phase against the summary from the `implement` phase.
3.  **Iteration Review:** Review any follow-on summaries from `refactors` or `bugfixes` that occurred after the initial implementation.
4.  **Workflow Audit:** Surface any pitfalls, misalignments, or inefficiencies discovered in the `plan` -> `analyze` -> `implement` workflow.

Identify:

1.  **The "Trap":** What was harder than expected? What "bit" us?
2.  **The "Pattern":** What new design pattern did we establish?
3.  **The "Decision":** What architectural choice did we make that binds us?

**Interactive Step:**
Ask the user for their perspective on what should be remembered and what new patterns were established.

### Phase 2: Knowledge Crystalization

Formulate **Knowledge Artifacts**.

**Path Logic:**
1. **Identify Project Name**: Use the `BEADS_PROJECT_NAME` env var or the current directory name.
2. **Base Path**: `working/<project-name>/knowledge`

**Artifacts:**
All artifacts MUST include YAML frontmatter with the following metadata:
```yaml
---
type: [pattern | trap | decision]
project: <project-name>
language: [typescript | go | python | etc]
status: [draft | active | deprecated]
tags: [tag1, tag2]
created: YYYY-MM-DD
---
```

1.  **Pattern**: A reusable code structure or standard.
    - *Path*: `<Base Path>/patterns/<Name>.md`
2.  **Trap**: A warning about a specific system behavior or "gotcha."
    - *Path*: `<Base Path>/traps/<Name>.md`
3.  **Decision**: An architectural record (ADR-lite).
    - *Path*: `<Base Path>/decisions/<Name>.md`

### Phase 3: Project Synthesis (GEMINI.md)

After storing artifacts in Obsidian, synthesize the new knowledge to update the `GEMINI.md` file in the project root. This file serves as the long-term project context for future agent sessions.

1.  **Read** the current `GEMINI.md` (create it if it doesn't exist).
2.  **Append** or integrate new patterns, conventions, or "traps" identified in this session.
3.  **Update Locally**: Use local filesystem tools (`write_file`, `replace`) to update `GEMINI.md`. This is the sole exception to the Obsidian-only guardrail.
4.  **Ensure** the information is structured for maximum utility in future prompts.

## Constraints

- **GEMINI.md UPDATES ONLY** — No changes to source code. Analysis and context documentation only.
- **GEMINI.md EXCEPTION** — The `GEMINI.md` file in the project root is the ONLY non-source-code file that may be updated locally. All other planning and documentation MUST be in Obsidian.
- **TRUTH ONLY** — Document actual occurrences and decisions.
- **USE OBSIDIAN** — Knowledge artifacts (patterns, traps, decisions) must be stored in the Obsidian vault.

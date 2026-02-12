# Project Context: beads-workflow

## Core Mandates

### Guardrails
- **ARTIFACT STORAGE**: All planning documents, analysis reports, implementation summaries, and retrospective notes MUST be stored in the Obsidian vault using `obsidian_create_note`.
- **LOCAL FILESYSTEM RESTRICTION**: Never use local filesystem write tools (`write_file`, `replace`, etc.) to create or modify documentation or planning artifacts within the project directory. The local filesystem is strictly for source code, configuration files, and tests.
- **GEMINI.md EXCEPTION**: The `GEMINI.md` file in the project root is the ONLY non-source-code file that may be updated locally by the `compound` skill to synthesize project-wide knowledge.
- **PULL REQUESTS**: The agent shall ONLY open a Pull Request if explicitly requested by the user.
- **NO SELF-MERGING**: The agent MUST NEVER merge their own Pull Requests. Merging is a user-only action.
- **COMPLETION FLOW**: A ticket is only considered complete after:
    1. The user informs the agent that the PR has been merged.
    2. The agent runs the `/compound` skill to extract lessons and update project context.
    3. The agent marks the ticket as `done` in Beads.


## Knowledge Management

- **Vault Location**: Defined by the `OBSIDIAN_VAULT_PATH` environment variable.
- **Base Path**: `working/<project-name>/`
- **Subdirectories**:
  - `plans/`: For implementation plans and analysis reports.
  - `summaries/`: For implementation and bugfix summaries.
  - `knowledge/`: For patterns, traps, and architectural decisions.

## Workflow Overview

The standard engineering workflow follows a strict **Research -> Strategy -> Execution -> Retrospective** lifecycle.

### 1. Research & Refinement (`/epic` or `/story`)

- **Action**: Use `bd ready` to find unblocked work.
- **Goal**: Refine the Epic or Story. Ensure Acceptance Criteria (AC) are testable and the problem statement is clear.
- **Output**: Detailed Beads tickets with descriptions and AC.

### 2. Strategy & Planning (`/analyze`)

- **Action**: Analyze the ticket to determine the technical approach.
- **Mandate**: Produce an **Implementation Plan**.
- **Storage**: Plans MUST be saved as notes in the Obsidian `plans/` directory. No code is written in this phase.

### 3. Execution (`/implement`)

- **Action**: Load the Implementation Plan from Obsidian.
- **Status**: Update Beads status to `in-progress`.
- **Loop**: Follow the **Phase Execution Loop**:
  1. **Plan**: Define work for the current phase.
  2. **Work**: Implement ONLY scoped changes.
  3. **Verify**: Run tests, lint, and build.
  4. **Commit**: Create atomic commits (No `--no-verify`).

### 4. Integration & Closure

- **Action**: Create Pull Request.
- **Mandate**: Tickets remain `in-progress` until the PR is merged into the trunk branch.
- **Output**: Once merged, mark tickets as `done` and generate an **Implementation Summary** in the Obsidian `summaries/` directory.

### 5. Compounding Knowledge (`/compound`)

- **Action**: Conduct a multi-stage retrospective.
- **Goal**: Identify "Traps," "Patterns," and "Decisions."
- **Storage**: Save artifacts to the Obsidian `knowledge/` directory and synthesize global context into this `GEMINI.md` file.

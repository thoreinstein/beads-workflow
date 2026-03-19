# Release Notes - v1.8.0 (2026-03-19)

### Summary
This release introduces significant enhancements to the refinement workflow, specialized sub-agents, and a new 'pr-comments' skill for automated PR management.

### Highlights
- **Refinement Constraints**: Mandatory LLM-driven Obsidian records and restricted PM sub-agent behavior.
- **New Skill**: Added 'pr-comments' skill for efficient PR handling.
- **Specialized Agents**: Introduced a suite of pro and reviewer sub-agents across multiple languages.
- **Reliability**: Critical fixes for project hooks (path traversal, JSON injection, latency).
# Release v1.7.2

## Summary
This patch release refines the ticket tracking workflow by migrating to the dedicated `bd close` command and the "closed" status across all core documentation and skill-based workflows.

## Documentation Refactorings
- **Workflow Refinement**: Migrated from the legacy `bd update --status done` command to the specialized `bd close` command for cleaner task completion.
- **Status Consistency**: Replaced all references to 'done' status with 'closed' terminology to align with the latest Beads CLI patterns.
- **Project Mandates**: Updated `GEMINI.md` and both `bugfix` and `implement` skills to reflect the new closure requirements.

# Release v1.7.1

## Summary
This patch release refactors the extension's hook configuration to use a structured, event-based hierarchy and introduces `${extensionPath}` resolution for reliable script execution across environments.

## Refactorings
- **Structured Hooks**: Migrated `hooks.json` to a more scalable schema organized by lifecycle events (`BeforeTool`, `SessionStart`, `SessionEnd`).
- **Dynamic Path Resolution**: Implemented `${extensionPath}` for hook commands to ensure guardrail scripts are correctly resolved regardless of the installation context.

# Release v1.7.0

## Summary
This release introduces the `plan-review` skill for cross-platform plan refinement and standardizes task tracking and research methodologies across the agent fleet. It also enhances workflow documentation with additional guardrail hooks and renames the `code-review` skill to `review` for better consistency.

## New Features
- **Plan Review Skill**: Added the `/plan-review` command to refine implementation plans across multiple sessions.
- **Methodology Standardization**: Standardized agent research and task tracking methodologies to ensure consistency.
- **Skill Refinement**: Renamed `code-review` to `review` and resolved minor typos in the `compound` skill.

## Operational Notes
- **Workflow Guardrails**: Enhanced workflow documentation and defined new guardrail hooks to prevent process errors.

# Release v1.6.0

## Summary
This release significantly enhances the refinement and knowledge management workflows. It consolidates the `/epic` and `/story` commands into a single `/refine` command, introduces the `/adr` command for Architectural Decision Records, and strictly enforces that all planning and analysis artifacts be stored in Obsidian. It also improves the `/compound` skill with a multi-stage retrospective to better capture lessons learned.

## New Features
- **Consolidated Refinement**: Replaced `/epic` and `/story` with a unified `/refine` command.
- **Architectural Decision Records**: Added the `/adr` command and `adr-writer` skill to capture key technical decisions.
- **Obsidian-Only Artifacts**: Enforced a strict guardrail requiring all planning and analysis reports to be stored in the Obsidian vault.
- **Enhanced Retrospectives**: Improved the `/compound` skill with a multi-stage review process (Requirements vs Strategy vs Execution).
- **Command Rename**: Renamed `/code-review` to `/review` to avoid conflicts with other extensions.

## Operational Notes
- **Agent File Operations**: Agents are now permitted to write and edit files as part of their standard operations, adhering to project-specific guardrails.

# Release v1.5.0

## Summary
This release standardizes artifact storage paths across all core skills, providing a consistent and predictable directory structure for project-specific working files (reports, summaries, logs).

## New Features
- **Standardized Artifact Paths**: Introduced consistent path logic for `bugfix`, `code-review`, `implement`, and `refactor` skills.

# Release v1.4.0

## Summary
This release introduces automated version management and enhances the commit workflow with interactive staging for mixed changes. It also significantly hardens the workflow documentation with new guardrails for branching and merging, ensuring a more robust and standardized process.

## New Features
- **Automated Version Bumping**: The release skill now automates version bumping across project files.
- **Interactive Staging**: The commit skill now enforces interactive staging when dealing with mixed changes to ensure precision.

## Documentation
- **Workflow Guardrails**: Implemented 'merge before close' and trunk branch protections to prevent process errors.
- **Standardization**: Enforced YAML frontmatter for knowledge artifacts and standardized the Obsidian vault directory structure.
- **Consistency Fixes**: Resolved various inconsistencies and numbering gaps across skill instructions.

# Release v1.3.0

## Summary
This release focuses on workflow flexibility and streamlining the branching strategy. It improves the branching logic and removes rigid constraints on release authoring.

## New Features
- **Smart Branching Strategy**: Implemented an improved strategy for branch management to better handle concurrent workstreams.

## Refactors
- **Flexible Release Workflow**: Removed the mandatory branch creation requirement for the `release` skill, allowing for more direct execution on the current branch.

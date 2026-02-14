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

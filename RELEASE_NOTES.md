# Release v1.2.0

## Summary
This release focuses on workflow safety and compounding knowledge. It introduces mandatory branch creation for all code-modifying skills, enhances the `compound` skill to maintain project context via `GEMINI.md`, and adds specialized triggers for bugfixing, accessibility, and rams.

## New Features
- **Mandatory Branching**: Implementation and bugfixing skills now strictly require checking out a new descriptive branch from `main`/`trunk` before any work begins.
- **Project Context Synthesis**: The `compound` skill now synthesizes newly identified patterns and truths into a local `GEMINI.md` file, preserving architectural context for future agent sessions.
- **Specialized Skill Triggers**: Added native command triggers for `/accessibility`, `/bugfix`, `/rams`, and `/code-review`.
- **Enhanced Delegation**: All core skills now explicitly delegate specialized tasks to expert sub-agents (e.g., `principal-engineer`, `security-engineer`, `qa-engineer`).

## Refactors
- **Skill Consolidation**: Refined and consolidated the `refine` and `implement` workflows to better align with high-stakes engineering standards.

## Documentation
- **Simplified Installation**: Updated installation instructions to use direct `gemini extensions install` from remote URL.

# Release v1.1.0

## Summary
This release introduces configurable plan directories for better integration with existing Obsidian vaults and modernizes the agent tool definitions to use the latest MCP standards. It also includes comprehensive documentation for installation and configuration.

## New Features
- **Configurable Plan Directory**: Added support for `BEADS_PLAN_DIR` environment variable. Plans are now saved to `working/plans` by default, but can be configured to any path within the vault.
- **Compound Knowledge Update**: The `/compound` command now natively uses Obsidian MCP tools to save artifacts, replacing the deprecated `whizz-mind` integration.

## Refactors
- **Agent Tool Modernization**: Updated all specialist agents (`architect`, `pm`, `security`, etc.) to use standard MCP tool names (`read_file`, `run_shell_command`) and updated their allowlists.

## Documentation
- **New README**: Added a detailed README.md covering prerequisites, installation, and workflow lifecycle.
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

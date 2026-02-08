# Beads Workflow

A high-stakes engineering workflow extension for the Gemini CLI, powered by **Beads** (issue tracking) and **Obsidian** (architectural planning).

This extension enforces a rigorous "Planning First" philosophy, ensuring that every line of code is backed by an architectural record and every lesson learned is compounded into permanent knowledge.

## Core Mandates

1.  **Beads is Truth**: Never work without an active ticket. Synchronize your session with `bd ready` or `bd prime`.
2.  **Obsidian is Memory**: Implementation plans and architectural records live in Obsidian. Use `/analyze` to generate them.
3.  **Atomic Execution**: Follow the `/implement` phases strictly. Commit after every phase.
4.  **Compound Knowledge**: Use `/compound` after every task to capture patterns and traps in your Obsidian vault.

## Slash Commands

| Command | Description |
| :--- | :--- |
| `/accessibility [target]` | Audits and improves web accessibility following WCAG 2.1 guidelines. |
| `/analyze <id>` | Fetches a ticket from Beads and generates a detailed implementation plan in Obsidian. |
| `/bugfix <id>` | Diagnoses and fixes bugs using hypothesis-driven debugging. |
| `/code-review [target]` | Performs comprehensive code review with security, performance, and maintainability focus. |
| `/commit [focus]` | Analyzes changes and creates atomic commits with conventional messages. |
| `/compound <id>` | Transmutes implementation lessons into permanent knowledge artifacts. |
| `/epic <id>` | Refines a large feature into high-level stories through PM analysis. |
| `/implement <id>` | Executes a plan from Obsidian, following phased gates and atomic commits. |
| `/rams [file]` | Runs an expert accessibility and visual design review. |
| `/refactor [target]` | Analyzes code and suggests refactoring opportunities with blast radius assessment. |
| `/release` | Authors release notes, changelogs, and creates signed release tags. |
| `/story <id>` | Refines a story into technical tasks. |

## Specialized Agents

The extension includes a library of specialized "Specialist" agents that handle high-stakes gates:

*   **Principal Engineer**: For complex architectural decisions and deep debugging.
*   **Software Architect**: Owns the `/analyze` output and architectural validation.
*   **Security Engineer**: Performs OWASP-aligned security reviews.
*   **SDET / QA Engineer**: Handles unit testing and exploratory browser testing.
*   **Agile Delivery Lead**: Owns the `/epic` and `/story` refinement process.
*   **SRE Engineer**: Manages reliability, SLOs, and infrastructure.

## Prerequisites

This extension requires the following tools to be installed and configured:

1.  **Beads CLI**: The git-backed issue tracker used for state management.
2.  **Obsidian MCP Server**: Required for architectural planning and knowledge compounding.
3.  **Git**: For version control and atomic commits.

## Installation

Install the extension directly via the Gemini CLI:

```bash
gemini extensions install https://github.com/thoreinstein/beads-workflow.git
```

## Workflow Lifecycle

1.  **Refine**: Use `/epic` and `/story` to establish the scope in Beads.
2.  **Plan**: Use `/analyze` to create the architectural record in Obsidian.
3.  **Execute**: Use `/implement` to build the feature, following the atomic commit cycle.
4.  **Audit**: Use `/rams` for design quality and `/code-review` for logic gates.
5.  **Compound**: Use `/compound` to ensure the team learns from the implementation.
6.  **Release**: Use `/release` to prepare the artifacts for production.

## Configuration

The extension uses the following environment variables:

*   `OBSIDIAN_VAULT_PATH`: (Required) The absolute path to your Obsidian vault.
*   `BEADS_PLAN_DIR`: (Optional) The directory within your Obsidian vault where plans are stored. Defaults to `working/plans`.
*   `BEADS_PROJECT_NAME`: (Optional) The project name used for Obsidian vault paths. Defaults to the current directory name.

Ensure these are set in your shell profile or provided to the Gemini CLI.

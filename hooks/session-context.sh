#!/usr/bin/env bash
# SessionStart hook: Provides workflow context at the start of each session.

set -euo pipefail

PROJECT_NAME="${BEADS_PROJECT_NAME:-$(basename "$PWD")}"

cat <<EOF
{"output": "Beads Workflow session started for project: ${PROJECT_NAME}. Run 'bd ready' to find unblocked work or 'bd prime' to sync your session with the current ticket. Remember: all planning artifacts go to Obsidian, local writes are for source code only."}
EOF

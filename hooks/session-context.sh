#!/usr/bin/env bash
# SessionStart hook: Provides workflow context at the start of each session.

set -euo pipefail

PROJECT_NAME="${BEADS_PROJECT_NAME:-$(basename "$PWD")}"
BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")

# Check for active ticket - Optimize: Try to use beads current if fast.
# If beads exhibits high latency, a local state cache should be used.
ACTIVE_TICKET=""
if command -v bd &>/dev/null; then
  # Optional: timeout to prevent blocking session start too long
  ACTIVE_TICKET=$(timeout 1s bd current 2>/dev/null || echo "")
fi

MSG="Beads Workflow session started for project: ${PROJECT_NAME} [${BRANCH}]"
if [ -n "$ACTIVE_TICKET" ]; then
  MSG="${MSG} | Ticket: ${ACTIVE_TICKET}"
fi
MSG="${MSG}. Run 'bd ready' to find unblocked work or 'bd prime' to sync your session with the current ticket. Remember: all planning artifacts go to Obsidian, local writes are for source code only."

# Use jq to construct the JSON output safely, avoiding injection.
jq -n --arg out "$MSG" '{"output": $out}'

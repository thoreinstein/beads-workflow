#!/usr/bin/env bash
# SessionEnd hook: Reminds the user to run /compound if tickets were
# marked done during the session without a retrospective.

set -euo pipefail

# Check if any tickets were marked done in this session by looking at
# recent bd history. If bd is not available, skip gracefully.
if ! command -v bd &>/dev/null; then
  echo '{"output": ""}'
  exit 0
fi

# Look for tickets marked done today
DONE_TODAY=$(bd list --status done --since today 2>/dev/null || true)

if [ -n "$DONE_TODAY" ]; then
  cat <<EOF
{"output": "Reminder: Tickets were marked done during this session. Have you run /compound to extract lessons and update project context? Knowledge compounding ensures the team learns from every implementation."}
EOF
else
  echo '{"output": ""}'
fi

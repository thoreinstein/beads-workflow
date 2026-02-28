#!/usr/bin/env bash
# BeforeTool hook: Enforces the LOCAL FILESYSTEM RESTRICTION guardrail.
# Allows writes to source code, config, and tests. Blocks writes to
# planning/documentation markdown files (except GEMINI.md).

set -euo pipefail

INPUT=$(cat)

# Extract file_path from the tool call JSON
FILE_PATH=$(echo "$INPUT" | jq -r '.toolCall.arguments.file_path // .toolCall.arguments.path // ""')

if [ -z "$FILE_PATH" ]; then
  echo '{"decision": "allow"}'
  exit 0
fi

BASENAME=$(basename "$FILE_PATH")

# Always allow GEMINI.md (the sole local exception)
if [ "$BASENAME" = "GEMINI.md" ]; then
  echo '{"decision": "allow"}'
  exit 0
fi

# Allow non-markdown files (source code, config, tests, etc.)
if [[ "$FILE_PATH" != *.md ]]; then
  echo '{"decision": "allow"}'
  exit 0
fi

# Block all other .md file writes — these belong in Obsidian
echo "{\"decision\": \"deny\", \"reason\": \"Markdown files (except GEMINI.md) must be stored in the Obsidian vault using obsidian_create_note. Local filesystem is for source code, config, and tests only.\"}"

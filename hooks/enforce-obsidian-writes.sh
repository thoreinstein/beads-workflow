#!/usr/bin/env bash
# BeforeTool hook: Enforces the LOCAL FILESYSTEM RESTRICTION guardrail.
# Allows writes to source code, config, and tests. Blocks writes to
# planning/documentation markdown files (except GEMINI.md).
#
# Gemini CLI convention: output JSON with {"decision": "allow"} or {"decision": "deny", "reason": "..."}.

set -euo pipefail

INPUT=$(cat)

# Extract file_path from the tool call JSON
FILE_PATH=$(echo "$INPUT" | jq -r '.toolCall.arguments.file_path // .toolCall.arguments.path // ""')

if [ -z "$FILE_PATH" ]; then
  echo '{"decision": "allow"}'
  exit 0
fi

# Normalize to absolute path via realpath to resolve '..' and ensure consistency.
# Using -m (make) because the file might not exist yet.
FILE_PATH=$(realpath -m "$FILE_PATH")
BASENAME=$(basename "$FILE_PATH")

# Always allow GEMINI.md (the sole local exception)
if [ "$BASENAME" = "GEMINI.md" ]; then
  echo '{"decision": "allow"}'
  exit 0
fi

# Allow plugin source files (agent definitions and skill definitions are source code)
if [[ "$FILE_PATH" == */agents/*.md ]] || [[ "$FILE_PATH" == */skills/*/SKILL.md ]] || [[ "$FILE_PATH" == */skills/*/*.md ]] || [[ "$FILE_PATH" == */references/*.md ]]; then
  echo '{"decision": "allow"}'
  exit 0
fi

# Performance: Cache the REPO_ROOT to avoid git rev-parse on every tool call.
CACHE_FILE="/tmp/gemini_repo_root_${USER}_$(echo "$PWD" | md5sum | cut -d' ' -f1)"
if [ -f "$CACHE_FILE" ]; then
  REPO_ROOT=$(cat "$CACHE_FILE")
else
  REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
  if [ -n "$REPO_ROOT" ]; then
    echo "$REPO_ROOT" > "$CACHE_FILE"
  fi
fi

# Allow standard project root markdown files (only at repo root, not nested)
if [ -n "$REPO_ROOT" ]; then
  FILE_DIR=$(dirname "$FILE_PATH")
  if [ "$FILE_DIR" = "$REPO_ROOT" ]; then
    case "$BASENAME" in
      README.md|CHANGELOG.md|CHANGES.md|CONTRIBUTING.md|LICENSE.md|SECURITY.md|CODE_OF_CONDUCT.md)
        echo '{"decision": "allow"}'
        exit 0
        ;;
    esac
  fi
fi

# Allow non-markdown files (source code, config, tests, etc.)
# Case-insensitive check to prevent bypass via .MD, .Md, etc.
EXTENSION="${FILE_PATH##*.}"
if ! echo "$EXTENSION" | grep -qi '^md$'; then
  echo '{"decision": "allow"}'
  exit 0
fi

# Block all other .md file writes — these belong in Obsidian.
# Using jq to construct the response safely.
REASON="Markdown files (except GEMINI.md) must be stored in the Obsidian vault using obsidian_create_note. Local filesystem is for source code, config, and tests only."
jq -n --arg reason "$REASON" '{"decision": "deny", "reason": $reason}'

#!/usr/bin/env bash
# Ralph Loop - First Principles
# The entire technique: fresh context per iteration, memory via git + files
set -euo pipefail

PROMPT_FILE="${PROMPT_FILE:-PROMPT.md}"

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: $PROMPT_FILE not found" >&2
  exit 1
fi

echo "Starting Ralph loop with $PROMPT_FILE"
echo "Press Ctrl+C to stop"
echo "---"

while :; do
  # Feed prompt to agent - fresh context each iteration
  cat "$PROMPT_FILE" | amp --print
  
  # Check for completion signal
  if grep -q '<promise>COMPLETE</promise>' progress.txt 2>/dev/null; then
    echo "---"
    echo "Ralph complete. All tasks done."
    exit 0
  fi
  
  echo "---"
  echo "Loop iteration complete. Starting fresh context..."
  sleep 2
done

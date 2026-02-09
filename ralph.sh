#!/usr/bin/env bash
# Ralph Loop - First Principles
# The entire technique: fresh context per iteration, memory via git + files
set -euo pipefail

PROMPT_FILE="${PROMPT_FILE:-PROMPT.md}"
CLI="${CLI:-claude}"
MAX_ITERATIONS="${MAX_ITERATIONS:-100}"

# Validate git repository
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Error: Not a git repository. Run 'git init' first." >&2
  exit 1
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  echo "Error: $PROMPT_FILE not found" >&2
  exit 1
fi

# Map CLI name to command
case "$CLI" in
  amp)      CLI_CMD="amp" ;;
  claude)   CLI_CMD="claude --dangerously-skip-permissions -p --no-session-persistence" ;;
  gemini)   CLI_CMD="gemini" ;;
  qwen)     CLI_CMD="qwen" ;;
  codex)    CLI_CMD="codex" ;;
  opencode) CLI_CMD="opencode" ;;
  *)        CLI_CMD="$CLI" ;;
esac

echo "Ralph loop: $CLI_CMD < $PROMPT_FILE"
echo "Max iterations: $MAX_ITERATIONS"
echo "Press Ctrl+C to stop"
echo "---"

iteration=0
while :; do
  ((iteration++))

  if [[ $iteration -gt $MAX_ITERATIONS ]]; then
    echo "---"
    echo "Error: Max iterations ($MAX_ITERATIONS) reached without completion" >&2
    exit 1
  fi

  echo "Iteration $iteration/$MAX_ITERATIONS"
  # Feed prompt to agent - fresh context each iteration
  if ! cat "$PROMPT_FILE" | eval "$CLI_CMD"; then
    echo "Error: CLI command failed" >&2
    exit 1
  fi

  # Run prek to catch errors before they get committed
  if command -v prek >/dev/null 2>&1 && [[ -f .pre-commit-config.yaml ]]; then
    echo "Running prek hooks..."
    prek run --all-files || echo "prek found issues - next iteration will fix"
  fi

  # Check for completion signal
  if grep -q '<promise>COMPLETE</promise>' progress.txt 2>/dev/null; then
    echo "---"
    echo "Ralph complete. All tasks done."
    exit 0
  fi

  echo "---"
  echo "Iteration done. Fresh context in 2s..."
  sleep 2
done

# Ralph Loop

First-principles implementation of Geoff Huntley's Ralph technique for autonomous AI coding.

[![prek](https://img.shields.io/badge/prek-enabled-blue)](https://github.com/j178/prek)

## What is Ralph?

Ralph is a bash loop that runs an AI coding agent repeatedly until all tasks are complete. Each iteration gets fresh context—memory persists via git commits and files on disk, not context window.

```bash
while :; do cat PROMPT.md | claude --dangerously-skip-permissions -p ; done
```

That's the entire technique. Everything else is scaffolding.

## Quick Start (5 minutes)

### 1. Install prek (pre-commit hooks, Rust-native)

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/j178/prek/releases/download/v0.2.30/prek-installer.sh | sh
```

### 2. Clone this repo as a template

```bash
git clone https://github.com/d33disc/ralph-loop.git my-project
cd my-project
rm -rf .git && git init
prek install
```

### 3. Write your spec

Create `specs/FEATURE_NAME.md` describing what you want built (Job to Be Done).

### 4. Customize AGENTS.md

Add your project's build/test/lint commands so Ralph knows how to validate work.

### 5. Run Ralph

```bash
./ralph.sh              # Uses claude by default
CLI=amp ./ralph.sh      # Use amp instead
```

Ralph will:

Ralph will:

1. Read PROMPT.md for instructions
2. Study specs/ and pick a task
3. Implement one task
4. Run prek hooks to catch errors
5. Commit and exit
6. Loop restarts with fresh context

## Shell Function (Optional)

Add to your `~/.zshrc` or `~/.bashrc` for convenience:

```bash
ralph() {
  cli="${1:-claude}"
  prompt="${2:-PROMPT.md}"

  if [ ! -f "$prompt" ]; then
    echo "Error: $prompt not found" >&2
    return 1
  fi

  case "$cli" in
    claude)   cli_cmd="claude --dangerously-skip-permissions -p" ;;
    amp)      cli_cmd="amp" ;;
    gemini)   cli_cmd="gemini" ;;
    *)        cli_cmd="$cli" ;;
  esac

  echo "Ralph loop: $cli_cmd < $prompt"

  while :; do
    cat "$prompt" | $cli_cmd

    if command -v prek >/dev/null 2>&1 && [ -f .pre-commit-config.yaml ]; then
      prek run --all-files || echo "prek found issues - next iteration will fix"
    fi

    if grep -q '<promise>COMPLETE</promise>' progress.txt 2>/dev/null; then
      echo "Ralph complete."
      return 0
    fi

    sleep 2
  done
}
```

Then: `ralph`, `ralph amp`, `ralph claude PROMPT_PLAN.md`

## Principles

1. **One task per iteration** - Small enough to complete in one context window
2. **Fresh context each loop** - Memory persists via git + files, not context
3. **Backpressure** - Tests/typecheck/lint + prek hooks reject bad work
4. **Eventual consistency** - Let Ralph Ralph; self-correction through iteration
5. **Study, don't assume** - Always check before concluding something isn't implemented

## Files

| File | Purpose |
| ------ | --------- |
| `ralph.sh` | The bash loop |
| `PROMPT.md` | Building mode instructions (one task → validate → commit → exit) |
| `PROMPT_PLAN.md` | Planning mode (gap analysis only, no implementation) |
| `AGENTS.md` | Project-specific commands + learnings |
| `IMPLEMENTATION_PLAN.md` | Task list (Ralph-maintained) |
| `progress.txt` | Append-only learnings across iterations |
| `specs/` | JTBD requirement docs |
| `.pre-commit-config.yaml` | prek hooks (repo: builtin for speed) |

## Two Modes

**PLANNING** (`PROMPT_FILE=PROMPT_PLAN.md ./ralph.sh`)

- Compares specs against existing code
- Generates prioritized IMPLEMENTATION_PLAN.md
- No implementation, no commits

**BUILDING** (default)

- Picks one task from IMPLEMENTATION_PLAN.md
- Implements, validates, commits
- Updates plan and progress.txt

## prek Integration

Each iteration runs `prek run --all-files` to catch errors before commit:

- Uses `repo: builtin` for instant Rust-native hooks (no network, no Python)
- Catches trailing whitespace, merge conflicts, large files, private keys
- Validates YAML/JSON/TOML syntax

## Stop Condition

When all tasks in IMPLEMENTATION_PLAN.md are complete, Ralph writes `<promise>COMPLETE</promise>` to progress.txt and the loop exits.

## References

- [ghuntley.com/ralph](https://ghuntley.com/ralph/) - Original post by Geoff Huntley
- [ghuntley/sup](https://github.com/ghuntley/sup) - Geoff's first orchestrator
- [snarktank/ralph](https://github.com/snarktank/ralph) - Ryan Carson's implementation
- [prek.j178.dev](https://prek.j178.dev/) - prek documentation

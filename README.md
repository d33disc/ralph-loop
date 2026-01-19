# Ralph Loop

First-principles implementation of Geoff Huntley's Ralph technique.

[![prek](https://img.shields.io/badge/prek-enabled-blue)](https://github.com/j178/prek)

## The Core

```bash
while :; do cat PROMPT.md | amp --print ; done
```

That's it. Everything else is scaffolding.

## Principles

1. **One task per iteration** - Small enough to complete in one context window
2. **Fresh context each loop** - Memory persists via git + files, not context
3. **Backpressure** - Tests/typecheck/lint + prek hooks reject bad work
4. **Eventual consistency** - Let Ralph Ralph; self-correction through iteration
5. **Study, don't assume** - Always check before concluding something isn't implemented

## Prerequisites

Install prek (Rust-native pre-commit, no Python required):

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/j178/prek/releases/download/v0.2.30/prek-installer.sh | sh
```

Self-update later with `prek self update`.

## Files

| File | Purpose |
|------|---------|
| `ralph.sh` | The bash loop |
| `PROMPT.md` | Instructions fed each iteration |
| `AGENTS.md` | Project-specific commands + learnings |
| `IMPLEMENTATION_PLAN.md` | Task list (Ralph-maintained) |
| `progress.txt` | Append-only learnings |
| `specs/` | JTBD requirement docs |
| `.pre-commit-config.yaml` | prek hooks (repo: builtin for speed) |

## Usage

```bash
# Make executable
chmod +x ralph.sh

# Install prek git hooks
prek install

# Add specs to specs/
# Customize AGENTS.md with your project's commands

# Run
./ralph.sh

# Or swap prompt for planning mode
PROMPT_FILE=PROMPT_PLAN.md ./ralph.sh
```

## Two Modes

- **PLANNING**: Gap analysis → generate IMPLEMENTATION_PLAN.md (no implementation)
- **BUILDING**: Pick task → implement → commit → exit

Same loop, different PROMPT.md.

## prek Integration

Each iteration runs `prek run --all-files` to catch errors before they get committed:

- Uses `repo: builtin` for instant Rust-native hooks (no network, no Python)
- Catches trailing whitespace, merge conflicts, large files, private keys
- Validates YAML/JSON/TOML syntax

## Stop Condition

When all tasks complete, Ralph writes `<promise>COMPLETE</promise>` to progress.txt and the loop exits.

## References

- [ghuntley.com/ralph](https://ghuntley.com/ralph/) - Original post
- [ghuntley/sup](https://github.com/ghuntley/sup) - Geoff's first orchestrator
- [prek.j178.dev](https://prek.j178.dev/) - prek documentation

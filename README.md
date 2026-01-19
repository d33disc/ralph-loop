# Ralph Loop

First-principles implementation of Geoff Huntley's Ralph technique.

## The Core

```bash
while :; do cat PROMPT.md | amp --print ; done
```

That's it. Everything else is scaffolding.

## Principles

1. **One task per iteration** - Small enough to complete in one context window
2. **Fresh context each loop** - Memory persists via git + files, not context
3. **Backpressure** - Tests/typecheck/lint reject bad work
4. **Eventual consistency** - Let Ralph Ralph; self-correction through iteration
5. **Study, don't assume** - Always check before concluding something isn't implemented

## Files

| File | Purpose |
|------|---------|
| `ralph.sh` | The bash loop |
| `PROMPT.md` | Instructions fed each iteration |
| `AGENTS.md` | Project-specific commands + learnings |
| `IMPLEMENTATION_PLAN.md` | Task list (Ralph-maintained) |
| `progress.txt` | Append-only learnings |
| `specs/` | JTBD requirement docs |

## Usage

```bash
# Make executable
chmod +x ralph.sh

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

## Stop Condition

When all tasks complete, Ralph writes `<promise>COMPLETE</promise>` to progress.txt and the loop exits.

## References

- [ghuntley.com/ralph](https://ghuntley.com/ralph/) - Original post
- [ghuntley/sup](https://github.com/ghuntley/sup) - Geoff's first orchestrator

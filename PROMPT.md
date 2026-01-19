# Ralph Loop Instructions

You are Ralph. You complete one task per iteration, then exit.

## Phase 1: Orient

1. Study `specs/*` to understand requirements
2. Study `IMPLEMENTATION_PLAN.md` to see current priorities
3. Study `progress.txt` for learnings from previous iterations
4. Don't assume something isn't implemented - check first

## Phase 2: Select

Pick the single most important incomplete task from `IMPLEMENTATION_PLAN.md`.

If no plan exists, create one by comparing specs against current code (gap analysis).

## Phase 3: Implement

1. Study relevant source files before changing them
2. Implement the selected task
3. Run validation: typecheck, lint, tests (see AGENTS.md for commands)
4. If validation fails, fix it in this iteration

## Phase 4: Record

1. Update `IMPLEMENTATION_PLAN.md` - mark task complete, note discoveries
2. Append learnings to `progress.txt` - capture the why
3. Update `AGENTS.md` if you learned operational details
4. Commit with clear message

## Phase 5: Exit

Exit cleanly. The loop will restart you with fresh context.

If all tasks in `IMPLEMENTATION_PLAN.md` are complete, write `<promise>COMPLETE</promise>` to progress.txt before exiting.

---

Think extra hard. One task. Done right. Then exit.

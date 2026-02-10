# Feature: Task Tracker CLI

## Job to Be Done

When I'm managing multiple tasks across different projects, I want a simple command-line tool to add, list, and mark tasks as complete, so I can stay organized without leaving my terminal.

## Success Criteria

- `task add "description"` - Add a new task
- `task list` - Show all tasks with status (pending/done)
- `task done <id>` - Mark task as complete
- `task delete <id>` - Remove a task
- Tasks persist between sessions (JSON file in `~/.tasks.json`)
- Clean, readable output with color coding
- Works on macOS and Linux

## User Stories

### Story 1: Adding Tasks

```bash
$ task add "Write README documentation"
✓ Added task #1

$ task add "Implement login feature"
✓ Added task #2
```

### Story 2: Listing Tasks

```bash
$ task list
 1 [ ] Write README documentation
 2 [ ] Implement login feature
```

### Story 3: Completing Tasks

```bash
$ task done 1
✓ Marked task #1 as done

$ task list
 1 [✓] Write README documentation
 2 [ ] Implement login feature
```

## Technical Constraints

- Single Python file (no external dependencies except stdlib)
- Executable via shebang: `#!/usr/bin/env python3`
- JSON storage in `~/.tasks.json`
- Graceful handling if file doesn't exist or is corrupted

## Out of Scope (v1)

- Task priorities or due dates
- Categories or projects
- Search functionality
- Task editing (must delete and re-add)
- Sync across devices

## Validation Commands

```bash
# Unit tests
python3 -m pytest test_task.py

# Manual testing
./task add "test task"
./task list
./task done 1
./task delete 1
```

---

**Note:** This is an example spec. Replace with your own feature using the Job to Be Done (JTBD) format. Focus on user needs, success criteria, and clear acceptance tests.

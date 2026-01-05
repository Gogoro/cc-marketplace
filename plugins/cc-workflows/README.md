# cc-workflows

Git workflow commands for Claude Code.

## Installation

```bash
/plugin add gogoro/cc-workflows
```

Or from local:
```bash
/plugin add ~/work/gogoro/cc-workflows
```

## Commands

| Command | Description |
|---------|-------------|
| `/git-add-commit-push [message]` | Add, commit, and push to current branch |
| `/git-add-commit-push-pr [message]` | Add, commit, push, and create PR to main/master |

## Usage

```bash
# Simple push to current branch
/git-add-commit-push

# With custom message
/git-add-commit-push "fix login validation"

# Push and create PR
/git-add-commit-push-pr

# With custom message
/git-add-commit-push-pr "add dark mode support"
```

## License

MIT

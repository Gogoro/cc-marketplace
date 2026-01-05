# cc-marketplace

Personal Claude Code plugin marketplace.

## Installation

```bash
/plugin marketplace add ~/work/gogoro/cc-marketplace
```

## Available Plugins

### cc-workflows

Git workflow commands for streamlined add, commit, push, and PR creation.

**Commands:**
- `/git-add-commit-push [message]` - Add, commit, and push to current branch
- `/git-add-commit-push-pr [message]` - Add, commit, push, and create PR

```bash
/plugin install cc-workflows@cc-marketplace
```

### cc-notifications

Desktop and audio notifications for Claude Code with tmux window detection and text-to-speech.

```bash
/plugin install cc-notifications@cc-marketplace
```

## Usage

After adding the marketplace, install plugins:

```bash
/plugin install <plugin-name>@cc-marketplace
```

Enable/disable plugins:

```bash
/plugin enable <plugin-name>
/plugin disable <plugin-name>
```

## License

MIT

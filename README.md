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

### cc-session-tools

Time tracking and context saving for Claude Code sessions.

**Commands:**
- `/time-report` - View time tracking report
- `/resume-session` - Resume from saved session context

**Features:**
- Automatic time tracking per project
- Full session context saved on exit
- Keep last 20 sessions for easy resume

```bash
/plugin install cc-session-tools@cc-marketplace
```

### cc-agents

Code reviewer and refactorer agents.

**Agents:**
- **Code Reviewer** - Reviews code for bugs, security issues, and best practices
- **Refactorer** - Analyzes code and suggests refactoring improvements

```bash
/plugin install cc-agents@cc-marketplace
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

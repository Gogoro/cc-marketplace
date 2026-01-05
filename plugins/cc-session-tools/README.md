# cc-session-tools

Time tracking and context saving for Claude Code sessions.

## Features

- Automatic time tracking per project
- Full session context saved on exit
- Resume previous sessions easily
- Keep last 20 session contexts (auto-cleanup)

## Installation

```bash
/plugin install cc-session-tools@cc-marketplace
```

## How It Works

### Time Tracking

On every `Stop` event (when Claude finishes responding), the plugin logs:
- Session ID
- Project name
- Duration
- Working directory

Data stored in: `~/.claude/session-data/time-tracking.log`

### Context Saving

On `SessionEnd` (when you exit Claude Code), the plugin saves:
- Full conversation transcript
- Project metadata
- End reason

Data stored in: `~/.claude/session-data/contexts/<session-id>.json`

## Commands

### /time-report

View your time tracking data:
```bash
/time-report
```

Shows recent sessions, total time per project, and statistics.

### /resume-session

Resume from a previous session:
```bash
/resume-session
```

Lists saved contexts and helps you pick up where you left off.

## Data Location

```
~/.claude/session-data/
├── time-tracking.log           # Time entries
├── sessions/                   # Active session markers
└── contexts/                   # Saved session transcripts
    └── <session-id>.json
```

## License

MIT

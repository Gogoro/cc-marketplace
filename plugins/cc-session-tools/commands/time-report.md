---
allowed-tools: Bash(cat:*), Bash(head:*), Bash(tail:*), Bash(awk:*), Bash(sort:*)
description: Show time tracking report for Claude Code sessions
---

You are a time tracking assistant. Read and display the time tracking log.

1. Check if the time tracking log exists at `~/.claude/session-data/time-tracking.log`
2. If it exists, display a formatted report showing:
   - Recent sessions (last 10 by default)
   - Total time per project
   - Summary statistics

Format the output as a clean table. The log format is:
```
TIMESTAMP | SESSION_ID | PROJECT_NAME | DURATION | CWD
```

If the user asks for a specific project or date range, filter accordingly.
If no log exists, inform the user that no time tracking data is available yet.

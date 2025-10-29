#!/bin/bash
# Hook script for Claude Code PreToolUse event
# This runs BEFORE the permission UI is shown

# Read the JSON input from stdin
INPUT=$(cat)

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define debug log location (use XDG_CACHE_HOME or fallback to /tmp)
DEBUG_LOG="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code/notification-debug.log"
mkdir -p "$(dirname "$DEBUG_LOG")"

# Log that hook was triggered
echo "$(date): PreToolUse hook triggered" >> "$DEBUG_LOG"
echo "Input: $INPUT" >> "$DEBUG_LOG"

# Extract tool name for notification
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)

# Call the core notification script with permission type
"$SCRIPT_DIR/done.sh" "Permission required for $TOOL_NAME" "permission"

echo "$(date): Sent permission notification for tool: $TOOL_NAME" >> "$DEBUG_LOG"

# Return "ask" to let the normal permission flow continue
# This allows the user to approve/deny in the UI
echo '{"permissionDecision": "ask"}'

exit 0

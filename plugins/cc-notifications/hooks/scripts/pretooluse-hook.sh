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

# Extract tool name and permission mode
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)
PERMISSION_MODE=$(echo "$INPUT" | grep -o '"permission_mode":"[^"]*"' | cut -d'"' -f4)

# Log the extracted values
echo "$(date): Tool: $TOOL_NAME, permission_mode: $PERMISSION_MODE" >> "$DEBUG_LOG"

# Determine if notification should be sent based on permission_mode and tool_name
SHOULD_NOTIFY=false

# Tools that typically require permission regardless of mode
case "$TOOL_NAME" in
    "AskUserQuestion"|"Task"|"Skill"|"SlashCommand"|"WebSearch"|"WebFetch")
        SHOULD_NOTIFY=true
        ;;
esac

# In default mode, also notify for file editing operations
# Note: Bash is excluded because it's too frequent and noisy
if [ "$PERMISSION_MODE" = "default" ]; then
    case "$TOOL_NAME" in
        "Edit"|"Write"|"NotebookEdit"|"KillShell")
            SHOULD_NOTIFY=true
            ;;
    esac
fi

# Never notify in bypassPermissions mode
if [ "$PERMISSION_MODE" = "bypassPermissions" ]; then
    SHOULD_NOTIFY=false
fi

if [ "$SHOULD_NOTIFY" = "true" ]; then
    "$SCRIPT_DIR/done.sh" "Permission required for $TOOL_NAME" "permission"
    echo "$(date): Sent permission notification for tool: $TOOL_NAME" >> "$DEBUG_LOG"
else
    echo "$(date): No notification sent (permission_mode: $PERMISSION_MODE, tool: $TOOL_NAME)" >> "$DEBUG_LOG"
fi

# Don't return a permission decision - let the user's configured settings handle it
exit 0

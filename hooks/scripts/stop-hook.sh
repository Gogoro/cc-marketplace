#!/bin/bash
# Hook script for Claude Code Stop event
# This runs when Claude finishes responding

# Read the JSON input from stdin
INPUT=$(cat)

# Extract stop_hook_active to prevent infinite loops
STOP_HOOK_ACTIVE=$(echo "$INPUT" | grep -o '"stop_hook_active":[^,}]*' | grep -o 'true\|false')

# Don't run if this was triggered by a previous stop hook
if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
    exit 0
fi

# Try to extract useful context from the JSON input
# Look for tool uses, file edits, bash commands, etc.
if echo "$INPUT" | grep -q '"name":"Edit"'; then
    MESSAGE="Edited files successfully completed"
elif echo "$INPUT" | grep -q '"name":"Write"'; then
    MESSAGE="Wrote new files successfully"
elif echo "$INPUT" | grep -q '"name":"Bash"'; then
    MESSAGE="Ran bash commands successfully"
elif echo "$INPUT" | grep -q '"name":"Read"'; then
    MESSAGE="Read files successfully completed"
elif echo "$INPUT" | grep -q '"name":"TodoWrite"'; then
    MESSAGE="Updated todo list successfully"
else
    MESSAGE="Task completed successfully now"
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call the core notification script
"$SCRIPT_DIR/done.sh" "$MESSAGE" "complete"

exit 0

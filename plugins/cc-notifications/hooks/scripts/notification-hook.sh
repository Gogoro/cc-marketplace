#!/bin/bash
# Hook script for Claude Code Notification event
# This runs when Claude is waiting for user input

# Read the JSON input from stdin
INPUT=$(cat)

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define debug log location (use XDG_CACHE_HOME or fallback to /tmp)
DEBUG_LOG="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code/notification-debug.log"
mkdir -p "$(dirname "$DEBUG_LOG")"

# Log that hook was triggered with the input
echo "$(date): Notification hook triggered" >> "$DEBUG_LOG"
echo "Input: $INPUT" >> "$DEBUG_LOG"

# Check if this is a permission request
if echo "$INPUT" | grep -qi "permission"; then
    # This is a permission request
    "$SCRIPT_DIR/done.sh" "Permission required" "permission"
    echo "$(date): Sent permission notification" >> "$DEBUG_LOG"
else
    # Regular waiting for input
    "$SCRIPT_DIR/done.sh" "Awaiting your input" "waiting"
    echo "$(date): Sent waiting notification" >> "$DEBUG_LOG"
fi

exit 0

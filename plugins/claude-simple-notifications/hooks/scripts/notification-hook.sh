#!/bin/bash
# Hook script for Claude Code Notification event
# This runs when Claude is waiting for user input

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call the core notification script with waiting type
"$SCRIPT_DIR/done.sh" "Awaiting your input" "waiting"

exit 0

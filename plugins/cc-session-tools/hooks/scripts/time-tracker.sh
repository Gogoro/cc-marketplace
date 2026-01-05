#!/bin/bash
# Time tracker hook for Claude Code
# Triggered on Stop event - logs session time per project

# Read JSON input from stdin
INPUT=$(cat)

# Extract fields
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false')

# Prevent infinite loops
if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
    exit 0
fi

# Skip if no session ID
if [ -z "$SESSION_ID" ]; then
    exit 0
fi

# Setup paths
DATA_DIR="${HOME}/.claude/session-data"
TIME_LOG="${DATA_DIR}/time-tracking.log"
SESSION_FILE="${DATA_DIR}/sessions/${SESSION_ID}.start"

mkdir -p "${DATA_DIR}/sessions"

# Get current timestamp
NOW=$(date +%s)
NOW_ISO=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Check if we have a start time for this session
if [ -f "$SESSION_FILE" ]; then
    START_TIME=$(cat "$SESSION_FILE")
    DURATION=$((NOW - START_TIME))

    # Format duration as HH:MM:SS
    HOURS=$((DURATION / 3600))
    MINUTES=$(((DURATION % 3600) / 60))
    SECONDS=$((DURATION % 60))
    DURATION_FMT=$(printf "%02d:%02d:%02d" $HOURS $MINUTES $SECONDS)

    # Get project name from CWD
    PROJECT_NAME=$(basename "$CWD")

    # Log the time entry
    echo "${NOW_ISO} | ${SESSION_ID} | ${PROJECT_NAME} | ${DURATION_FMT} | ${CWD}" >> "$TIME_LOG"
else
    # First stop in this session - record start time
    echo "$NOW" > "$SESSION_FILE"
fi

exit 0

#!/bin/bash
# Context saver hook for Claude Code
# Triggered on SessionEnd - saves full transcript for resume

# Read JSON input from stdin
INPUT=$(cat)

# Extract fields
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // empty')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
REASON=$(echo "$INPUT" | jq -r '.reason // "unknown"')

# Skip if no session ID or transcript
if [ -z "$SESSION_ID" ] || [ -z "$TRANSCRIPT_PATH" ]; then
    exit 0
fi

# Setup paths
DATA_DIR="${HOME}/.claude/session-data"
CONTEXT_DIR="${DATA_DIR}/contexts"
CONTEXT_FILE="${CONTEXT_DIR}/${SESSION_ID}.json"

mkdir -p "$CONTEXT_DIR"

# Get current timestamp
NOW_ISO=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Get project name
PROJECT_NAME=$(basename "$CWD")

# Copy transcript with metadata wrapper
if [ -f "$TRANSCRIPT_PATH" ]; then
    # Create context file with metadata and full transcript
    jq -n \
        --arg session_id "$SESSION_ID" \
        --arg saved_at "$NOW_ISO" \
        --arg cwd "$CWD" \
        --arg project "$PROJECT_NAME" \
        --arg reason "$REASON" \
        --slurpfile transcript "$TRANSCRIPT_PATH" \
        '{
            session_id: $session_id,
            saved_at: $saved_at,
            cwd: $cwd,
            project: $project,
            end_reason: $reason,
            transcript: $transcript
        }' > "$CONTEXT_FILE" 2>/dev/null

    # Keep only last 20 context files to avoid disk bloat
    ls -t "${CONTEXT_DIR}"/*.json 2>/dev/null | tail -n +21 | xargs -r rm
fi

# Clean up session start file
rm -f "${DATA_DIR}/sessions/${SESSION_ID}.start"

exit 0

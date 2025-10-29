#!/bin/bash
# Core notification script for Claude Code completion
# Usage: done.sh <message> <notification_type>
# notification_type: "complete", "waiting", or "permission"

MESSAGE="${1:-Task completed}"
TYPE="${2:-complete}"

# If MESSAGE is empty, use default
if [ -z "$MESSAGE" ]; then
    MESSAGE="Task completed"
fi

# Define debug log location (use XDG_CACHE_HOME or fallback to /tmp)
DEBUG_LOG="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code/notification-debug.log"

# Create the directory if it doesn't exist
mkdir -p "$(dirname "$DEBUG_LOG")"

# Check if we're in a tmux session
if [ -n "$TMUX" ]; then
    # Get tmux window name
    WINDOW_NAME=$(tmux display-message -p '#W')
    if [ "$TYPE" = "permission" ]; then
        NOTIFICATION_TITLE="Claude needs permission in tmux: $WINDOW_NAME"
        SPEECH_TEXT="Window $WINDOW_NAME. $MESSAGE"
    elif [ "$TYPE" = "waiting" ]; then
        NOTIFICATION_TITLE="Claude waiting in tmux: $WINDOW_NAME"
        SPEECH_TEXT="Window $WINDOW_NAME. Awaiting your input"
    else
        NOTIFICATION_TITLE="Claude Done in tmux: $WINDOW_NAME"
        SPEECH_TEXT="Window $WINDOW_NAME. $MESSAGE"
    fi
else
    if [ "$TYPE" = "permission" ]; then
        NOTIFICATION_TITLE="Claude needs permission"
        SPEECH_TEXT="$MESSAGE"
    elif [ "$TYPE" = "waiting" ]; then
        NOTIFICATION_TITLE="Claude waiting for input"
        SPEECH_TEXT="Awaiting your input"
    else
        NOTIFICATION_TITLE="Claude Done"
        SPEECH_TEXT="$MESSAGE"
    fi
fi

# Send desktop notification (popup)
# Use critical urgency for permission requests
if [ "$TYPE" = "permission" ]; then
    notify-send -u critical -i dialog-warning "$NOTIFICATION_TITLE" "$SPEECH_TEXT" 2>> "$DEBUG_LOG"
else
    notify-send -u normal -i dialog-information "$NOTIFICATION_TITLE" "$MESSAGE" 2>> "$DEBUG_LOG"
fi

# Log the notification
echo "$(date): Sent notification - Title: $NOTIFICATION_TITLE, Type: $TYPE" >> "$DEBUG_LOG"

# Play appropriate sound
if [ "$TYPE" = "permission" ] || [ "$TYPE" = "waiting" ]; then
    # Play incoming call sound for permission requests and waiting
    paplay /usr/share/sounds/freedesktop/stereo/phone-incoming-call.oga 2>> "$DEBUG_LOG" &
else
    # Play completion sound
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>> "$DEBUG_LOG" &
fi

# Speak the notification (text-to-speech)
if command -v espeak-ng &> /dev/null; then
    espeak-ng "$SPEECH_TEXT" --stdout 2>> "$DEBUG_LOG" | paplay 2>> "$DEBUG_LOG" &
elif command -v espeak &> /dev/null; then
    espeak "$SPEECH_TEXT" --stdout 2>> "$DEBUG_LOG" | paplay 2>> "$DEBUG_LOG" &
fi

exit 0

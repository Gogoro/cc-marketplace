#!/bin/bash
# Core notification script for Claude Code completion
# Usage: done.sh <message> <notification_type>
# notification_type: "complete" or "waiting"

MESSAGE="${1:-Task completed}"
TYPE="${2:-complete}"

# If MESSAGE is empty, use default
if [ -z "$MESSAGE" ]; then
    MESSAGE="Task completed"
fi

# Check if we're in a tmux session
if [ -n "$TMUX" ]; then
    # Get tmux window name
    WINDOW_NAME=$(tmux display-message -p '#W')
    if [ "$TYPE" = "waiting" ]; then
        NOTIFICATION_TITLE="Claude waiting in tmux: $WINDOW_NAME"
        SPEECH_TEXT="Window $WINDOW_NAME. Awaiting your input"
    else
        NOTIFICATION_TITLE="Claude Done in tmux: $WINDOW_NAME"
        SPEECH_TEXT="Window $WINDOW_NAME. $MESSAGE"
    fi
else
    if [ "$TYPE" = "waiting" ]; then
        NOTIFICATION_TITLE="Claude waiting for input"
        SPEECH_TEXT="Awaiting your input"
    else
        NOTIFICATION_TITLE="Claude Done"
        SPEECH_TEXT="$MESSAGE"
    fi
fi

# Send desktop notification (popup)
notify-send -u normal -i dialog-information "$NOTIFICATION_TITLE" "$MESSAGE"

# Play appropriate sound
if [ "$TYPE" = "waiting" ]; then
    # Play incoming call sound for waiting
    paplay /usr/share/sounds/freedesktop/stereo/phone-incoming-call.oga 2>/dev/null &
else
    # Play completion sound
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
fi

# Speak the notification (text-to-speech)
if command -v espeak-ng &> /dev/null; then
    espeak-ng "$SPEECH_TEXT" --stdout 2>/dev/null | paplay 2>/dev/null &
elif command -v espeak &> /dev/null; then
    espeak "$SPEECH_TEXT" --stdout 2>/dev/null | paplay 2>/dev/null &
fi

exit 0

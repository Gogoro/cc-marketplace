# cc-notifications

Desktop and audio notifications for Claude Code task completion and waiting events, with tmux window detection and text-to-speech support.

## Features

- Desktop notifications - Visual popup when Claude completes tasks, waits for input, or needs permissions
- Audio alerts - Different sounds for completion vs. waiting/permission requests
- Text-to-speech - Reads out the window name and task status
- Tmux integration - Shows which tmux window Claude is running in
- Context-aware messages - Detects what type of operation was performed
- Permission detection - Alerts you when Claude needs permission to execute a tool

## Requirements

- **Linux** with desktop notification support
- **notify-send** (usually comes with desktop environments)
- **paplay** (PulseAudio, typically pre-installed)
- **espeak-ng** or **espeak** (for text-to-speech)
- **tmux** (optional, for window detection)

### Installing Dependencies

On Arch Linux:
```bash
sudo pacman -S espeak-ng libnotify pulseaudio
```

On Ubuntu/Debian:
```bash
sudo apt install espeak-ng libnotify-bin pulseaudio-utils
```

## Installation

```bash
/plugin add gogoro/cc-notifications
```

Or from local:
```bash
/plugin add ~/work/gogoro/cc-notifications
```

## Testing

Test the notification system manually:

```bash
# Test completion notification
./hooks/scripts/done.sh "Test message" "complete"

# Test waiting notification
./hooks/scripts/done.sh "Test message" "waiting"

# Test permission notification
./hooks/scripts/done.sh "Permission required for Edit" "permission"
```

## Debugging

Debug log location: `~/.cache/claude-code/notification-debug.log`

```bash
# Watch the log in real-time
tail -f ~/.cache/claude-code/notification-debug.log
```

## License

MIT

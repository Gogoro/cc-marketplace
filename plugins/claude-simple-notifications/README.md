# Claude Simple Notifications

Desktop and audio notifications for Claude Code task completion and waiting events, with tmux window detection and text-to-speech support.

## Features

- 🔔 **Desktop notifications** - Visual popup when Claude completes tasks, waits for input, or needs permissions
- 🔊 **Audio alerts** - Different sounds for completion vs. waiting/permission requests
- 🗣️ **Text-to-speech** - Reads out the window name and task status
- 🪟 **Tmux integration** - Shows which tmux window Claude is running in
- 🎯 **Context-aware messages** - Detects what type of operation was performed (Edit, Write, Bash, etc.)
- 🔐 **Permission detection** - Alerts you when Claude needs permission to execute a tool
- 🐛 **Debug logging** - Comprehensive logging for troubleshooting notification issues

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

### Method 1: As a Claude Code Plugin (Recommended)

1. Clone this repository:
   ```bash
   cd ~/.claude/plugins  # or your preferred plugin location
   git clone https://github.com/yourusername/claude-simple-notifications.git
   ```

2. Enable the plugin in your Claude Code settings (`~/.claude/settings.json`):
   ```json
   {
     "enabledPlugins": {
       "claude-simple-notifications": true
     }
   }
   ```

3. Restart Claude Code or start a new session

### Method 2: Manual Installation

1. Clone this repository anywhere
2. Add the hooks manually to your `~/.claude/settings.json`:
   ```json
   {
     "hooks": {
       "PreToolUse": [
         {
           "matcher": ".*",
           "hooks": [
             {
               "type": "command",
               "command": "/path/to/claude-simple-notifications/hooks/scripts/pretooluse-hook.sh"
             }
           ]
         }
       ],
       "Stop": [
         {
           "hooks": [
             {
               "type": "command",
               "command": "/path/to/claude-simple-notifications/hooks/scripts/stop-hook.sh"
             }
           ]
         }
       ],
       "Notification": [
         {
           "hooks": [
             {
               "type": "command",
               "command": "/path/to/claude-simple-notifications/hooks/scripts/notification-hook.sh"
             }
           ]
         }
       ]
     }
   }
   ```

## How It Works

This plugin uses three Claude Code hooks to provide comprehensive notifications:

### PreToolUse Hook
Triggers **before** Claude shows the permission UI when it needs to use a tool. It:
- Fires immediately when any tool requires permission
- Extracts the tool name from the request
- Sends a **critical urgency** desktop notification
- Plays an alert sound (incoming call)
- Speaks the window name and permission requirement
- Returns `ask` to allow normal permission flow to continue

**Why this matters:** The PreToolUse hook ensures you get notified immediately when Claude needs permission, even before the UI is shown. This is especially useful if you're working in another window or application.

### Stop Hook
Triggers when Claude finishes responding to your request. It:
- Analyzes the JSON input to detect what tools were used
- Generates a context-aware summary (e.g., "Edited files successfully completed")
- Shows a desktop notification
- Plays a completion sound
- Speaks the window name and task summary

### Notification Hook
Triggers when Claude is waiting for your input (after 60+ seconds idle). It:
- Reads the notification input to detect if it's a permission request or idle waiting
- Detects if you're in a tmux session and which window
- Shows a desktop notification
- Plays an incoming call sound (different from completion)
- Speaks the window name and waiting message

## Customization

### Changing Sounds
Edit `hooks/scripts/done.sh` and modify these lines:
```bash
# Completion sound
paplay /usr/share/sounds/freedesktop/stereo/complete.oga

# Waiting sound
paplay /usr/share/sounds/freedesktop/stereo/phone-incoming-call.oga
```

Browse available sounds:
```bash
find /usr/share/sounds -type f -name "*.oga" -o -name "*.ogg"
```

### Disabling Text-to-Speech
If you don't want TTS, you can remove espeak-ng or modify `hooks/scripts/done.sh` to comment out:
```bash
# espeak-ng "$SPEECH_TEXT" --stdout 2>/dev/null | paplay 2>/dev/null &
```

### Custom Messages
Edit `hooks/scripts/stop-hook.sh` to customize the message detection logic. You can add more tool detections or change the messages:
```bash
if echo "$INPUT" | grep -q '"name":"YourTool"'; then
    MESSAGE="Your custom message here"
elif ...
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

## Troubleshooting

### No notifications appearing
- Check that `notify-send` works: `notify-send "Test" "Hello"`
- Ensure you have a notification daemon running (usually automatic in desktop environments)
- Check the debug log for errors (see Debugging section below)

### No sound
- Test paplay: `paplay /usr/share/sounds/freedesktop/stereo/complete.oga`
- Check PulseAudio is running: `pulseaudio --check`
- Review the debug log for audio errors

### No text-to-speech
- Test espeak: `espeak-ng "Hello world" --stdout | paplay`
- Install espeak-ng if missing
- Check debug log for TTS-related errors

### Hooks not triggering
- Check Claude Code settings: `cat ~/.claude/settings.json`
- Look for errors in Claude Code output
- Check if hooks are executable: `ls -la hooks/scripts/`
- Review the debug log (see below)

### Permission notifications not working
- The **PreToolUse hook** catches permission requests BEFORE the UI is shown
- Check the debug log to see if PreToolUse hook is being triggered
- Ensure you haven't set `bypassPermissions` mode in Claude Code settings

## Debugging

All hooks log detailed information to help troubleshoot issues:

**Debug log location:** `~/.cache/claude-code/notification-debug.log` (or `$XDG_CACHE_HOME/claude-code/notification-debug.log`)

**What's logged:**
- When each hook is triggered
- The JSON input received from Claude Code
- Which notifications were sent
- Any errors from notify-send, paplay, or espeak-ng

**Viewing the debug log:**
```bash
# View the entire log
cat ~/.cache/claude-code/notification-debug.log

# Watch the log in real-time
tail -f ~/.cache/claude-code/notification-debug.log

# View recent entries
tail -30 ~/.cache/claude-code/notification-debug.log
```

**Clearing the log:**
```bash
rm ~/.cache/claude-code/notification-debug.log
```

## License

MIT License - See [LICENSE](LICENSE) file for details

## Contributing

Contributions welcome! Please open an issue or pull request on GitHub.

## Credits

Created by Ole for use with Claude Code in tmux workflows.

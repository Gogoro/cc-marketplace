# Claude Marketplace

A collection of Claude Code plugins for enhanced productivity and workflow automation.

## Installation

### From GitHub (Recommended)

```bash
/plugin marketplace add Gogoro/claude-marketplace
```

### From Local Directory (Development)

```bash
/plugin marketplace add ~/work/gogoro/claude-marketplace
```

## Available Plugins

### 🔔 claude-simple-notifications

Desktop and audio notifications for Claude Code task completion and waiting events.

**Features:**
- Desktop notifications with tmux window detection
- Audio alerts (different sounds for completion vs. waiting)
- Text-to-speech support
- Context-aware messages based on tool usage

**Installation:**
```bash
/plugin install claude-simple-notifications@claude-marketplace
```

**Documentation:** [plugins/claude-simple-notifications/README.md](plugins/claude-simple-notifications/README.md)

## Usage

After adding the marketplace, browse available plugins:

```bash
/plugin
```

Install any plugin:

```bash
/plugin install <plugin-name>@claude-marketplace
```

Enable/disable plugins:

```bash
/plugin enable <plugin-name>
/plugin disable <plugin-name>
```

## Development

### Adding a New Plugin

1. Create a new directory under `plugins/`
2. Add the plugin structure with `.claude-plugin/plugin.json`
3. Update `.claude-plugin/marketplace.json` to reference the new plugin
4. Commit and push changes

### Local Testing

For local development, add the marketplace from your working directory:

```bash
/plugin marketplace add ~/work/gogoro/claude-marketplace
```

After making changes to a plugin, reinstall it to test:

```bash
/plugin uninstall <plugin-name>
/plugin install <plugin-name>@claude-marketplace
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add your plugin or improvements
4. Submit a pull request

## License

MIT License - See [LICENSE](LICENSE) file for details.

## Repository

GitHub: [https://github.com/Gogoro/claude-marketplace](https://github.com/Gogoro/claude-marketplace)

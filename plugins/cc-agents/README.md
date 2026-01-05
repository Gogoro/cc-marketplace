# cc-agents

Code reviewer and refactorer agents for Claude Code.

## Installation

```bash
/plugin install cc-agents@cc-marketplace
```

## Agents

### Code Reviewer

Reviews code for bugs, security issues, and best practices.

**Invoke with:**
```
Review the staged changes
Review src/auth.ts for security issues
Check this file for bugs
```

**Checks for:**
- Bugs and logic errors
- Security vulnerabilities
- Code quality issues
- Performance problems

### Refactorer

Analyzes code and suggests refactoring improvements.

**Invoke with:**
```
What refactoring opportunities are in this file?
Help me simplify this function
Extract common code into a reusable function
```

**Suggests:**
- Extract method/function
- Simplify conditionals
- Improve naming
- Reduce complexity
- Data structure improvements

## Usage

The agents are automatically available when you install the plugin. Claude will invoke them when appropriate based on your request, or you can explicitly ask for a review or refactoring analysis.

## License

MIT

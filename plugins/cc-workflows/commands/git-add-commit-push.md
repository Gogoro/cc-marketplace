---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git log:*), Bash(git pull:*), Bash(git push:*), Bash(git diff:*)
argument-hint: [message]
description: Add files, commit changes, and push to current branch
---

You are a git expert. Perform the following steps:

1. Run `git status` to see what files have changed
2. Run `git diff` to review the changes
3. Read the recent commit log to understand the commit message style
4. Add all changed files with `git add -A`
5. Commit with a short, concise message summarizing the changes. If the user provided a message argument, use that instead.
6. Pull latest changes with `git pull --rebase`
7. Push to the current branch

Important:

- Never add yourself as author or co-author
- Never add "Generated with Claude Code" or similar attribution
- Keep commit messages short (one line when possible)
- If there are conflicts or errors, ask for help
- Tell me when done

---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git log:*), Bash(git pull:*), Bash(git push:*), Bash(git diff:*), Bash(git branch:*), Bash(git remote:*), Bash(gh pr create:*), Bash(gh pr view:*)
argument-hint: [message]
description: Add files, commit changes, push to current branch, and create a PR
---

You are a git expert. Perform the following steps:

1. Run `git status` to see what files have changed
2. Run `git diff` to review the changes
3. Read the recent commit log to understand the commit message style
4. Add all changed files with `git add -A`
5. Commit with a short, concise message summarizing the changes. If the user provided a message argument, use that instead.
6. Pull latest changes with `git pull --rebase`
7. Push to the current branch with `git push -u origin HEAD`
8. Check if there is a main or master branch in the remote repo
9. If there is a main/master branch, create a pull request using `gh pr create`:
   - Use the commit message as the PR title
   - Write a short description of what changed in the PR body
   - Do not add any attribution or mention of AI
10. If there is no main/master branch, skip PR creation

Important:
- Never add yourself as author or co-author
- Never add "Generated with Claude Code" or similar attribution
- Keep commit messages and PR titles short
- If there are conflicts or errors, ask for help
- Tell me when done and provide the PR URL if created

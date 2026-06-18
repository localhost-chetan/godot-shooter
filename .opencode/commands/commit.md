---
description: Stage all + commit with caveman-commit style
agent: build
---

Use caveman-commit skill on current working tree changes:

1. Run `git status` and `git diff` to inspect changes
2. Generate commit message per caveman-commit rules: Conventional Commits, imperative mood, ≤50 char subject, body only for non-obvious why
3. Stage all changes with `git add -A`
4. Commit using `git commit` with the generated message
5. Do NOT modify any files. Do NOT push.

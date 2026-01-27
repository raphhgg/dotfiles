---
argument-hint: [pr-number]
description: Review a pull request
allowed-tools: Bash(gh:*), Read, Grep, Glob
---

Review PR #$1:

1. Fetch PR details using `gh pr view $1`
2. Get the diff with `gh pr diff $1`
3. Analyze for:
   - Security vulnerabilities
   - Performance issues
   - Code style violations
   - Missing tests
4. Provide actionable feedback
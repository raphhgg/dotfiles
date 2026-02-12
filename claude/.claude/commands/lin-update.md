---
description: Update a Linear issue after completion
argument-hint: <issue identifier>
allowed-tools: Bash(curl:*), Bash(grep:*), Bash(cut:*), Bash(python3:*)
---

## Linear Configuration
- **API Key**: Load from secrets file (NEVER hardcode)

## API Key Loading
LINEAR_KEY=$(grep LINEAR_API_KEY ~/.claude/.secrets | cut -d'=' -f2)

## Task
Update Linear issue: $ARGUMENTS

## Workflow
1. First fetch the current issue state via GraphQL query
2. Show the user the current title, description, status, and labels
3. Draft the updated description following the formatting rules below
4. Show the update to the user and wait for confirmation
5. Execute the updateIssue mutation

## Formatting Rules
- Use `## ✅ Implemented Solution` for what was done
- Use `## 🔮 Future Enhancements (Optional)` for future work
- Do NOT use `<details>/<summary>` tags (Linear doesn't render them)
- Use `---` horizontal rules to separate major sections
- Use consistent heading levels (### for subsections)

## API Call (GraphQL mutation)
Use curl to POST to https://api.linear.app/graphql with:
- Authorization header using $LINEAR_KEY
- updateIssue mutation with issueId and updated description
- Parse response with python3 -m json.tool

---
description: Create a Linear issue with full detailed plan
argument-hint: <issue title or description>
allowed-tools: Bash(curl:*), Bash(grep:*), Bash(cut:*), Bash(python3:*)
---

## Linear Configuration
- **Team ID**: 9bbf50c0-425a-4736-b5ac-fb98744a5830
- **Default Project ID** (self-hosted): 91189c04-ae99-46dc-bf34-243cb9f95fb6
- **API Key**: Load from secrets file (NEVER hardcode)

## API Key Loading
LINEAR_KEY=$(grep LINEAR_API_KEY ~/.claude/.secrets | cut -d'=' -f2)

## Task
Create a Linear issue based on: $ARGUMENTS

## Workflow
1. Draft the issue with a FULL detailed plan (never summarize)
2. Propose priority (Urgent/High/Normal/Low) and ask for confirmation
3. Propose labels — suggest labels based on context
4. Wait for user confirmation before making the API call
5. Always assign to `raphaelgrau`

## API Call (GraphQL mutation)
Use curl to POST to https://api.linear.app/graphql with:
- Authorization header using $LINEAR_KEY
- createIssue mutation with teamId, title, description, priority, projectId, labels
- Parse response with python3 -m json.tool

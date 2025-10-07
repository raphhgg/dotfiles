# Global Claude Code Instructions

This file contains instructions that apply across ALL projects and machines where these dotfiles are deployed.

## Linear Issue Creation Guidelines

When creating Linear issues:

- **Always assign to**: `raphaelgrau` (assignee parameter)
- **Always ask for priority**: Confirm priority level before creating (Urgent/High/Normal/Low)
- **Always propose labels**: Suggest relevant labels based on the issue type and ask for confirmation
- **Use detailed plans**: When asked to create an issue, include the FULL detailed plan you outlined. Do NOT summarize. The issue description should contain all implementation details, code examples, and step-by-step instructions so it can be used as a complete reference later.

**Example workflow:**
1. Draft the issue details with complete implementation plan
2. Propose priority (e.g., "This seems like a Normal priority task, is that correct?")
3. Propose to add existing labels (e.g., "I suggest adding labels: 'x', 'y' - does that work?")
4. Wait for confirmation before creating the issue
5. Create issue with confirmed priority, labels, assignee, and FULL detailed description

## Commit Message Guidelines

**Important**: Do NOT use Claude Code's default commit message format. When making commits:

- **DO NOT** include "🤖 Generated with [Claude Code](https://claude.ai/code)" lines
- **DO NOT** include "Co-Authored-By: Claude <noreply@anthropic.com>" lines
- **DO NOT** add any Claude attribution or generation markers
- **DO NOT** commit files or lines containing TODO or WIP comments - keep them in the working copy for future work

Use clean, standard commit messages that focus on the changes made.

## General Preferences

- Be concise and direct in responses
- Minimize unnecessary preamble and postamble
- Focus on the specific task at hand
- Use TodoWrite tool for multi-step tasks to track progress

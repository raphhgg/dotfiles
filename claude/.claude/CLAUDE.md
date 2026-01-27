# Global Claude Code Instructions

This file contains instructions that apply across ALL projects and machines where these dotfiles are deployed.

## Linear Issue Management Guidelines

### Creating Issues

When creating Linear issues:

- **Always assign to**: `raphaelgrau` (assignee parameter)
- **Always ask for priority**: Confirm priority level before creating (Urgent/High/Normal/Low)
- **Always propose labels**: Suggest relevant labels based on the issue type and ask for confirmation. By default, you can add a `Claude` label so I know this is an issue you created.
- **Use detailed plans**: When asked to create an issue, include the FULL detailed plan you outlined. Do NOT summarize. The issue description should contain all implementation details, code examples, and step-by-step instructions so it can be used as a complete reference later.

**Example workflow:**
1. Draft the issue details with complete implementation plan
2. Propose priority (e.g., "This seems like a Normal priority task, is that correct?")
3. Propose to add existing labels (e.g., "I suggest adding labels: 'x', 'y' - does that work?")
4. Wait for confirmation before creating the issue
5. Create issue with confirmed priority, labels, assignee, and FULL detailed description

### Updating Completed Issues

When updating an issue after completion:

- **Use clear section structure**: Organize with main sections at the same level (##)
- **Implemented Solution section**: Use "## ✅ Implemented Solution" for what was done
- **Future Enhancements section**: Use "## 🔮 Future Enhancements (Optional)" for what could be added later
- **Don't use collapsible details**: Linear doesn't render `<details>/<summary>` tags - use regular Markdown headings instead
- **Use horizontal rules**: Separate major sections with `---` for visual clarity
- **Keep hierarchy clear**: Use consistent heading levels (###) for subsections


## General Preferences

- Be concise and direct in responses
- Minimize unnecessary preamble and postamble
- Focus on the specific task at hand
- Use TodoWrite tool for multi-step tasks to track progress

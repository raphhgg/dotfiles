---
name: gemini
description: Ask a question to Google's Gemini AI using the Gemini CLI
argument-hint: <your question or prompt>
disable-model-invocation: true
allowed-tools: Bash(gemini:*)
---

## Task
Run the Gemini CLI to ask the following question and display the response:

```
export NODE_OPTIONS="--no-deprecation" gemini -m gemini-3-pro-preview -p "$ARGUMENTS"
```

If the command fails:
- If gemini is not found, tell the user to install it: `npm install -g @google/gemini-cli`
- If authentication fails, tell the user to run `gemini` interactively first to authenticate, or set `GOOGLE_API_KEY`

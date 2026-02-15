---
name: gemini
description: Chat with Google Gemini via gemini-cli from within Claude Code or OpenCode. Maintains conversation continuity using --resume. Use when the user wants to ask Gemini something, have a multi-turn conversation with Gemini, compare answers with Gemini, or delegate a task to Gemini.
argument-hint: <your prompt>
disable-model-invocation: true
allowed-tools: Bash(gemini:*)
---

# Gemini Chat Skill

Chat with Google Gemini from Claude Code or OpenCode with full conversation continuity.

## Setup (run once at start of every invocation)

You MUST prefix every command with the PATH export, or resolve the gemini binary path first.

```bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH" && gemini --version
```

If `gemini` is still not found, search for it:
```bash
find /opt/homebrew /usr/local ~/.npm-global -name "gemini" -type f 2>/dev/null | head -1
```

Then use the resolved full path in all subsequent commands.

## How to Send Messages

### First message (or new conversation)
```bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH" && gemini -m gemini-3-pro-preview -p $ARGUMENTS --output-format json --yolo 2>/dev/null
```

### Follow-up messages (continue conversation)
```bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH" && gemini -m gemini-3-pro-preview --resume latest -p $ARGUMENTS --output-format json --yolo 2>/dev/null
```

That's it. `--resume latest` loads the previous session so Gemini has full context.

## When to Use Which

- **User's first Gemini request in this session**, or user says "new Gemini chat" → send **without** `--resume`
- **Any follow-up** (user continues the topic, says "ask Gemini to elaborate", etc.) → send **with** `--resume latest`
- If `--resume latest` fails → fall back to sending without it (new session)

## Parsing the Response

JSON output structure:
```json
{
  "response": "Gemini's answer here",
  "stats": { "models": {}, "tools": {} }
}
```

Extract `.response` with:
```bash
echo "$OUTPUT" | jq -r '.response'
```

If JSON parsing fails, present the raw output — gemini-cli sometimes outputs plain text despite the flag.

## Presenting Responses

- Present Gemini's exact response from the json output. 
- **DO NOT** paraphrase, summarize or simplify its response.
- If running in OpenCode, let it format the mardown table using the `opencode-md-table-formatter` plugin (use OpenCode's `experimental.text.complete` hook)

```
🟦 **Gemini:**

[response content]
```


## Flags Reference

| Flag | Purpose |
|---|---|
| `-p "msg"` | Pass prompt in headless mode (MUST use this, not positional args, especially with --resume) |
| `--resume latest` | Continue most recent session |
| `--resume <N or UUID>` | Resume a specific session |
| `--output-format json` | Structured output for parsing |
| `--yolo` | Auto-approve tool calls (prevents hanging) |
| `-m <model>` | Use specific model (e.g., `gemini-2.5-pro`, `gemini-2.5-flash`) |
| `--list-sessions` | Show available sessions |

## Important Details

1. **Always export PATH first** — Prefix every gemini call with `export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH"`.
2. **Always use `-p` for the prompt** — positional args and stdin don't work with `--resume` (known gemini-cli bug).
3. **Always use `--yolo`** — without it, headless mode hangs waiting for tool approval.
5. **Redirect stderr** with `2>/dev/null` — suppresses UI noise.
6. **Escape messages carefully** — for messages with quotes or special chars, use a heredoc:
   ```bash
   export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH" && gemini --resume latest -p "$(cat <<'GEMINI_PROMPT'
   Message with "quotes" and $special chars
   GEMINI_PROMPT
   )" --output-format json --yolo 2>/dev/null
   ```
7. **Model selection** — if the user asks for a specific model, pass `-m model-name`.

## User Intent Mapping

| User says | Action |
|---|---|
| "Ask Gemini …" / "Gemini: …" / "Send to Gemini: …" | Send message (new or continue as appropriate) |
| "Start new Gemini chat" / "Fresh Gemini conversation" | Send without `--resume` |
| "What does Gemini think about …" (follow-up context) | Send with `--resume latest` |
| "List Gemini sessions" | `gemini --list-sessions` |
| "Use Gemini Pro for this" | Add `-m gemini-2.5-pro` |

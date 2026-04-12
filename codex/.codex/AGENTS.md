# AGENTS.md

This file defines my global Codex defaults. It applies across repos and makes the shared harness available by default.

## Global Working Agreements

- Be concise, direct, and specific.
- Prefer repo-local truth over assumptions.
- Surface weak reasoning plainly; do not rubber-stamp bad decisions.
- Do not expose secrets, tokens, API keys, or raw auth payloads in output, logs, commits, or UI.
- Before any commit, verify staged changes do not include secrets or env files.
- Prefer `rg` for search and keep shell work non-destructive unless explicitly requested.

## Shared Harness Policy

- The shared harness lives at `$HOME/agent-standards`.
- For engineering work, load `$HOME/agent-standards/AGENTS.md` as the shared standards entrypoint unless the current repo explicitly opts out.
- Treat the harness as reusable workflow and standards guidance, not as product truth.
- When shared standards conflict with repo-local product docs, repo-local product docs win.
- Do not assume `$HOME` in prose will be expanded automatically by tools; resolve it first when executing commands.

## Expected Layering

1. Start with this global file.
2. Read the current repo's local `AGENTS.md` if it exists.
3. Use `$HOME/agent-standards/AGENTS.md` for shared routing, skills, and reusable standards.
4. Read product-local truth such as `docs/BOOTSTRAP.md`, PRDs, plans, or `ARCHITECTURE.md`.
5. Load only the minimum deeper docs needed to complete the task.

## Hard Rules

- Keep product-specific doctrine out of the global layer.
- Keep personal defaults out of product repos unless the repo explicitly needs them.
- If a repo has no local `AGENTS.md`, the harness may still be used, but product facts must come from repo-local docs or code, not from the harness.

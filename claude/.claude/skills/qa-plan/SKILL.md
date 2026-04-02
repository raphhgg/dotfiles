---
name: qa-plan
description: Create a QA plan for a PR or issue slice. Use when the user wants a concise list of behaviors, use cases, and regressions that must be exercised before shipping.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the issue, PR description, and local product docs that define the claimed behavior change.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/qa-plans.md`.
5. Load `docs/capabilities/pull-requests.md` when the plan is meant to live in a PR or PR comment.
6. Load `docs/capabilities/testing-and-quality.md` when automated verification already performed affects what still needs manual or staged QA.

# QA Plan

## Workflow

1. Identify the primary slice, user story, or acceptance target.
2. Extract the observable behaviors the PR claims to change.
3. Turn those behaviors into concise core acceptance checks.
4. Add the nearby regressions and edge cases that are most likely to fail.
5. Include any setup, data, role, or environment prerequisites needed to run the plan.
6. When a check depends on a sample webhook, API call, CLI invocation, or startup command, include the exact sample input and exact executable command.
7. State what is explicitly out of scope when that prevents wasted testing.
8. Format the result so it can be placed inline in a PR or linked as a compact artifact.

## Working rules

- Ground the plan in issue intent and acceptance criteria.
- Prefer behavior and use-case language over implementation language.
- Keep it concise enough that a human will actually execute it.
- Do not make the reviewer reverse-engineer sample payloads, startup commands, or local setup from code when the plan depends on them.
- If no separate QA plan is justified, say so directly.
- Do not confuse this with bug intake or root-cause triage.

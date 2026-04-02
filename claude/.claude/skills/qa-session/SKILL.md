---
name: qa-session
description: Run a conversational QA session and turn observed behavior problems into durable issues. Use when the user wants to report bugs, do QA, or file issues from testing findings.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the local product docs that define the feature or workflow being tested when they exist.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/qa-sessions.md`.
5. Load `docs/capabilities/testing-and-quality.md` when testability, missing coverage, or verification gaps shape the QA discussion.
6. Load `docs/capabilities/repo-strategy.md` when it is unclear whether findings should be filed in the current repo or somewhere else.

# QA Session

## Workflow

1. Let the user report the problem in their own words.
2. Ask only the minimum clarifying questions needed to capture expected behavior, actual behavior, and reproduction steps.
3. Read local product truth and inspect the relevant area in the background to understand domain language and the intended behavior boundary.
4. Decide whether the report is one issue or multiple thin issues.
5. File durable issues when the environment supports it. Otherwise produce issue-ready drafts.
6. After filing or drafting, summarize the created issues and ask whether there is another finding to capture.

## Working rules

- Keep the conversation behavior-first.
- Do not widen this into implementation or root-cause fixing unless the user asks.
- Prefer many thin issues over one thick issue when the failures are separable.
- Write issues so they survive refactors.
- Use product language, not file names or internal module names.

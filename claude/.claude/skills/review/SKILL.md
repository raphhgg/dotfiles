---
name: review
description: Review a working tree, diff, or proposed change against repo-local truth and the shared quality bar, with findings first. Use when the user wants code review, risk review, regression spotting, or missing-test analysis.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
3. Load `docs/capabilities/testing-and-quality.md`.
4. Load `docs/capabilities/backend-boundaries.md` when architecture or code placement matters.

Review the change with a bias toward:

- correctness
- regressions
- missing tests
- boundary violations
- mismatch with documented repo rules

If runtime shape or operator behavior is part of the risk, load the relevant shape or deployment doc instead of guessing.

Working rules:

- Findings come first, ordered by severity.
- Focus on behavior and quality risks, not stylistic trivia.
- For backend API or handler changes, explicitly check whether tests cover the main response outcomes rather than only the happy path.
- Review the proposed behavior; do not widen this skill into test execution or code mutation.
- If there are no findings, say that directly and note any residual risks or testing gaps.

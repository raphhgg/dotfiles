---
name: triage-issue
description: Investigate a reported bug or behavior problem, identify likely root cause, and produce a fix-oriented issue with a TDD plan. Use when the user wants diagnosis and implementation planning before coding.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the local product docs that define the feature or workflow under discussion when they exist.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/triage-issues.md`.
5. Load `docs/capabilities/testing-and-quality.md`.
6. Load `docs/capabilities/backend-boundaries.md` when affected seams, modules, or adapters matter.

# Triage Issue

## Workflow

1. Capture the reported problem in plain language.
2. Ask only the minimum question needed if the report is too vague to investigate.
3. Inspect the relevant code, tests, and nearby patterns to find where the bug manifests and why it likely fails.
4. Identify the likely root cause, the smallest credible fix path, and the behaviors that must be verified.
5. Decide whether the result should be one issue or multiple thin issues.
6. Produce a durable issue or issue-ready draft with a concise TDD-oriented fix plan.

## Working rules

- Investigate first, then write.
- Do not over-interview the user before inspecting the codebase.
- Do not jump into implementation unless the user asks.
- Separate symptom, likely root cause, and fix plan clearly.
- Aim to produce a handoff that a later `tdd` pass can execute cleanly.

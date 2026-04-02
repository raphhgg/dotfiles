---
name: handoff-issue
description: Close a completed code-bearing issue with verification, feedback capture, commit/push, and a reviewable PR plus initial harness feedback. Use when an implemented slice should be handed off end to end.
---

Routing note:

- Use this skill when a code-bearing issue has been implemented and should be closed out for review.
- Use it as the default follow-on from `tdd` unless the user explicitly defers PR handoff or local repo rules define a different workflow.
- Do not use it for implementation itself, review-only work, or PR-body drafting when the branch is already otherwise ready and only packaging is needed.

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the issue, ticket, or local task description being handed off.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/pull-requests.md`.
5. Load `docs/capabilities/agent-feedback-and-observability.md`.
6. Load `docs/capabilities/testing-and-quality.md` when verification claims or gaps need interpretation.
7. Load `docs/capabilities/backend-boundaries.md` when architectural risk or boundary changes need explanation.
8. When the repo uses the `harness-feedback` merge gate, load `docs/integration/harness-feedback.md` and use `docs/integration/templates/HARNESS_FEEDBACK_COMMENT.template.md`.

# Handoff Issue

## Workflow

1. Inspect the current branch, diff, changed files, issue context, and verification that actually ran.
2. Confirm the branch still represents one reviewable slice with one primary issue.
3. Run the feedback checkpoint and update local feedback or product docs when the work uncovered reusable mistakes, friction, or stable facts.
4. Decide whether the lesson is repo-specific or reusable across products, and update shared standards only when the conclusion is genuinely reusable.
5. Stage and commit the implementation slice with a message that matches the issue outcome.
6. Push the branch.
7. Draft the PR title and body using repo-local conventions when they exist; otherwise follow the shared PR contract.
8. Post or update the canonical `harness-feedback` PR comment using `docs/integration/templates/HARNESS_FEEDBACK_COMMENT.template.md`.
9. Use `pending-harness-issue` when the reusable lesson is clear but the shared issue should be filed only during final PR closeout.
10. Include the verification actually performed, plus any explicit remaining QA plan, known gaps, or follow-ups.
11. If the slice has no direct manual QA path yet, say that explicitly in `QA Plan` and explain why.
12. If the repo supports PR labels and the slice has no direct manual QA path, add a `no-qa` label.
13. If the QA plan depends on sample inputs, startup commands, or local setup, include the exact payloads, commands, and file prerequisites needed to execute it.
14. Apply canonical repo-local workflow instructions for branch naming and draft-versus-ready behavior before shared defaults.

Working rules:

- One primary issue per branch and PR.
- Do not invent verification, feedback, or risks.
- Do not skip the feedback checkpoint just because the code is green.
- Do not mark a code-bearing PR ready until the required `harness-feedback` comment exists.
- Do not create a shared harness issue during handoff unless the reusable lesson has already been fixed directly as `harness-change`.
- Do not scatter multiple competing `harness-feedback` comments across the same PR. Update the existing canonical comment instead.
- Do not open a ready PR when verification is knowingly partial.
- Do not blur already-run verification with remaining QA work.
- Do not hide that a slice is not manually QA-able yet; call it out in the PR handoff.
- Do not leave manual QA plans underspecified when exact sample input or repo-local command shape is required to run them.
- Do not put shared-harness process limitations or GitHub-plan caveats into the product PR body unless they directly affect slice-specific review or ship risk.
- If the branch contains unrelated work, stop and separate it before handoff.
- If the user explicitly wants only PR packaging, use `create-pr` instead.
- If repo-local workflow instructions conflict with shared defaults for branch naming or PR readiness, local instructions win.

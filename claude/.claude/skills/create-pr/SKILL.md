---
name: create-pr
description: Package an already-prepared branch into a reviewable pull request using the shared PR contract. Use when only the PR artifact is needed rather than full issue closeout.
---

Routing note:

- Use this skill when the task is specifically to draft, open, or refine a pull request from work that is already otherwise ready for handoff.
- Do not use it as the default closeout path for implemented code-bearing issues. Use `handoff-issue` for that stronger end-to-end workflow.
- Do not use it for code review, planning, or implementation itself.
- Treat repo-local PR rules as higher priority than this skill.

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the issue, ticket, or local task description that the PR is meant to satisfy.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/pull-requests.md`.
5. Load `docs/capabilities/testing-and-quality.md` when verification claims or gaps need interpretation.
6. Load `docs/capabilities/backend-boundaries.md` when architectural risk or boundary changes need explanation.

# Create Pull Request

## Workflow

1. Inspect the current branch, diff, changed files, and issue context.
2. Identify one primary issue and check whether the branch is a reviewable single slice.
3. If unrelated work is mixed in, stop and call that out before drafting the PR.
4. Draft the PR title and body using repo-local conventions when they exist; otherwise follow the shared PR contract.
5. Summarize the behavior change, the verification actually performed, and any known risks or follow-ups.
6. Include or link a short QA plan only for the remaining manual, integration, migration, or release testing that still needs to happen. Use `qa-plan` when a dedicated plan artifact is needed.
7. If the slice has no direct manual QA path yet, say that explicitly in `QA Plan` and explain why.
8. If the repo supports PR labels and the slice has no direct manual QA path, add a `no-qa` label.
9. If the QA plan depends on sample inputs, startup commands, or local setup, include the exact payloads, commands, and file prerequisites needed to execute it.
10. Decide whether the PR should be draft or ready from canonical repo-local workflow instructions before shared defaults.
11. Open or hand off the PR only if the user asked for that step.

Working rules:

- One primary issue per PR.
- Do not invent verification.
- Do not blur already-run verification with remaining QA work.
- Do not imply that manual QA is merely pending when the slice is not directly QA-able yet; say so explicitly.
- Do not leave manual QA steps underspecified when the reviewer needs exact commands, sample inputs, or setup instructions to run them.
- Do not turn the PR body into a file-by-file changelog or agent diary.
- Do not put shared-harness process limitations or GitHub-plan caveats into the product PR body unless they directly affect slice-specific review or ship risk.
- If the issue is too large to yield a reviewable PR, say so directly.
- If the task also needs commit, push, or feedback capture, route to `handoff-issue` instead of silently doing half the workflow.
- If repo-local rules conflict with this workflow, local rules win.

---
name: merge-pr
description: Close out a reviewed pull request with final QA confirmation, final harness-feedback updates, merge, and post-merge cleanup. Use when a PR is ready to be merged rather than handed off for review.
---

Routing note:

- Use this skill when a pull request has already been reviewed and should be finalized for merge.
- Use it after `handoff-issue`, review, comment resolution, and QA are complete or explicitly confirmed complete.
- Do not use it for implementation, PR handoff, or review posting.

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the pull request, issue, or local task being closed out.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/pull-requests.md`.
5. Load `docs/integration/harness-feedback.md` when the repo uses the `harness-feedback` merge gate.

# Merge Pull Request

## Workflow

1. Inspect the PR state, current `harness-feedback` comment, review threads, and QA evidence.
2. Confirm unresolved actionable review threads are cleared, except scope the user explicitly wants ignored.
3. Confirm QA is complete.
   - If QA cannot be verified from the environment, require explicit user confirmation instead of inventing it.
4. Revisit the canonical `harness-feedback` comment and update it if review or QA surfaced new reusable lessons.
5. If the final reusable outcome is `pending-harness-issue`, create the `agent-standards` issue from the comment, then update the comment to `harness-issue` with the real issue URL.
   - Keep `Target Files` readable: use repo-relative labels with links, and split product-repo vs harness-repo targets when both are relevant.
6. Merge the PR.
   - Repo-local merge strategy wins.
   - If no repo-local merge strategy is documented, default to squash merge.
7. Perform local cleanup by default:
   - switch to `main`
   - pull updated `main`
   - delete the merged feature branch unless the user explicitly wants to keep it

Working rules:

- Do not merge with unresolved actionable review threads.
- Do not merge with knowingly incomplete QA unless the user explicitly accepts the risk.
- Do not create a harness issue after merge; create it immediately before merge so the merged PR already carries the final reference.
- Do not post duplicate `harness-feedback` comments; always update the canonical one.

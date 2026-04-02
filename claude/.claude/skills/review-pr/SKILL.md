---
name: review-pr
description: Review a pull request and post concrete findings as GitHub review comments. Use when the user wants durable PR-native review findings instead of a chat-only review.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
3. Load `docs/capabilities/testing-and-quality.md`.
4. Load `docs/capabilities/pull-requests.md`.
5. Load `docs/capabilities/backend-boundaries.md` when architecture or code placement matters.

# Review Pull Request

Use this skill when review findings should be posted onto a GitHub pull request as durable review comments.

## Workflow

1. Resolve the repository, PR number, and review target commit.
2. Inspect the PR diff and local product truth needed to review the claimed behavior.
3. Produce findings with the same review bar as `review`: correctness, regressions, missing tests, boundary violations, and mismatch with repo rules.
4. Filter to concrete, actionable findings only. Do not post speculative concerns, style trivia, or low-signal noise.
5. Convert each finding into either:
   - an inline file comment with a tight file and line anchor when the problem is localizable
   - a top-level review summary only when the finding cannot be anchored cleanly
6. Post the GitHub review with `github_add_review_to_pr`, using `COMMENT` by default.
   - Prefer `file_comments` entries with `path`, `line`, `side: RIGHT`, and `body` for concrete anchored findings.
   - Use the top-level `review` body for cross-cutting findings that cannot be attached cleanly to one file and line.
7. Use `REQUEST_CHANGES` only when the user explicitly asks for a blocking review or the repo clearly expects blocking agent reviews.
8. Return a chat summary of what was posted, with findings first.

## Working rules

- Keep `review` as the read-only default. Use this skill only when the write action is explicitly desired.
- Post one finding per inline review comment.
- Keep comments behavior-focused and concise.
- Prefer exact file and line anchors over vague top-level comments.
- If there are no findings, say so directly and do not post a noisy review unless the user explicitly asks for an approval or status comment.
- Do not widen this skill into code changes, thread resolution, or comment replies.
- Use `gh-address-comments` when the task is to consume existing PR feedback and implement fixes.

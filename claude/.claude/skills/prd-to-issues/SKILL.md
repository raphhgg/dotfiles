---
name: prd-to-issues
description: Break an approved PRD and implementation plan into independently grabbable execution issues using thin vertical slices. Use when the user wants to create implementation tickets, convert a PRD or plan into issues, or prepare issue-by-issue delivery.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the product PRD or equivalent local spec, plus the approved implementation plan when one exists.
3. Read `docs/ARCHITECTURE.md` when it exists so issue slices follow the current structural truth.
4. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
5. Load one relevant shape doc.
6. Load `docs/capabilities/backend-boundaries.md`.

Break a PRD into independently-grabbable GitHub issues using tracer-bullet vertical slices.

## Workflow

1. Use the implementation plan as the primary slicing input when it exists.
   - Preserve plan slice ordering unless there is a clear local reason to change it.
   - If the plan conflicts with `docs/ARCHITECTURE.md` on stable structure, architecture wins and the mismatch should be surfaced.
   - If the plan calls out architecture checkpoint candidates, preserve them instead of silently dropping them.
2. Build a coverage pass before writing or editing issues.
   - List the plan slices or phases that need issue coverage.
   - Confirm whether each slice is fully covered, partially covered, or intentionally deferred.
   - Do not leave a whole plan slice uncovered by accident.
   - Confirm whether each planned architecture checkpoint is already represented as a dedicated issue, intentionally deferred, or missing.
3. Draft or revise issues as thin vertical slices.
   - Each issue should prove one narrow end-to-end behavior through the relevant layers.
   - Prefer revising existing issues over creating duplicates when a tracker already exists.
   - Architecture checkpoints should become dedicated issues rather than hidden notes.
4. For each issue, include:
   - the relevant parent PRD or plan slice
   - what to build
   - concrete acceptance criteria
   - verification notes
   - explicit dependencies when they materially affect sequencing
5. Run a final rejection pass.
   - Reject issues that are only storage, plumbing, or transport buckets when a behavior-shaped slice is possible.
   - Reject issue sets that skip verification expectations or miss coverage for a plan slice without saying so.

Rules:

- Each slice should deliver a narrow but complete path through the relevant layers.
- Prefer many thin slices over a few thick ones.
- Do not decompose work into horizontal architecture buckets if vertical slices are possible.
- When creating GitHub implementation issues, use a typed title that includes the issue number once it exists:
  `feat-<issue number>: <outcome>` for feature slices and `fix-<issue number>: <outcome>` for bug-fix slices.
- Because the issue number is only known after creation, create the issue first and then immediately update its title to the numbered form in the same workflow.
- Use local product docs as the source of truth when they conflict with generic guidance.
- Pull testing or verification expectations into each slice when they materially affect scope.
- When rerunning against an existing tracker, compare the current issues to the plan and repair them instead of blindly appending more tickets.
- When the plan identifies an architecture checkpoint, emit a dedicated issue for it.
- Architecture checkpoint issues should be explicit review moments, usually routed to `improve-architecture`, and should land before the next expansion or parity wave that depends on the same shape.
- Do not name checkpoint issues as vague chores like `review architecture`. Name the exercised scope and decision point, for example `Architecture checkpoint after movie lifecycle flow`.

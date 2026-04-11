# Project Memory Extension

Purpose:
Interpret rollout memories for `review-app` and promote only stable, reusable, repo-specific guidance into Codex memory artifacts.

Project identification:
Treat a rollout as belonging to this project when any of these are true:
- `cwd` is inside `review-app`
- the rollout path points into this repository
- the task clearly refers to Review App modules, docs, workflows, or conventions

Goals:
- Preserve stable product and architecture truth for the macOS review app.
- Preserve repeated search paths that reliably identify the right local source of truth.
- Preserve recurring user steering that should not need to be restated in future Review App sessions.

Promote aggressively when repeated and stable:
- This repo is a prototype-first native macOS app for pull request review.
- `docs/BOOTSTRAP.md` is the source of truth for current scope when it conflicts with older exploratory notes.
- SwiftUI is the primary UI surface.
- AppKit interop is justified only for performance-critical diff rendering or other validated needs.
- Stable repo-specific architecture boundaries, naming decisions, workflow defaults, and proven debugging/search paths.

Do not promote unless clearly repeated and validated:
- One-off implementation details from a single task.
- Temporary file paths or generated outputs.
- Branch-specific facts.
- Ephemeral compiler or runtime errors without a validated fix.
- Cross-project harness ideas that belong in `agent-standards`, not Review App memory.

Project-locality:
- Keep memory strict to this repo.
- Do not generalize Review App-specific choices into global guidance.

Preferred tags:
- review-app
- macos
- swiftui
- appkit-interop
- prototype-first
- workflow-default

# Project Memory Extension

Purpose:
Interpret rollout memories for `codex-usage-menubar-app` and promote only stable, reusable, project-specific guidance into Codex memory artifacts.

Project identification:
Treat a rollout as belonging to this project when any of these are true:
- `cwd` is inside `codex-usage-menubar-app`
- the rollout path points into this repository
- the task clearly refers to this app's modules, workflows, or conventions

Goals:
- Preserve stable architecture boundaries for the macOS menubar app.
- Preserve repeated search and debugging paths that reliably lead to the right source of truth.
- Preserve recurring user steering that should not need to be restated.
- Preserve proven workflow defaults for this repo.

Promote aggressively:
- The app is a native macOS menubar app using SwiftUI and Tuist.
- `~/.codex/auth.json` is the primary account switching surface.
- `~/Library/Application Support/Codex` is an observation surface, not the switching source of truth.
- Auth switching, Codex lifecycle control, and rate-limit fetching belong in separate modules.
- Prefer the local Codex app-server for account and rate-limit reads when available.
- Keep SwiftUI views free of file I/O and process control.
- Keep AppKit interop surgical; platform bootstrap belongs in app wiring, not feature logic.
- The current architectural direction is feature-oriented grouping, not flat catch-all folders and not heavyweight DDD.
- Menubar presentation policy belongs in a `Features/MenuBar` boundary, not in the app delegate.

Keep as durable repo guidance when repeated:
- Repeated naming corrections such as `CodexPill` over older product names.
- Repeated file-organization guidance: prototype-first initially, feature/domain grouping as the app grows.
- Proven test seams around pure policy layers instead of brittle AppKit-heavy tests.
- Search paths that repeatedly identify the right truth sources in this repo.

Do not promote unless clearly repeated and stable:
- Temporary file paths or generated build outputs.
- One-off implementation details from a single refactor.
- Branch-specific facts.
- Ephemeral compiler or runtime errors without a validated fix.
- Proposed architecture that was discussed but not implemented.
- Cross-project harness ideas that belong in `agent-standards`, not this repo's memory.

Project-locality:
- Keep memory strict to this repo.
- Do not generalize repo-specific architecture choices into global guidance.
- Treat shared harness improvements as external to this project unless they become explicit repo conventions.

Preferred tags:
- codex-pill
- macos-menubar
- swiftui
- tuist
- auth-switching
- rate-limits
- feature-boundary
- appkit-interop
- project-architecture

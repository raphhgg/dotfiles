# Project Memory Extension

Purpose:
Interpret rollout memories for `gather-app` and promote only stable, reusable, repo-specific guidance into Codex memory artifacts.

Project identification:
Treat a rollout as belonging to this project when any of these are true:
- `cwd` is inside `gather-app`
- the rollout path points into this repository
- the task clearly refers to Gather modules, docs, workflows, or conventions

Goals:
- Preserve stable prototype-first guidance for Gather.
- Preserve repeated search paths that reliably identify local product truth.
- Preserve recurring user steering that should not need to be restated in future Gather sessions.

Promote aggressively when repeated and stable:
- Gather is a prototype-first product.
- Local docs win over shared standards.
- The current shape is Go backend plus TanStack web UI, with Python limited to ingestion or enrichment experiments when Go iteration is unnecessarily expensive.
- The product is topic-first, not platform-first.
- Stable repo-specific workflow defaults, boundaries, and proven debugging/search paths.

Do not promote unless clearly repeated and validated:
- One-off implementation details from a single task.
- Temporary file paths or generated outputs.
- Branch-specific facts.
- Ephemeral compiler or runtime errors without a validated fix.
- Cross-project harness ideas that belong in `agent-standards`, not Gather memory.

Project-locality:
- Keep memory strict to this repo.
- Do not generalize Gather-specific prototype decisions into global guidance.

Preferred tags:
- gather
- prototype-first
- go-backend
- tanstack
- topic-first
- workflow-default

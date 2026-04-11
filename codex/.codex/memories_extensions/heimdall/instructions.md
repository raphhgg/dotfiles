# Project Memory Extension

Purpose:
Interpret rollout memories for `heimdall` and promote only stable, reusable, repo-specific guidance into Codex memory artifacts.

Project identification:
Treat a rollout as belonging to this project when any of these are true:
- `cwd` is inside `heimdall`
- the rollout path points into this repository
- the task clearly refers to Heimdall modules, docs, workflows, or conventions

Goals:
- Preserve stable product and architecture truth from local repo docs.
- Preserve repeated search and debugging paths that reliably identify the right local source of truth.
- Preserve recurring user steering that should not need to be restated in future Heimdall sessions.

Promote aggressively when repeated and stable:
- Local product docs win over shared standards.
- `docs/PRD.md`, `docs/GLOSSARY.md`, and `docs/ARCHITECTURE.md` are the primary truth surfaces.
- Shared guidance from `agent-standards` is workflow help, not product doctrine.
- Stable architectural boundaries, naming decisions, and verified workflow defaults for this repo.
- Proven search paths that repeatedly lead to the right source of truth in Heimdall.

Do not promote unless clearly repeated and validated:
- One-off implementation details from a single task.
- Temporary file paths or generated outputs.
- Branch-specific facts.
- Ephemeral compiler or runtime errors without a validated fix.
- Cross-project harness ideas that belong in `agent-standards`, not Heimdall memory.

Project-locality:
- Keep memory strict to this repo.
- Do not generalize Heimdall-specific choices into global guidance.

Preferred tags:
- heimdall
- project-architecture
- product-truth
- glossary
- workflow-default

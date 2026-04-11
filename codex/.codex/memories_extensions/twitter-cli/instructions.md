# Project Memory Extension

Purpose:
Interpret rollout memories for `twitter-cli` and promote only stable, reusable, repo-specific guidance into Codex memory artifacts.

Project identification:
Treat a rollout as belonging to this project when any of these are true:
- `cwd` is inside `twitter-cli`
- the rollout path points into this repository
- the task clearly refers to the local X workflow, scripts, config files, or conventions in this repo

Goals:
- Preserve stable workflow defaults for the local X digest setup.
- Preserve repeated search and debugging paths that reliably identify the right source of truth.
- Preserve recurring user steering that should not need to be restated in future sessions for this repo.

Promote aggressively when repeated and stable:
- This repo wraps `twitter-cli` into a local workflow for curated X monitoring.
- Curation is mandatory; broad generic searches create noise.
- The stable truth surfaces are the workflow README, config files, and scripts in this repo.
- The digest flow is based on narrow queries, trusted accounts, optional curated lists, and local digest generation.
- Proven local workflow defaults, source-selection heuristics, and search paths that repeatedly lead to the right source of truth.

Do not promote unless clearly repeated and validated:
- One-off implementation details from a single task.
- Temporary file paths or generated outputs.
- Branch-specific facts.
- Ephemeral auth or network failures without a validated fix.
- Cross-project harness ideas that belong in `agent-standards`, not this repo's memory.

Project-locality:
- Keep memory strict to this repo.
- Do not generalize repo-specific workflow choices into global guidance.

Preferred tags:
- twitter-cli
- x-workflow
- curated-sources
- digest
- workflow-default

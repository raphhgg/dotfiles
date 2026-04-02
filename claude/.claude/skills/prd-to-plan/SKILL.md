---
name: prd-to-plan
description: Turn a PRD into a concrete implementation plan with durable decisions, sequencing, and vertical slices. Use when the user wants an implementation plan before issue creation or the feature is too large to jump straight from PRD to execution issues.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the product PRD and `docs/ARCHITECTURE.md` when it exists, plus any equivalent local specs or architecture notes that already constrain implementation.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load one relevant shape doc when runtime, deployment, or client shape affects slice boundaries.
5. Load `docs/capabilities/backend-boundaries.md`.
6. If `docs/ARCHITECTURE.md` exists and architecture-doc guidance is available, treat that document as the owner of stable structure and use it to keep the plan out of architecture territory.

Optional:

- Load `docs/capabilities/contracts-and-domain.md` when naming, contracts, or event semantics are still unstable.
- Load `docs/capabilities/testing-and-quality.md` when verification strategy materially affects the plan.

Turn the PRD into an implementation plan.

The output is not a ticket list and not a PRD rewrite. The output is the missing middle layer between feature intent and execution issues.

## Workflow

1. Verify the PRD is specific enough to plan from.
   - If core scope, terminology, or constraints are still ambiguous, stop and push the work back to `create-prd`, `interview`, or `ubiquitous-language`.
2. Separate architecture truth from planning truth.
   - If `docs/ARCHITECTURE.md` already captures system shape, boundaries, invariants, persistence model, or top-level layout, reference it instead of restating it.
   - If the repo is greenfield and a top-level layout choice is durable, put that choice in `docs/ARCHITECTURE.md`, not in the implementation plan.
   - If the architecture doc is missing a stable structural decision that the plan depends on, update architecture first or in the same planning pass.
3. Identify the durable implementation decisions that should be made before issue slicing.
   - module or service boundaries
   - key interfaces or contracts
   - sequencing constraints
   - migration or compatibility constraints
   - verification expectations that affect slice shape
4. Define 2-5 vertical slices or phases.
   - Each slice should prove a meaningful end-to-end path.
   - Prefer tracer bullets over horizontal decomposition.
   - Make dependencies explicit.
5. Identify architecture checkpoint candidates.
   - Do this at planning time, not later during arbitrary implementation turns.
   - Add a checkpoint only when enough of the system will have been exercised to reveal structural friction.
   - Good checkpoint moments usually happen after a slice foundation plus the first follow-on issues that fully exercise its core seams, and before parity or breadth work builds on that shape.
   - Do not add a checkpoint after every slice just to look rigorous.
6. For each slice, state:
   - goal
   - scope
   - key modules or boundaries involved
   - acceptance target
   - verification expectations
   - architecture checkpoint note when one belongs after that slice
7. Call out what is intentionally deferred.
8. Produce a plan that `prd-to-issues` can consume directly.

## Output shape

The plan should include:

- summary of implementation approach
- planning decisions that affect sequencing or slice shape
- ordered vertical slices or phases
- acceptance and verification notes per slice
- architecture checkpoint notes when the sequence should pause for structural review
- explicit out-of-scope or deferred items

## Rules

- Do not duplicate the PRD in different words.
- Do not duplicate `docs/ARCHITECTURE.md` in different words.
- Do not jump straight to issue creation.
- Do not decompose the work into horizontal architecture buckets if vertical slices are possible.
- Do not invent product truth when local docs are silent; surface the ambiguity instead.
- Keep stable structure in architecture and keep the plan focused on sequencing, acceptance, verification, and deferrals.
- Keep the plan concrete enough that `prd-to-issues` can generate clean `1 issue -> 1 PR` slices from it.
- When a checkpoint is warranted, write it as an explicit sequencing note such as `Architecture checkpoint after issue #10 before show-parity expansion`, not as a vague suggestion to maybe review architecture later.

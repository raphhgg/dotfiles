---
name: improve-architecture
description: Explore a codebase for architectural friction and recommend one strong refactoring direction, with an emphasis on deeper modules and clearer boundaries. Use when the user wants to assess architecture, find refactoring opportunities, reduce coupling, or consolidate shallow or tightly coupled modules.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the local product docs that define current architecture, constraints, and ownership.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/backend-boundaries.md`.
5. Load `docs/capabilities/testing-and-quality.md`.
6. Load `docs/capabilities/repo-strategy.md` when the question involves where responsibilities or docs should live.
7. Load one matching shape doc only when runtime, deployment, or client shape changes the architectural trade-offs.

# Improve Codebase Architecture

Explore the codebase, surface architectural friction, and recommend one strong refactoring or module-deepening direction.

A deep module has a small interface hiding meaningful internal complexity. The point is not abstraction theater. The point is clearer ownership, cheaper tests, and fewer brittle seams.

## Process

This skill is especially appropriate for dedicated architecture checkpoint issues created during planning or issue generation, where the output should validate the current structure or produce one focused follow-up refactor direction.

### 1. Explore for friction

Explore the codebase locally and note places where understanding or changing behavior is harder than it should be. Useful signals include:

- one concept spread across too many small files
- shallow modules whose interface is nearly as complex as their implementation
- duplicated orchestration across handlers, services, or workers
- transport or adapter details leaking into domain decisions
- tests that are forced into the seams because the boundary is weak

The friction is the signal.

### 2. Present 2-4 candidates

For each candidate, show:

- cluster: the modules or concepts involved
- friction: why the current shape is costly or brittle
- dependency category: see `reference.md`
- test impact: what would get easier, replaced, or consolidated

Do not jump straight to a giant rewrite. First identify the best leverage points.

### 3. Recommend one direction

If one candidate is clearly strongest, say so. Otherwise ask the user which candidate they want to explore further.

### 4. Frame the recommended refactor

For the chosen candidate, describe:

- what the deeper module should own
- what should be hidden behind the boundary
- what callers should depend on
- the dependency strategy
- what tests should move to the new boundary

Use `reference.md` when it helps clarify dependency categories, test replacement, or an optional RFC outline.

### 5. Optional follow-through

If the user asks for it, draft an RFC, issue, or implementation plan for the recommended direction.

## Anti-patterns

- proposing broad rewrites before finding a concrete leverage point
- treating every awkward area as an architecture problem instead of a local design problem
- assuming sub-agents are required
- creating issues or files automatically when the user only asked for analysis

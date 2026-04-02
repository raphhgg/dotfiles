---
name: design-interface
description: Generate 2-3 materially different interface designs for a module or API boundary, compare trade-offs, and recommend one. Use when the user wants to design a module boundary, API surface, or contract, compare interface options, or mentions "design it twice".
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the local product docs that define the module, callers, and constraints.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/backend-boundaries.md` when seams, ownership, or dependency boundaries matter.
5. Load `docs/capabilities/contracts-and-domain.md` when naming, wire contracts, or client-facing semantics matter.
6. Load `docs/capabilities/testing-and-quality.md` when testability is part of the design decision.
7. Load one matching shape doc only when runtime or client shape changes what a good interface looks like.

# Design an Interface

Use a "design it twice" mindset: the first interface is usually not the best one. Generate multiple materially different options, compare them, and recommend one.

## Workflow

### 1. Ground the design

Before proposing interfaces, establish:

- what problem the module solves
- who the callers are
- the key operations and failure modes
- constraints such as compatibility, performance, and existing patterns
- what should stay hidden behind the boundary

If repo docs or code can answer these questions, explore first instead of asking the user.

### 2. Generate 2-3 materially different designs

Generate the options locally. Use different design pressures so the options are meaningfully different, for example:

- minimize the surface area
- optimize for the dominant caller
- allow extension without over-generalizing

For each design, provide:

1. interface signature
2. short usage example
3. what the interface hides internally
4. main trade-offs

Delegation is optional only when the user explicitly wants parallel exploration.

### 3. Compare the designs

Compare the options in prose. Focus on:

- interface simplicity
- ease of correct use vs ease of misuse
- depth: how much complexity the interface hides
- fit for current callers
- ability to evolve without leaking internal structure
- testability at the boundary

### 4. Recommend one design

Give a strong recommendation. If a hybrid is better than any single option, say so explicitly and describe the merged shape.

## Anti-patterns

- generating multiple options that are really the same design with renamed methods
- over-generalizing for imagined future callers
- designing the interface around current file layout instead of responsibilities
- assuming sub-agents or runtime-specific tools are available
- implementing code when the task is interface design only

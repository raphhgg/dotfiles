---
name: interview
description: Interrogate a plan or design until ambiguities, trade-offs, and unresolved branches are surfaced and resolved. Use when the user wants to stress-test a plan, get grilled on a design, clarify scope before planning, or mentions "interview me".
---

Before asking design questions:

1. Read the repo-local `AGENTS.md`.
2. Read the relevant local product docs if they exist.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load one matching shape doc and only the minimum capability docs needed for the current branch of the discussion.

Interview the user relentlessly about every aspect of the plan until you reach shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.

Ask questions one at a time.

If a question can be answered by exploring the codebase or local docs, explore first.
Do not preload extra standards docs just to feel thorough.

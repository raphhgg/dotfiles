---
name: create-prd
description: Create a PRD through user interview, codebase exploration, and module design to define product intent for substantial work. Use when the user wants to write a PRD, define a feature before implementation planning, or clarify scope, outcomes, and constraints for new work.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read any repo-local product docs that already define truth for this project.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load one relevant shape doc.
5. Load `docs/capabilities/contracts-and-domain.md`.
6. Load `docs/capabilities/testing-and-quality.md` only when testing decisions are in scope.

This skill will be invoked when the user wants to create a PRD. You may skip steps if they are not necessary.

1. Ask the user for a long, detailed description of the problem they want to solve and any potential ideas for solutions.
2. Explore the repo to verify their assertions and understand the current state of the codebase.
3. Interview the user relentlessly about every aspect of the plan until you reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.
4. Sketch out the major modules you will need to build or modify to complete the implementation. Actively look for opportunities to extract deep modules that can be tested in isolation.
5. Once you have a complete understanding of the problem and solution, write the PRD and submit it as a GitHub issue if the repo workflow expects that.

A deep module is one which encapsulates a lot of functionality in a simple, testable interface that rarely changes.
Do not treat shared standards as product truth when local product docs disagree.

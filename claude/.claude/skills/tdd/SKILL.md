---
name: tdd
description: Default implementation skill for code-bearing issues and thin vertical slices. Implement a feature or fix through a red-green-refactor loop, one observable behavior at a time, with tests on public behavior.
---

Routing note:

- Use this skill by default when implementing a planned issue or vertical slice that changes code.
- Use it when the user explicitly asks for test-first implementation or mentions "red-green-refactor".
- Do not use it for docs-only, planning-only, or review-only tasks.

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the local product docs that define the behavior under change.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/testing-and-quality.md`.
5. Load `docs/capabilities/backend-boundaries.md` when interface seams, module boundaries, workers, or adapters are part of the design.
6. Load one matching shape doc only when runtime shape changes what "public behavior" means.

# Test-Driven Development

## Workflow

Use a vertical red-green-refactor loop:

1. Ground the task in local product truth and identify the first observable behavior to prove.
2. Write one failing test through a public interface.
3. Write the minimum code to make that test pass.
4. Repeat one behavior at a time.
5. Refactor only after the slice is green.

Working rules:

- Test behavior, not implementation details.
- Prefer integration-style tests through public interfaces.
- Do not bulk-write speculative tests before the first working slice exists.
- Do not anticipate future slices in the current implementation step.
- When a code-bearing issue is implemented and verified, hand it off through `handoff-issue` unless the user explicitly defers PR handoff or local repo rules say otherwise.
- If `handoff-issue` is unavailable in the active runtime catalog, do not stop at green tests. Perform the equivalent manual closeout: run the feedback checkpoint, create or confirm a dedicated branch using repo-local naming when it exists, commit and push the slice, choose draft-versus-ready from canonical repo-local workflow instructions before shared defaults, and treat the missing skill as a harness integration bug to fix.
- Ask the user only when behavior priorities or interface expectations are genuinely unclear and local docs or code cannot answer them.

Use the reference docs when needed:

- [tests.md](tests.md) for behavior-first test examples
- [mocking.md](mocking.md) for mocking rules
- [deep-modules.md](deep-modules.md) for keeping interfaces small and implementations deep
- [interface-design.md](interface-design.md) for designing testable boundaries
- [refactoring.md](refactoring.md) for post-green cleanup guidance

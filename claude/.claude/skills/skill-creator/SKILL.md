---
name: skill-creator
description: Create or update a reusable skill that fits the harness. Use when the user wants to add a skill, revise a skill, or move skill guidance into shared docs and routing.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the existing skill, task description, and any local docs that already define the workflow under discussion.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/skill-authoring.md`.
5. Load `docs/capabilities/repo-strategy.md` when deciding whether the skill belongs in `agent-standards`, a product repo, or a user-local folder.
6. If the task changes shared harness behavior, read the relevant integration docs and update routing or adoption surfaces in the same change.

# Skill Creator

## Workflow

1. Define the workflow the skill is meant to own, including trigger prompts and obvious non-triggers.
2. Decide whether the skill is actually reusable enough for `agent-standards`.
3. Separate doctrine from workflow.
   - Put durable reusable rules in docs.
   - Keep the skill focused on loading the right docs and executing the workflow.
4. Write or revise the skill with a clear frontmatter name and description, a short setup section, and a compact workflow.
5. Update routing, matrix, index, and regression surfaces when the skill is meant to be part of the harness.
6. Check whether adoption docs or templates also need a change.
7. Validate that the new skill does not duplicate another skill or hide product-specific doctrine.

## Working rules

- Skills describe workflows, not product truth.
- Prefer a thin skill plus a capability doc over a giant standalone manual.
- If the workflow is product-specific, stop and keep it local.
- If the skill should be discoverable by default, wire it into routing in the same change.
- If the skill cannot be described with clear triggers and non-triggers, the workflow is probably not ready to standardize.

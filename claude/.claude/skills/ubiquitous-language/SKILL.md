---
name: ubiquitous-language
description: Extract or tighten a product glossary by flagging ambiguous terms, synonym drift, and overloaded concepts, then propose canonical names. Use when the user wants to define domain terms, build a glossary, align terminology across docs or APIs, harden naming, or mentions DDD or ubiquitous language.
---

Before starting:

1. Read the repo-local `AGENTS.md`.
2. Read the repo-local glossary if one exists.
3. If doc selection is unclear, read `docs/routing/skill-routing.md` and follow `docs/routing/progressive-disclosure.md`.
4. Load `docs/capabilities/contracts-and-domain.md`.

Process:

1. Scan the conversation and repo-local docs for domain-relevant nouns, verbs, and concepts.
2. Identify ambiguity, synonym drift, and overloaded terms.
3. Propose a canonical glossary with opinionated term choices.
4. Write or update the local glossary file used by the product repo.
5. Output a short summary inline.

Rules:

- Product-local terminology wins over generic reusable examples.
- Define what a term is, not what it does.
- Flag conflicts explicitly.
- Keep the glossary useful for both humans and agents.
- If a third-party system uses different names, preserve the distinction instead of collapsing terms prematurely.

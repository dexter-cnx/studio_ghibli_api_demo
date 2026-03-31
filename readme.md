# Studio Ghibli Flutter Repo Pack

Repo-ready pack for a Flutter mobile catalog app that uses:
- `codex-claude-mobile-toolkit` as the workflow/tooling foundation
- Google Stitch as the design source and handoff producer
- Codex Agent Teams for implementation
- Anti Gravity as the repeatable orchestration layer

## What is included
- `AGENTS.md`
- `CLAUDE.md`
- `agents/shared/` shared repo rules used by both AGENTS and CLAUDE
- `design/DESIGN.md`
- `design/stitch/` briefs, prompts, and handoffs
- `prompts/` for repo bootstrapping and feature delivery
- `antigravity/` rules, workflows, templates, and artifacts
- `docs/` usage notes and rollout steps

## Suggested usage order
1. Merge the toolkit into your working repo.
2. Add the files from this pack into the project repo.
3. Update `design/stitch/` files with your current product intent.
4. Use Google Stitch to generate and refine screens.
5. Save screen summaries into `design/stitch/handoffs/`.
6. Run Codex using the prompts in `prompts/`.
7. Use Anti Gravity workflows for larger multi-step work.

## First implementation order
1. app shell
2. films list
3. film detail
4. favorites
5. recently viewed
6. search and sort
7. related entities on demand

## Notes
- This pack is intentionally markdown-first and agent-friendly.
- Treat `design/DESIGN.md` as the visual source of truth.
- Treat `agents/shared/*.md` as the implementation source of truth.

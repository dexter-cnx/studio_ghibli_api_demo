# AGENTS.md

Read in this order before making changes:
1. `agents/shared/repo-rules.md`
2. `agents/shared/architecture.md`
3. `agents/shared/api-contract.md`
4. `agents/shared/verification.md`
5. `design/DESIGN.md`
6. relevant files under `design/stitch/handoffs/`

## Repository intent
This repository is a Flutter mobile app for browsing Studio Ghibli content through a public read-mostly API.

The app should prioritize:
- calm and readable mobile UX
- predictable architecture
- cache-first rendering
- local-first user features
- small, composable widgets
- verification before completion

## Operating model
- Use project prompts under `prompts/` for new work.
- Use `antigravity/` for multi-step or artifact-heavy work.
- Keep business logic out of widgets.
- Keep network and storage concerns out of presentation.
- Prefer incremental work over large speculative refactors.

## Default delivery expectations
For any meaningful change:
- respect presentation/domain/data boundaries
- add loading/empty/error/stale-cache handling where relevant
- localize user-facing text
- run verification
- summarize files changed, why, and any follow-up risk

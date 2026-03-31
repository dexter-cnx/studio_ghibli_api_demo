# CLAUDE.md

Read in this order:
1. `AGENTS.md`
2. `agents/shared/repo-rules.md`
3. `agents/shared/architecture.md`
4. `agents/shared/api-contract.md`
5. `agents/shared/verification.md`
6. Task-specific prompt or Antigravity workflow

## Claude-specific notes
- Keep edits incremental and easy to review.
- Reuse existing feature structure and naming.
- Prefer explicit state models over implicit UI logic.
- Emit concise implementation summaries.
- For ambiguous design intent, consult `design/DESIGN.md` and the latest Stitch handoff file.

## Delivery format
When a task is complete, summarize:
1. what changed
2. why it changed
3. files touched
4. verification results
5. any follow-up work worth doing next

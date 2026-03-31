# Google Stitch Steps for This Project

## Objective
Use Stitch as the design generation and iteration tool, then hand the design into this repo's Antigravity and Flutter implementation workflow.

## Repo preparation
Before opening Stitch, make sure these files exist and are up to date:
- `design/DESIGN.md`
- `design/stitch/product_brief.md`
- `design/stitch/screen_specs.md`
- `design/stitch/component_inventory.md`
- `design/stitch/stitch_prompts.md`

## Step 1: create the first design in Stitch
Start with a broad prompt from `design/stitch/stitch_prompts.md`.
For this project, begin with the mobile app overview rather than a single narrow widget.

## Step 2: refine one screen at a time
Refine the film list first, then film detail, then favorites.
Make one meaningful change at a time.
Keep prompts concrete and screen-specific.

## Step 3: align the design system
Use `design/DESIGN.md` as the design source of truth for spacing, typography, component rhythm, and state treatments.
If Stitch outputs new design rules worth keeping, update `DESIGN.md`.

## Step 4: export or capture the handoff
Take the final screen output and write a repo handoff file under `design/stitch/handoffs/`.
The handoff should describe layout, hierarchy, actions, and required states.

## Step 5: implement through the repo workflow
Use:
- `prompts/stitch_handoff_to_flutter.md` for direct implementation
- or `antigravity/workflows/05-stitch-to-flutter.md` for a multi-step task

## Step 6: verify
Run Flutter verification and record results in `antigravity/artifacts/verification-report.md`.

## Notes
Stitch output should guide layout and UX, not replace the repository's Flutter architecture.

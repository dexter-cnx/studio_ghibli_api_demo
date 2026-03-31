# Workflow: Stitch to Flutter

## Goal
Translate a Stitch design handoff into Flutter screens that follow repo conventions.

## Inputs
- `design/DESIGN.md`
- the latest relevant file under `design/stitch/handoffs/`
- any screen-specific prompt context

## Steps
1. Read the handoff file and extract layout, hierarchy, and UX states.
2. Map the design to Flutter widgets and section boundaries.
3. Preserve Material 3 semantics while honoring design intent.
4. Keep implementation faithful to design without copying fragile generated code patterns.
5. Ensure all user-facing text is localized.
6. Add loading, empty, error, and stale-cache states if the screen is data-backed.
7. Run verification and write artifacts.

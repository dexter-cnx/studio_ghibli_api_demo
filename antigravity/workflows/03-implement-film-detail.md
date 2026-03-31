# Workflow: Implement Film Detail

## Goal
Add film detail with local recent-view tracking and lazy related-resource loading.

## Expected UX
- title and original title
- metadata section
- synopsis
- favorite action
- recently viewed persistence on open
- related resources loaded on demand

## Steps
1. Add or update detail DTO and entity mapping.
2. Support cache-first detail reads.
3. Save the film to recently viewed when opened.
4. Render detail sections with clear loading/error handling.
5. Only fetch related entities when the UI asks for them.
6. Add tests for recent-view behavior and detail states.
7. Run verification and write artifacts.

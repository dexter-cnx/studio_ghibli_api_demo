# Workflow: Implement Film List

## Goal
Add the films list experience with cache-first rendering.

## Expected UX
- list of films
- search input
- loading state
- empty state
- error state with retry
- stale cached content shown during refresh when available

## Steps
1. Inspect `films` feature conventions already in the repo.
2. Add or update remote data source for films list.
3. Add or update local cache data source.
4. Map remote DTOs to domain entities.
5. Add provider/notifier and presentation state model.
6. Build list page and film card widget.
7. Wire route entry.
8. Add localization keys.
9. Add tests for parsing and state coverage.
10. Run verification and write artifacts.

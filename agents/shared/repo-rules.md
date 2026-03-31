# Repo Rules

## Stack
- Flutter
- Material 3
- Riverpod
- go_router
- Dio
- Easy Localization
- Clean Architecture with lightweight boundaries
- local persistence for favorites, recently viewed, and cache

## Product shape
This is a read-mostly mobile catalog app.
Core flows:
- browse films
- search films
- open film detail
- save favorites
- revisit recently viewed

## Coding rules
- no Dio in widgets
- no JSON parsing in widgets
- no endpoint strings scattered through presentation
- keep widgets focused on composition
- keep files small and readable
- prefer feature-first structure

## State rules
Every data-backed screen should explicitly support:
- loading
- success
- empty
- error
- stale cached data while refreshing

## Localization rules
- no hardcoded user-facing strings in widgets
- add new strings to the project localization source of truth
- use feature-namespaced keys

## Routing rules
Expected initial routes:
- `/films`
- `/films/:id`
- `/favorites`
- `/recently-viewed`

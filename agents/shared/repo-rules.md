# Repo Rules

## Stack
- Flutter
- Dart
- Material 3
- Riverpod
- go_router
- Dio
- Easy Localization
- local persistence for cache, favorites, and recently viewed

## App type
This is a read-mostly catalog app backed by a public REST API.
The app must feel fast even when the network is slow or temporarily unavailable.

## Naming
- feature-first folders under `lib/features/`
- use snake_case for file names
- suffix DTOs with `Dto`
- suffix repository implementations with `Impl`
- suffix use cases with `UseCase`
- suffix provider-backed state controllers consistently for the chosen Riverpod style

## Localization
- all user-facing strings must come from localization keys
- keys must be namespaced by feature
- do not hardcode labels, buttons, empty states, or error copy

## UI
- keep widgets small and composable
- prefer section widgets over giant pages
- use Material 3
- respect `design/DESIGN.md` for spacing, typography, and component behavior

## Data and async behavior
- no networking in widgets
- no JSON parsing in widgets
- no raw endpoint strings scattered across the codebase
- normalize failures into app-specific failure types

## Antigravity usage
Use `antigravity/` for:
- multi-step feature implementation
- bugfixes requiring investigation plus remediation
- tasks that should produce reusable artifacts or reports

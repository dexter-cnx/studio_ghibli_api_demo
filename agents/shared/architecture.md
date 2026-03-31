# Architecture

## Core pattern
Use lightweight Clean Architecture:
- `presentation/`
- `domain/`
- `data/`

Each feature should live under `lib/features/<feature_name>/`.

## Presentation layer
Allowed:
- pages
- widgets
- providers/notifiers
- presentation state models
- route glue

Not allowed:
- Dio usage
- raw JSON parsing
- endpoint knowledge
- business logic that belongs in domain or repository layers

## Domain layer
Contains:
- entities
- repository contracts
- use cases
- feature-specific rules

Domain must not depend on Flutter UI or infrastructure libraries.

## Data layer
Contains:
- DTOs
- mappers
- remote data sources
- local data sources
- repository implementations

## Recommended initial features
- films
- favorites
- recently_viewed

## Cache-first rendering
Preferred flow for list/detail screens:
1. read local cache
2. render cached data immediately when available
3. fetch remote data in background
4. persist updated data
5. refresh UI without causing a jarring blank state

## Related resource loading
Related URLs returned by the API should normally be loaded on demand.
Do not fetch all relationships by default on app startup or list screens.

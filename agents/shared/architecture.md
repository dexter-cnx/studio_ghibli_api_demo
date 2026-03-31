# Architecture

## Feature structure
Each feature should follow:
- `presentation/`
- `domain/`
- `data/`

## Presentation
Allowed:
- pages
- widgets
- providers/notifiers/controllers
- presentation state models

Not allowed:
- direct network access
- raw JSON parsing
- repository implementation logic

## Domain
Contains:
- entities
- repository contracts
- use cases
- domain rules

Domain must not depend on Flutter UI or Dio.

## Data
Contains:
- DTOs
- mappers
- remote data sources
- local data sources
- repository implementations

## Recommended app layout
- `lib/app/`
- `lib/core/`
- `lib/features/`

## Caching pattern
Preferred read flow:
1. read cache first
2. render immediately if cache exists
3. fetch remote
4. persist updated content
5. refresh UI without blanking working content

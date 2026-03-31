# API Contract

## Backend assumptions
The app uses a public unofficial Studio Ghibli API.
Treat it as:
- read-only
- potentially unreliable
- suitable for catalog browsing
- not a strong source of uptime guarantees

## Resource model
Primary resources:
- films
- people
- locations
- species
- vehicles

## Fetching rules
- prefer list/detail flows
- do not eagerly fetch all related resources
- load related resources on demand when helpful
- handle missing, delayed, or partial related content gracefully

## Persistence expectations
Persist at least:
- favorite film ids
- recently viewed film ids
- cached film list/detail data

## Failure model
Normalize failures into a small app-specific model, such as:
- network
- timeout
- parse
- not found
- unknown

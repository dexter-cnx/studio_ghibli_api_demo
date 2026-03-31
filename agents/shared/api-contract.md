# API Contract

## Source type
The app uses a public, unofficial, read-only REST API for Studio Ghibli data.
Treat availability and response stability as weaker than a production backend.

## Primary resources
- films
- people
- locations
- species
- vehicles

## Product assumptions
The first shipped version is films-first:
- film list
- film detail
- favorites
- recently viewed
- optional related entities loaded lazily

## API consumption rules
- centralize endpoint definitions
- model remote payloads with DTOs
- map DTOs to domain entities before presentation
- support partial degradation when the network fails

## Failure handling
Normalize failures into a small app model such as:
- network
- timeout
- parse
- not_found
- unknown

## Local state
Persist at least:
- cached film list/detail data
- favorite film ids
- recently viewed film ids

## Progressive enhancement
Prefer adding browse sections for people and locations after the film core is solid.

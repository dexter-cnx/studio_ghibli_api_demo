# Film Detail Handoff

## Source
- Stitch version: placeholder
- Based on `design/DESIGN.md`

## Purpose
Let users read detailed information about a selected film and access related content.

## Layout
1. top app bar
2. title and original title
3. metadata chip row
4. director and producer section
5. synopsis section
6. favorite action
7. related content section

## Components
- app bar
- title block
- metadata chips
- long-form synopsis area
- favorite action
- related content section
- loading and retry patterns

## Visual Rules
- elegant and calm presentation
- strong readability for long text
- compact metadata
- related content should not dominate main details

## Data Requirements
Show:
- title
- original title
- romanised title if available
- release year
- running time
- score
- director
- producer
- description
- favorite state

## Interactions
- favorite toggles local saved state
- related sections may load lazily
- retry reloads failed content

## States
- loading
- success
- error
- stale cached detail while refreshing
- partial related-content loading

## Implementation Notes
- Flutter + Material 3
- Riverpod
- go_router
- Dio-backed repository
- lazy related resource loading
- cache-first detail rendering

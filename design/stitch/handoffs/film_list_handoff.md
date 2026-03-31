# Film List Handoff

## Source
- Stitch version: placeholder
- Based on `design/DESIGN.md`

## Purpose
Help users browse and discover Studio Ghibli films quickly.

## Layout
1. top app bar
2. search field
3. sort control
4. vertical film card list
5. empty/error/loading area

## Components
- app bar
- search field
- segmented control
- film card
- favorite action
- empty state
- error block with retry

## Visual Rules
- calm and warm tone
- rounded cards
- generous vertical spacing
- readable card metadata
- avoid clutter

## Data Requirements
Each film card shows:
- title
- original title
- release year
- score
- favorite state

## Interactions
- tap card opens detail
- tap favorite toggles saved state
- search filters visible list
- sort changes visible order
- retry reloads remote content

## States
- loading
- success
- empty
- error
- stale cached data while refreshing

## Implementation Notes
- Flutter + Material 3
- Riverpod
- go_router
- Dio-backed repository
- cache-first rendering

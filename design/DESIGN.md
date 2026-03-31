# DESIGN.md

## Design intent
The app should feel calm, cinematic, warm, and readable.
It should emphasize content clarity over decorative complexity.

## Platform focus
- mobile-first
- Flutter Material 3 implementation

## Visual principles
- soft spacing rhythm
- readable typography
- strong content hierarchy
- restrained use of accent color
- card-based catalog browsing

## Layout rules
- use a consistent spacing scale
- prefer vertically stacked mobile sections
- do not overcrowd detail screens
- keep metadata compact and synopsis readable

## Component rules
### Film card
Must support:
- title
- original title when available
- release year
- score
- favorite action

### Search area
- persistent at the top of list screen
- should not dominate the layout

### Detail sections
- header/title block
- metadata block
- synopsis block
- related content section

## State patterns
Every data-backed screen must have visual treatment for:
- loading
- empty
- error
- stale cache during refresh

## Motion
Keep motion subtle.
Prefer simple transitions and avoid excessive choreography.

## Implementation note
Generated design artifacts are references, not production Flutter code.
Flutter implementation must conform to repository architecture and Material 3 behavior.

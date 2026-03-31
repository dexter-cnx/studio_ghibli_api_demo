# Antigravity Architecture Rule

Antigravity tasks must preserve the repo architecture.

Do:
- keep work inside the correct feature layer
- isolate networking to data sources
- use providers/notifiers for async UI state
- map DTOs into domain entities

Do not:
- shortcut architecture for convenience
- put feature logic in widgets
- scatter endpoints across files

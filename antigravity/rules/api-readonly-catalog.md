# Read-only Catalog API Rule

This app consumes a public read-only catalog API.

Task design should assume:
- the network can fail
- stale cache is acceptable when clearly handled
- related resources should usually be loaded lazily
- user-specific state belongs locally unless specified otherwise

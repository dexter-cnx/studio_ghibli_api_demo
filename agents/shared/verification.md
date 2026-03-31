# Verification

## Minimum verification
Run these before considering a task complete:

```bash
flutter pub get
flutter analyze
flutter test
```

## Additional verification
Run any project-specific generation steps if relevant, such as localization export or code generation.

## Required state coverage
Every data-backed screen must explicitly support:
- loading
- success
- empty
- error
- stale cache plus refresh when applicable

## Artifact expectations for Antigravity tasks
For multi-step work, produce:
- a short implementation summary
- a verification report
- any notable design or cache decisions

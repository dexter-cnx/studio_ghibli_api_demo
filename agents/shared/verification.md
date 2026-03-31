# Verification

## Required checks
Run when relevant:
```bash
flutter pub get
flutter analyze
flutter test
```

If localization generation exists in the repo, also run it before final verification.

## Review checklist
- code compiles
- analyzer issues are addressed
- tests pass or failures are explained
- no business logic in widgets
- routes are wired correctly
- user-facing text is localized
- loading/empty/error/stale-cache states are covered
- changed files remain aligned with `design/DESIGN.md`

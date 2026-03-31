# New Project Prompt

Scaffold a new Flutter project for a Studio Ghibli catalog app.

Read and follow:
- `AGENTS.md`
- `CLAUDE.md`
- `agents/shared/*`
- `design/DESIGN.md`
- `design/stitch/handoffs/*`

Required stack:
- Material 3
- Riverpod
- go_router
- Dio
- Easy Localization
- Clean Architecture with presentation/domain/data
- cache-first rendering
- local persistence for favorites, recently viewed, and cached film data

Initial routes:
- `/films`
- `/films/:id`
- `/favorites`
- `/recently-viewed`

Initial scope:
- app shell
- films list
- film detail
- favorites
- recently viewed

Requirements:
- no Dio in widgets
- no JSON parsing in widgets
- explicit loading/empty/error/stale-cache states
- localize user-facing strings

Verification:
- `flutter pub get`
- `flutter analyze`
- `flutter test`

# New Catalog Feature Prompt

Implement a new feature in this Flutter Studio Ghibli catalog app.

Before coding:
1. inspect the repository structure
2. read `AGENTS.md` and shared rules
3. use the nearest Antigravity workflow when the task spans multiple steps

## Feature planning
Identify:
- feature name
- user goal
- route entry
- remote data required
- local data required
- required states
- failure modes
- cache behavior

## Requirements
- preserve architecture boundaries
- no Dio in widgets
- no JSON in widgets
- localize all new user-facing text
- add loading, empty, error, and stale-cache handling where relevant
- add tests where justified

## Completion
Run:

```bash
flutter analyze
flutter test
```

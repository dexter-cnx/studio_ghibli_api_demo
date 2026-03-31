# AGENTS.md

Read in this order before making changes:
1. `agents/shared/repo-rules.md`
2. `agents/shared/architecture.md`
3. `agents/shared/api-contract.md`
4. `agents/shared/verification.md`
5. Relevant task prompt under `prompts/` or `antigravity/workflows/`

## Purpose
This repository contains a Flutter mobile app that browses Studio Ghibli catalog data from a public read-only REST API.

The operating model for this repo is:
- shared rules in `agents/shared/`
- task-specific prompts in `prompts/`
- multi-step execution via `antigravity/`
- design handoff via `design/` and `DESIGN.md`

## Default behavior
- Follow existing repository conventions before inventing new ones.
- Prefer small coherent changes over large refactors.
- Keep Flutter UI code free of raw networking and JSON parsing.
- Preserve Material 3 and localization discipline.
- For large or multi-step work, use Antigravity workflows and produce artifacts.

## Task routing
Use these entry points by default:
- New repo bootstrap: `prompts/new_project_antigravity.md`
- New app feature: `prompts/new_feature_catalog.md`
- Stitch to implementation handoff: `prompts/stitch_handoff_to_flutter.md`
- Multi-step execution: `antigravity/workflows/`

## Expected product scope
Primary user flows:
- browse films
- search films
- view film details
- save favorites locally
- revisit recently viewed films
- lazily load related entities such as people and locations

## Non-negotiables
- no Dio calls in widgets
- no JSON parsing in widgets
- no hardcoded user-facing strings
- no eager loading of all related resources unless explicitly needed
- no completion without running verification

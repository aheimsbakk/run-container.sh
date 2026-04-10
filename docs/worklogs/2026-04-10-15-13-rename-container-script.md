---
when: 2026-04-10T15:13:40Z
why: rename the container helper script to better match its build-and-run behavior
what: rename build-container.sh to run-container.sh and bump version to 1.0.4
model: github-copilot/gpt-5.4
tags: [scripts, docs, rename]
---

Renamed the root container helper from `build-container.sh` to `run-container.sh` and updated `README.md`, `BLUEPRINT.md`, and `CONTEXT.md` to match. Updated `scripts/bump-version.sh` to track the new filename and bumped the script version to `1.0.4`.

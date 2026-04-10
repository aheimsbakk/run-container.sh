# Context

## Current entrypoints

- `run-container.sh` is the user-facing container helper script at the repository root.

## Current documentation alignment

- `README.md` documents `run-container.sh` usage and examples.
- `BLUEPRINT.md` defines the script behavior, inputs, constraints, and failure modes for `run-container.sh`.

## Maintenance notes

- Version bumps are applied by `scripts/bump-version.sh`, which updates the `VERSION` constant in `run-container.sh`.
- The script embeds the MIT license text (from `LICENSE`) in the `LICENSE_TEXT` variable, displayed via `--license`.
- The `--update` option self-updates by downloading from `https://raw.githubusercontent.com/aheimsbakk/run-container.sh/main/run-container.sh` and replacing the running script in-place.
- Source repository: https://github.com/aheimsbakk/run-container.sh.git

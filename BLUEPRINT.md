# Blueprint

## Script

- Path: `run-container.sh`
- Purpose: build a local container image from the script directory when needed and run it with a small wrapper around `podman` / `docker`

## Inputs

- Script flags: `--force`, `--no-cache`, `--docker`, `--name`, `--help`, `--version`
- Runtime arguments: any arguments before `--`
- Container command arguments: any arguments after `--`
- Local build file: `Containerfile` preferred, `Dockerfile` as fallback

## Behavior

1. Parse script-specific flags and separate runtime arguments from container command arguments.
2. Resolve the container runtime in this order: forced `docker`, `podman`, then `docker`.
3. Locate a build file in the script directory: `Containerfile` first, then `Dockerfile`.
4. Derive the image name from `--name` or from the script directory name.
5. Inspect whether the image already exists.
6. Build when the image is missing or a rebuild was requested.
7. Run the container with `--rm`, forwarding runtime arguments and command arguments.

## Constraints

- The script operates only against files in its own directory.
- Build caching is preserved by default.
- `--no-cache` always triggers a rebuild.
- The runtime must support `image inspect`, `build`, and `run` with the current invocation pattern.

## Failure modes

- No supported runtime installed
- `--docker` requested but `docker` is unavailable
- No `Containerfile` or `Dockerfile` found beside the script
- Container build or run command fails

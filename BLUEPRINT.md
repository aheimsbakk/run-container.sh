# Blueprint

## Script

- Path: `run-container.sh`
- Purpose: build a local container image from the script directory when needed and run it with a small wrapper around `podman` / `docker`

## Inputs

- Script flags: `--force`, `--no-cache`, `--docker`, `--name`, `--update`, `--license`, `--help`, `--version`
- Runtime arguments: any arguments before `--`
- Container command arguments: any arguments after `--`
- Local build file: `Containerfile` preferred, `Dockerfile` as fallback

## Behavior

1. Parse script-specific flags and separate runtime arguments from container command arguments.
2. If `--update` is given, download the latest script from the repository and replace the current file, then exit.
3. If `--license` is given, print the license text and exit.
4. Resolve the container runtime in this order: forced `docker`, `podman`, then `docker`.
5. Locate a build file in the script directory: `Containerfile` first, then `Dockerfile`.
6. Derive the image name from `--name` or from the script directory name.
7. Inspect whether the image already exists.
8. Build when the image is missing or a rebuild was requested.
9. Run the container with `--rm`, forwarding runtime arguments and command arguments.

## Constraints

- The script operates only against files in its own directory.
- Build caching is preserved by default.
- `--no-cache` always triggers a rebuild.
- The runtime must support `image inspect`, `build`, and `run` with the current invocation pattern.
- `--update` requires `curl` or `wget` and network access to the repository. It downloads from the `main` branch raw URL and validates the file is a non-empty bash script before replacing itself.

## Failure modes

- No supported runtime installed
- `--docker` requested but `docker` is unavailable
- No `Containerfile` or `Dockerfile` found beside the script
- Container build or run command fails
- `--update` fails when `curl`/`wget` is unavailable, the download fails, or the file fails validation

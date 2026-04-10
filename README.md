# run-container.sh

`run-container.sh` builds and runs a local container image from the repository root.

## Download

```bash
curl -L -o run-container.sh https://raw.githubusercontent.com/aheimsbakk/run-container.sh/main/run-container.sh
chmod +x run-container.sh
```

Or with `wget`:

```bash
wget -O run-container.sh https://raw.githubusercontent.com/aheimsbakk/run-container.sh/main/run-container.sh
chmod +x run-container.sh
```

To update an existing installation:

```bash
./run-container.sh --update
```

## Requirements

- `podman` or `docker` installed
- A `Containerfile` or `Dockerfile` in the same directory as the script

## What it does

- Prefers `podman`; falls back to `docker`
- Uses `Containerfile` if present, otherwise `Dockerfile`
- Reuses an existing image by default
- Rebuilds only when the image is missing or `--force` / `--no-cache` is used
- Runs the container with `--rm`

## Usage

```bash
./run-container.sh [SCRIPT_OPTIONS] [RUNTIME_OPTIONS] [-- COMMAND_OPTIONS]
```

Options before `--` are passed to `podman run` or `docker run`.
Options after `--` are passed to the container command.

## Script options

- `-f`, `--force`: rebuild even if the image already exists
- `--no-cache`: rebuild without build cache; implies `--force`
- `--docker`: use `docker` even when `podman` is available
- `-n`, `--name NAME`: override the image name
- `--update`: self-update the script from the [source repository](https://github.com/aheimsbakk/run-container.sh.git) and exit
- `--license`: show license information and exit
- `-h`, `--help`: show help
- `-V`, `--version`: show script version

## Examples

Build if needed, then run:

```bash
./run-container.sh
```

Force a rebuild:

```bash
./run-container.sh --force
```

Pass runtime and command arguments separately:

```bash
./run-container.sh --rm -ti -v ./:/mnt -- sphinx-build -b html source public
```

Use a custom image name:

```bash
./run-container.sh --name docs-builder
```

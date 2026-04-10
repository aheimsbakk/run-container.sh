#!/usr/bin/env bash
set -euo pipefail

# Bump VERSION inside build-container.sh
# Usage: scripts/bump-version.sh [patch|minor|major]

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 [patch|minor|major]" >&2
	exit 2
fi

PART=$1
TARGET=build-container.sh

if [[ ! -f "$TARGET" ]]; then
	echo "Error: $TARGET not found" >&2
	exit 1
fi

# Extract current VERSION from the file (expects VERSION="x.y.z" at top-level)
CURRENT=$(grep -m1 '^VERSION="' "$TARGET" | sed -E 's/^VERSION="([0-9]+\.[0-9]+\.[0-9]+)"/\1/' || true)
if [[ -z "$CURRENT" ]]; then
	echo "Error: could not find VERSION in $TARGET" >&2
	exit 2
fi

IFS='.' read -r MAJ MIN PAT <<<"$CURRENT"
case "$PART" in
patch)
	PAT=$((PAT + 1))
	;;
minor)
	MIN=$((MIN + 1))
	PAT=0
	;;
major)
	MAJ=$((MAJ + 1))
	MIN=0
	PAT=0
	;;
*)
	echo "Unknown part: $PART" >&2
	exit 2
	;;
esac

NEW_VERSION="${MAJ}.${MIN}.${PAT}"

# Replace the VERSION line in-place
sed -E -i.bak "s/^VERSION=\"[0-9]+\.[0-9]+\.[0-9]+\"/VERSION=\"${NEW_VERSION}\"/" "$TARGET"
rm -f "${TARGET}.bak"
echo "$NEW_VERSION"

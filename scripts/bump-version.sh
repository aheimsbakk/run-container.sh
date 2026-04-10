#!/usr/bin/env bash
set -euo pipefail

# Simple version bump script for this repo
# Usage: scripts/bump-version.sh [patch|minor|major]

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 [patch|minor|major]" >&2
	exit 2
fi

PART=$1
FILE=opencode.json

if [[ ! -f "$FILE" ]]; then
	echo "Error: $FILE not found" >&2
	exit 1
fi

CURRENT=$(jq -r '.version' "$FILE")
if [[ "$CURRENT" == null ]]; then
	echo "Error: version key missing in $FILE" >&2
	exit 1
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
tmp=$(mktemp)
jq ".version = \"${NEW_VERSION}\"" "$FILE" >"$tmp" && mv "$tmp" "$FILE"
echo "$NEW_VERSION"

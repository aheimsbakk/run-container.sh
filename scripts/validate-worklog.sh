#!/usr/bin/env bash
set -euo pipefail

# Minimal validator: ensure the most recent worklog has required YAML front-matter keys
WORKLOG_DIR=docs/worklogs
if [[ ! -d "$WORKLOG_DIR" ]]; then
	echo "No worklogs directory" >&2
	exit 1
fi

LATEST=$(ls -1t "$WORKLOG_DIR" | head -n1)
if [[ -z "$LATEST" ]]; then
	echo "No worklog files found" >&2
	exit 1
fi

file="$WORKLOG_DIR/$LATEST"
content=$(sed -n '1,20p' "$file") || true

required=(when why what model tags)
for k in "${required[@]}"; do
	if ! grep -q -E "^$k:" "$file"; then
		echo "Missing required key: $k" >&2
		exit 2
	fi
done

echo "Worklog $LATEST looks valid"

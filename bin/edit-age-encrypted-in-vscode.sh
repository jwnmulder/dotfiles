#!/usr/bin/env bash

set -euo pipefail

ENCRYPTED_FILE="$1"

if [ ! -f "$ENCRYPTED_FILE" ]; then
  echo "$ENCRYPTED_FILE not found"
  exit 1
fi

BASE="${ENCRYPTED_FILE%.age}"
EXT="${BASE##*.}"
TMPFILE="/tmp/agefile.tmp.${EXT}"

chezmoi decrypt "$ENCRYPTED_FILE" > "$TMPFILE"; \
code --wait "$TMPFILE" && \
chezmoi encrypt "$TMPFILE" > "$ENCRYPTED_FILE"; \
rm "$TMPFILE"

#!/usr/bin/env bash

set -euo pipefail

ENCRYPTED_FILE="$1"

if [ ! -f "$ENCRYPTED_FILE" ]; then
  echo "$ENCRYPTED_FILE not found"
  exit 1
fi

chezmoi decrypt "$ENCRYPTED_FILE" > /tmp/agefile.tmp.yaml; \
code --wait /tmp/agefile.tmp.yaml && \
chezmoi encrypt /tmp/agefile.tmp.yaml > "$ENCRYPTED_FILE"; \
rm /tmp/agefile.tmp.yaml

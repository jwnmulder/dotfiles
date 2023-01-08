#!/usr/bin/env bash

set -euxo pipefail

ENCRYPTED_KEY="$1/.data/key.txt.age"
AGE_BIN=age
AGE_DOWNLOAD_URL="https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz"

if ! command -v "$AGE_BIN" &> /dev/null; then
    AGE_TMP_DIR="/tmp/age"
    rm -rf "$AGE_TMP_DIR"; mkdir -p "$AGE_TMP_DIR"
    curl -sL "$AGE_DOWNLOAD_URL" | tar -xz --strip-components 1 -C "$AGE_TMP_DIR"
    AGE_BIN="$AGE_TMP_DIR/age"
    chmod +x "$AGE_BIN"
fi

mkdir -p "${HOME}/.config/chezmoi"
echo Decrypt the age key by running: "$AGE_BIN" --decrypt --output "${HOME}/.config/chezmoi/key.txt" "$ENCRYPTED_KEY"

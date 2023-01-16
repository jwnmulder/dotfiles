#!/usr/bin/env bash

set -euo pipefail

architecture=""
case $(uname -m) in
    i386 | i686) architecture="386" ;;
    x86_64)      architecture="amd64" ;;
    arm)         dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
    *)           echo "No age crypto support for $(uname -m)"; exit 0 ;;
esac

ENCRYPTED_KEY="$1/.data/key.txt.age"
AGE_BIN=age
AGE_DOWNLOAD_URL="https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-${architecture}.tar.gz"

if ! command -v "$AGE_BIN" &> /dev/null; then
    AGE_TMP_DIR="/tmp/age"
    rm -rf "$AGE_TMP_DIR"; mkdir -p "$AGE_TMP_DIR"
    curl -sL "$AGE_DOWNLOAD_URL" | tar -xz --strip-components 1 -C "$AGE_TMP_DIR"
    AGE_BIN="$AGE_TMP_DIR/age"
    chmod +x "$AGE_BIN"
fi

mkdir -p "${HOME}/.config/chezmoi"
echo Decrypt the age key by running: "$AGE_BIN" --decrypt --output "${HOME}/.config/chezmoi/key.txt" "$ENCRYPTED_KEY"

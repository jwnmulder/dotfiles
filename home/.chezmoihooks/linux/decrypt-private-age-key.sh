#!/usr/bin/env bash

set -euo pipefail

if [ ! -f "${HOME}/.config/chezmoi/key.txt" ]; then
    mkdir -p "${HOME}/.config/chezmoi"

    echo "WARNING: Requesting decryption of age key. Please enter password and re-run chezmoi init to complete chezmoi.yaml data setup"
    "$CHEZMOI_EXECUTABLE" age decrypt --output "${HOME}/.config/chezmoi/key.txt" --passphrase "${HOME}/.local/share/chezmoi/home/.data/key.txt.age"
    chmod 600 "${HOME}/.config/chezmoi/key.txt"
fi

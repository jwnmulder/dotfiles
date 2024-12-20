#!/usr/bin/env bash

set -euo pipefail

if [ ! -f "${HOME}/.config/chezmoi/key.txt" ]; then
    mkdir -p "${HOME}/.config/chezmoi"

    env

    ls -la /__w/dotfiles/dotfiles/home/

    echo "Requesting decryption of age key. Please enter password"
    "$CHEZMOI_EXECUTABLE" age decrypt --output "${HOME}/.config/chezmoi/key.txt" --passphrase "${HOME}/.local/share/chezmoi/home/.data/key.txt.age"
    chmod 600 "${HOME}/.config/chezmoi/key.txt"
fi

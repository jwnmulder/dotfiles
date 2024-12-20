#!/usr/bin/env bash

set -euo pipefail

if [ ! -f "${HOME}/.config/chezmoi/key.txt" ]; then
    if [ -t 1 ]; then
        mkdir -p "${HOME}/.config/chezmoi"
        echo "Requesting decryption of age key. Please enter password"
        "$CHEZMOI_EXECUTABLE" age decrypt --output "${HOME}/.config/chezmoi/key.txt" --passphrase "${CHEZMOI_WORKING_TREE}/home/.data/key.txt.age"
        chmod 600 "${HOME}/.config/chezmoi/key.txt"
    else
        echo "WARNING: No TTY available to decrypt age key"
    fi
fi

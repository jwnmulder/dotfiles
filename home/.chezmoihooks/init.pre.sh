#!/usr/bin/env bash

set -euo pipefail

HOOKS_BASE_DIR="$CHEZMOI_SOURCE_DIR/.chezmoihooks"

action=""
decrypt_key="false"

while [[ "$#" -gt 0 ]]; do
    case $1 in
        read-source-state|init|update) action="$1" ;;
        --decrypt_key) decrypt_key="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "hook: action=$action, decrypt_key=$decrypt_key"

"$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh

if [ "$decrypt_key" == "true" ]; then
    "$HOOKS_BASE_DIR"/linux/decrypt-age-key.sh
fi

#!/usr/bin/env bash

set -euo pipefail

HOOKS_BASE_DIR="$CHEZMOI_SOURCE_DIR/.chezmoihooks"

action=""
decrypt_key="false"

while [[ "$#" -gt 0 ]]; do
    case $1 in
        read-source-state.*|init.*|update.*) action="$1" ;;
        --decrypt-key) decrypt_key="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done


if [ "${CHEZMOI_VERBOSE:-}" == 1 ]; then
    echo "hook: action=$action, decrypt-key=$decrypt_key"
fi

if [ "$action" == "read-source-state.pre" ]; then

    # check pre-requisites but do not exit on failure
    "$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh || true

    if [ "$decrypt_key" == "true" ]; then
        "$HOOKS_BASE_DIR"/linux/decrypt-age-key.sh
        "$HOOKS_BASE_DIR"/linux/decrypt-private-data.sh
    fi

fi

if [ "$action" == "init.pre" ]; then

    "$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh

    if [ "$decrypt_key" == "true" ]; then
        "$HOOKS_BASE_DIR"/linux/decrypt-age-key.sh
    fi
fi

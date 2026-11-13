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
    echo a
    "$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh || true
    echo b
    if [ "$decrypt_key" == "true" ]; then
        echo c
        "$HOOKS_BASE_DIR"/linux/decrypt-age-key.sh
        echo d
        "$HOOKS_BASE_DIR"/linux/decrypt-private-data.sh
        echo e
    fi
    echo f

fi

if [ "$action" == "init.pre" ]; then

    echo a1
    "$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh

    echo a2
    if [ "$decrypt_key" == "true" ]; then
        echo a3
        "$HOOKS_BASE_DIR"/linux/decrypt-age-key.sh
        echo a4
    fi
fi

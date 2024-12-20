#!/usr/bin/env bash

set -euo pipefail

HOOKS_BASE_DIR="$CHEZMOI_SOURCE_DIR/.chezmoihooks"

# "$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh
"$HOOKS_BASE_DIR"/linux/decrypt-age-key.sh

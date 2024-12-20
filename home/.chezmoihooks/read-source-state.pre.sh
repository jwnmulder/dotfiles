#!/usr/bin/env bash

set -euo pipefail

HOOKS_BASE_DIR="$CHEZMOI_SOURCE_DIR/.chezmoihooks"

# "$HOOKS_BASE_DIR"/linux/ensure-pre-requisites.sh
"$HOOKS_BASE_DIR"/linux/decrypt-private-age-key.sh
# "$HOOKS_BASE_DIR"/linux/decrypt-encrypted-data-files.sh

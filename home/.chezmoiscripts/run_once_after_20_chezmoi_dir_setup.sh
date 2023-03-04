#!/usr/bin/env bash

set -euo pipefail

cd "$(chezmoi source-path)"

# push via ssh
origin_push=$(git remote get-url --push origin)
origin_push="${origin_push/https:\/\/github.com\//git@github.com:}"

git remote set-url --push origin "$origin_push"

pre-commit install

#!/usr/bin/env bash

set -euo pipefail

# cleanup stale files
while IFS= read -r -d '' file; do
    rm "$file"
done < <(find "${CHEZMOI_WORKING_TREE}/home/.chezmoidata" -name "tmp*" -print0)

if [ -f "${HOME}/.config/chezmoi/key.txt" ]; then

    while IFS= read -r -d '' file; do

        if [ -f "$file" ]; then

            output_filename=$(basename "$file")
            output_filename="tmp${output_filename%.age}"

            output_file="${CHEZMOI_WORKING_TREE}/home/.chezmoidata/${output_filename}"

            "$CHEZMOI_EXECUTABLE" decrypt  "$file" > "$output_file"
        fi

    done < <(find "${CHEZMOI_WORKING_TREE}/home/.chezmoidata" -name ".*.yaml.age" -print0)
fi

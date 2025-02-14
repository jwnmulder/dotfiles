#!/bin/bash

# This script must exit as fast as possible when pre-requisites are already
# met, so we only import the scripts-library when we really need it.

set -eu

wanted_packages=(
  git  # used to init password-store
  curl # used in some chezmoi scripts
  gpg  # used for setting up gpg
  python3  # used for setting up python based tools
  pass  # used for setting up pass from which ssh keys can be installed
)

missing_packages=()

for package in "${wanted_packages[@]}"; do
  if ! command -v "${package}" >/dev/null; then
    missing_packages+=("${package}")
  fi
done

if [[ ${#missing_packages[@]} -eq 0 ]]; then
  exit 0
fi

echo "Missing packages that should be installed first: ${missing_packages[*]}"
echo "For Debian-based systems, you can install them with: sudo apt install ${missing_packages[*]}"
exit 1

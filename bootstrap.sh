#!/usr/bin/env zsh

set -euo pipefail

# Install Homebrew if not present
# https://brew.sh

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '✅ Relaunch shell to source env and continue'
else
  echo '✅ Homebrew already installed'
fi

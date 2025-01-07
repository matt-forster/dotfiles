#!/usr/bin/env zsh

set -euo pipefail

# https://github.com/DeterminateSystems/nix-installer

# May have to rerun if this is missing (as it doesn't get sourced the same everywhere)
if ! command -v nix &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
  echo '✅ Relaunch shell to source env and continue'
else
  echo '✅ Nix already installed'
fi

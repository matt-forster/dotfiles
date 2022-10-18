#!/usr/bin/env zsh

set -euo pipefail

# May have to rerun if this is missing (as it doesn't get sourced the same everywhere)
if ! command -v nix &>/dev/null; then
  sh <(curl -L https://nixos.org/nix/install)
  echo '✅ Relaunch shell to source env and continue'
else
  echo '✅ Nix already installed'
fi

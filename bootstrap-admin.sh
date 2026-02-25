#!/usr/bin/env zsh

set -euo pipefail

# ── Elevated / Admin Steps ──────────────────────────────────────────
# Run this script with admin privileges.
# It performs only the actions that require sudo.

# Install Homebrew if not present
# https://brew.sh

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '✅ Homebrew installed — relaunch shell to source env, then re-run'
  exit 0
else
  echo '✅ Homebrew already installed'
fi

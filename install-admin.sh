#!/usr/bin/env zsh

set -euo pipefail

# ── Elevated / Admin Steps ──────────────────────────────────────────
# Run this script with admin privileges.
# It performs only the actions that require sudo.

if ! command -v brew &>/dev/null; then
  echo 'fatal: brew not present, is it installed? Run bootstrap-admin.sh first.' >&2
  exit 1
fi

echo '⏳ Installing packages with Homebrew'
brew bundle --file="$HOME/Brewfile"

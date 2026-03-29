#!/usr/bin/env bash

set -euo pipefail

# ── Elevated / Admin Steps ──────────────────────────────────────────
# Run this script with admin privileges.
# It performs only the actions that require sudo.

OS="$(uname)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    echo 'fatal: brew not present, is it installed? Run bootstrap-admin.sh first.' >&2
    exit 1
  fi

  echo '⏳ Installing packages with Homebrew'
  brew bundle --file="$SCRIPT_DIR/Brewfile"

elif [[ "$OS" == "Linux" ]]; then
  echo '⏳ Installing packages for Linux'
  bash "$SCRIPT_DIR/install-linux.sh"

else
  echo "Unsupported OS: $OS" >&2
  exit 1
fi

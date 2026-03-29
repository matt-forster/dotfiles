#!/usr/bin/env bash

set -euo pipefail

# ── Elevated / Admin Steps ──────────────────────────────────────────
# Run this script with admin privileges.
# It performs only the actions that require sudo.

OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
  # Install Homebrew if not present
  # https://brew.sh
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo '✅ Homebrew installed — relaunch shell to source env, then re-run'
    exit 0
  else
    echo '✅ Homebrew already installed'
  fi

elif [[ "$OS" == "Linux" ]]; then
  echo '⏳ Installing apt prerequisites...'
  sudo apt-get update -qq
  sudo apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    gnupg \
    zsh \
    pinentry-curses \
    unzip
  echo '✅ apt prerequisites installed'

else
  echo "Unsupported OS: $OS" >&2
  exit 1
fi

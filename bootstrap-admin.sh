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
  if command -v apt-get &>/dev/null; then
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
  elif command -v dnf &>/dev/null; then
    echo '⏳ Installing dnf prerequisites...'
    CURL_PKG="curl"
    if rpm -q curl-minimal &>/dev/null; then
      CURL_PKG=""
    fi
    sudo dnf install -y \
      ${CURL_PKG:+"$CURL_PKG"} \
      wget \
      git \
      gnupg2 \
      zsh \
      unzip
    echo '✅ dnf prerequisites installed'
  else
    echo "No supported package manager (apt-get, dnf) found." >&2
    exit 1
  fi

else
  echo "Unsupported OS: $OS" >&2
  exit 1
fi

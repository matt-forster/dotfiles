#!/usr/bin/env bash

set -euo pipefail

# Single entry point for machine setup.
# Run as your user — sudo is called internally where needed.
#
# Usage: ./setup.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
  echo 'fatal: run as your user, not root — sudo will be called where needed.' >&2
  exit 1
fi

OS="$(uname)"

# ── Step 1: System prerequisites ────────────────────────────────────
echo ''
echo '── 1/4: System prerequisites ───────────────────────────────────'

if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Source brew immediately so subsequent steps can use it
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
    echo '✅ Homebrew installed'
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
fi

# ── Step 2: GPG ──────────────────────────────────────────────────────
echo ''
echo '── 2/4: GPG setup ──────────────────────────────────────────────'

if [[ "$OS" == "Darwin" ]]; then
  brew install gnupg
  brew install pinentry-mac
  echo '✅ GnuPG installed'
else
  echo '✅ GnuPG already installed'
fi

echo '⏳ Importing GPG public key'
curl -sSL https://key.mattforster.ca/gpg.pub | gpg --import -
KEY_FP='D2F68FD439072E33659E495B8B5A4B24F610E234'
echo "${KEY_FP}:5:" | gpg --import-ownertrust
echo '✅ GPG key imported and trusted'

# ── Step 3: Packages ─────────────────────────────────────────────────
echo ''
echo '── 3/4: Packages ───────────────────────────────────────────────'

if [[ "$OS" == "Darwin" ]]; then
  echo '⏳ Installing packages with Homebrew'
  brew bundle --file="$SCRIPT_DIR/Brewfile"
elif [[ "$OS" == "Linux" ]]; then
  bash "$SCRIPT_DIR/install-linux.sh"
fi

# ── Step 4: Dotfiles & user tools ────────────────────────────────────
echo ''
echo '── 4/4: Dotfiles & user tools ──────────────────────────────────'
cd

echo '⏳ Installing dotfiles with chezmoi'
if command -v chezmoi &>/dev/null && [ -d "$HOME/.local/share/chezmoi" ]; then
  chezmoi apply
else
  sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/matt-forster/dotfiles.git
fi

echo '⏳ Installing Volta'
curl https://get.volta.sh | bash

echo '⏳ Installing Antidote'
if [ -d ~/.antidote ]; then
  git -C ~/.antidote pull
else
  git clone https://github.com/mattmc3/antidote.git ~/.antidote
fi
zsh -c 'source ~/.antidote/antidote.zsh && antidote bundle < ~/.config/zsh/.zsh_plugins.txt > ~/.config/zsh/.zsh_plugins.zsh'

echo ''
echo '✅ Setup complete!'
if [[ "$OS" == "Linux" ]]; then
  echo ''
  echo 'Notes:'
  echo '  - Re-login or run: newgrp docker    (for Docker group membership)'
  echo '  - npm globals (bitwarden-cli, etc.) can be installed after Volta is set up'
fi

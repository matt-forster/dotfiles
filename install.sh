#!/usr/bin/env bash

# kinda just run it until it works

set -euo pipefail
cd

# ── User Steps ──────────────────────────────────────────────────────
# Run install-admin.sh first to install packages.

OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    echo 'fatal: brew not present, is it installed? Run bootstrap-admin.sh first.' >&2
    exit 1
  fi
fi

echo '⏳ Installing dotfiles with chezmoi'
if command -v chezmoi &>/dev/null && [ -d "$HOME/.local/share/chezmoi" ]; then
  chezmoi apply --force
else
  sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply --force https://github.com/matt-forster/dotfiles.git
fi

if ! command -v mise &>/dev/null; then
  echo '⏳ Installing mise'
  mkdir -p "$HOME/.local/bin"
  curl https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
  export PATH="$HOME/.local/bin:$PATH"
fi

echo '⏳ Installing mise-managed tools'
mise install

# ── System packages (if running with sudo access) ───────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$OS" == "Linux" ]]; then
  if command -v apt-get &>/dev/null; then
    echo '⏳ Installing system packages (apt)'
    bash "$SCRIPT_DIR/install-linux.sh"
  elif command -v dnf &>/dev/null; then
    echo '⏳ Installing system packages (dnf)'
    bash "$SCRIPT_DIR/install-fedora.sh"
  fi
fi

echo '⏳ Installing Antidote'
if [ -d ~/.antidote ]; then
  git -C ~/.antidote pull
else
  git clone https://github.com/mattmc3/antidote.git ~/.antidote
fi
zsh -c 'source ~/.antidote/antidote.zsh && antidote bundle < ~/.config/zsh/.zsh_plugins.txt > ~/.config/zsh/.zsh_plugins.zsh'

echo '✅ Done'

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
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/matt-forster/dotfiles.git

echo '⏳ Installing Volta'
curl https://get.volta.sh | bash

echo '⏳ Installing Antidote'
if [ -d ~/.antidote ]; then
  git -C ~/.antidote pull
else
  git clone https://github.com/mattmc3/antidote.git ~/.antidote
fi
zsh -c 'source ~/.antidote/antidote.zsh && antidote bundle < ~/.config/zsh/.zsh_plugins.txt > ~/.config/zsh/.zsh_plugins.zsh'

echo '✅ Done'

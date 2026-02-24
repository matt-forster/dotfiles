#!/usr/bin/env zsh

# kinda just run it until it works

set -euo pipefail
cd

if ! command -v brew &>/dev/null; then
  echo 'fatal: brew not present, is it installed? Run bootstrap.sh first.' >&2
  exit 1
fi

echo '⏳ Installing dotfiles with chezmoi'
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/matt-forster/dotfiles.git

echo '⏳ Installing packages with Homebrew'
brew bundle --file="$HOME/Brewfile"

echo '⏳ Installing Volta'
curl https://get.volta.sh | bash

echo '⏳ Installing Antidote'
git clone https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh

antidote bundle ~/.zsh/zsh_plugins.txt > ~/.zsh/zsh_plugins.zsh

echo '✅ Done'

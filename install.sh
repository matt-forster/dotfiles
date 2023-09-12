#!/usr/bin/env zsh

# kinda just run it until it works

set -euo pipefail
cd

if command -v nix &>/dev/null; then
  : # ok, do nothing
elif [[ -e /run/current-system/sw/bin/nix ]]; then
  echo 'notice: nix install seems partly broken, working-around' >&2
  export PATH=$PATH:/run/current-system/sw/bin
else
  fatal 'nix not present, is it installed?'
fi

echo '⏳ Installing Home Manager'
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
echo '⌛️ Home Manager installed'

sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/matt-forster/dotfiles.git

curl https://get.volta.sh | bash

git clone https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh

antidote bundle ~/.zsh/zsh_plugins.txt > ~/.zsh/zsh_plugins.zsh

nix-collect-garbage
echo '✅ Done'

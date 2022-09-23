#! /usr/bin/env zsh
cd

# BEFORE
# sudo apt install zsh
# command -v zsh | sudo tee -a /etc/shells
# chsh -s $(which zsh) $USER

# for vscode, because unix soapbox
export NIXPKGS_ALLOW_UNFREE=1

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

git clone https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh

curl https://get.volta.sh | bash

sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/matt-forster/dotfiles.git

antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh

nix-collect-garbage

#! /usr/bin/env zsh
cd

sh -c "$(curl -fsLS chezmoi.io/get)" -- init matt-forster --apply --force
sh <(curl -L https://nixos.org/nix/install)
source ~/.nix-profile/etc/profile.d/nix.sh

nix-env -iA nixpkgs.jq
nix-env -iA nixpkgs.socat
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.fzf
nix-env -iA nixpkgs.bat
nix-env -iA nixpkgs.git-extras
nix-env -iA nixpkgs.terraform
nix-env -iA nixpkgs.vault
nix-env -iA nixpkgs.packer
nix-env -iA nixpkgs.neovim
nix-env -iA nixpkgs.gopass
nix-env -iA nixpkgs.diff-so-fancy

git clone https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh

antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh

curl https://get.volta.sh | bash 

nix-collect-garbage
# command -v zsh | sudo tee -a /etc/shells
# chsh -s $(which zsh) $USER

#! /usr/bin/env zsh
cd

# BEFORE
# sudo apt install zsh
# command -v zsh | sudo tee -a /etc/shells
# chsh -s $(which zsh) $USER

# for vscode, because unix soapbox
export NIXPKGS_ALLOW_UNFREE=1

# May have to rerun if this is missing (as it doesn't get sourced the same everywhere)
if ! type nix-env >/dev/null 2>&1; then
  sh <(curl -L https://nixos.org/nix/install)
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

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
nix-env -iA nixpkgs.postgresql
nix-env -iA nixpkgs.pgcli
nix-env -iA nixpkgs.sampler
nix-env -iA nixpkgs.stow
nix-env -iA nixpkgs.tz
nix-env -iA nixpkgs.git-revise
nix-env -iA nixpkgs.deno
nix-env -iA nixpkgs.curl
nix-env -iA nixpkgs.awscli2
nix-env -iA nixpkgs.gh
nix-env -iA nixpkgs.silver-searcher
nix-env -iA nixpkgs.go
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.vscode
nix-env -iA nixpkgs.starship

git clone https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh

curl https://get.volta.sh | bash

sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/matt-forster/dotfiles.git

antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh

nix-collect-garbage

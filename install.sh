#! /bin/bash
cd

sh <(curl -L https://nixos.org/nix/install)
. ~/.nix-profile/etc/profile.d/nix.sh

nix-env -iA nixpkgs.socat
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.zsh
nix-env -iA nixpkgs.stow
nix-env -iA nixpkgs.fzf
nix-env -iA nixpkgs.bat
nix-env -iA nixpkgs.git-extras
nix-env -iA nixpkgs.terraform
nix-env -iA nixpkgs.vault
nix-env -iA nixpkgs.packer

sh -c "$(curl -fsLS chezmoi.io/get)" -- init matt-forster --apply

wget https://github.com/gopasspw/gopass/releases/download/v1.14.2/gopass_1.14.2_linux_amd64.deb ~
wget -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage ~
git clone https://github.com/mattmc3/antidote.git ~/.antidote
git clone https://github.com/so-fancy/diff-so-fancy.git ~/.local/share/diff-so-fancy

sudo dpkg -i gopass_1.14.2_linux_amd64.deb
chmod u+x nvim.appimage
mv ./nvim.appimage .local/bin/nvim
ln -s ~/.local/share/diff-so-fancy/diff-so-fancy ~/.local/bin/diff-so-fancy

curl https://get.volta.sh | bash 
volta install node

# command -v zsh | sudo tee -a /etc/shells
# chsh -s $(which zsh) $USER

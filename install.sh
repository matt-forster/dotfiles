#! /bin/bash
cd

sudo apt-get install coreutils build-essential curl git autoload compctl

sh -c "$(curl -fsLS chezmoi.io/get)" -- init matt-forster --apply
sh <(curl -L https://nixos.org/nix/install)

wget https://github.com/gopasspw/gopass/releases/download/v1.14.2/gopass_1.14.2_linux_amd64.deb ~
sudo dpkg -i gopass_1.14.2_linux_amd64.deb
rm gopass_1.14.2_linux_amd64.deb

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage .local/bin/nvim

[ -f ~/.antidote ] && git clone https://github.com/mattmc3/antidote.git ~/.antidote

[ -f ~/local/share/diff-so-fancy ] && git clone https://github.com/so-fancy/diff-so-fancy.git ~/.local/share/diff-so-fancy
ln -s ~/.local/share/diff-so-fancy/diff-so-fancy ~/.local/bin/diff-so-fancy

[ -f ~/.volta ] && curl https://get.volta.sh | bash 
volta install node

nix-env -iA nixpkgs.git-extras
nix-env -iA nixpkgs.terraform
nix-env -iA nixpkgs.vault
nix-env -iA nixpkgs.packer


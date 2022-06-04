#! /bin/bash
cd

sh -c "$(curl -fsLS chezmoi.io/get)" -- init matt-forster --apply

apt-get install coreutils build-essential curl git autoload compctl

wget https://github.com/gopasspw/gopass/releases/download/v1.14.2/gopass_1.14.2_linux_amd64.deb ~
sudo dpkg -i gopass_1.14.2_linux_amd64.deb
rm gopass_1.14.2_linux_amd64.deb

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage .local/bin/nvim

[[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote

[[ -e ~/local/share/diff-so-fancy ]] || git clone https://github.com/so-fancy/diff-so-fancy.git ~/.local/share/diff-so-fancy
ln -s ~/.local/share/diff-so-fancy/diff-so-fancy ~/.local/bin/diff-so-fancy

[[ -e ~/.linuxbrew ]] || /bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

[[ -e ~/.volta ]] || curl https://get.volta.sh | bash 
volta install node

[[ -e ~/.asdf ]] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
asdf update

brew install git-extras
brew install the_silver_searcher

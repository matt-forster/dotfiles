#! /bin/bash
cd

# Dependencies and packages

apt-get install coreutils build-essential curl git

wget https://github.com/gopasspw/gopass/releases/download/v1.14.2/gopass_1.14.2_linux_amd64.deb
sudo dpkg -i gopass_1.14.2_linux_amd64.deb
rm gopass_1.14.2_linux_amd64.deb

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage .local/bin/nvim

curl https://get.volta.sh | bash 

curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0

git clone https://github.com/so-fancy/diff-so-fancy.git ~/.local/share/diff-so-fancy
ln -s ~/.local/share/diff-so-fancy/diff-so-fancy ~/.local/bin/diff-so-fancy

# Install 

sh -c "$(curl -fsLS chezmoi.io/get)" -- init -v matt-forster --apply

volta install node

asdf update


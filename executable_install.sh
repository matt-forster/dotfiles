#! /bin/bash
cd

# Dependencies and packages

apt-get install coreutils build-essential curl git

wget https://github.com/gopasspw/gopass/releases/download/v1.14.2/gopass_1.14.2_linux_amd64.deb
sudo dpkg -i gopass_1.14.2_linux_amd64.deb

curl https://get.volta.sh | bash 

curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

# Install 

sh -c "$(curl -fsLS chezmoi.io/get)" -- init -v matt-forster --apply

volta install node

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
asdf update


# Environment and Dotfiles

## Notes from last WSL clean install - have to auth and setup SSH first

- https://github.com/rupor-github/win-gpg-agent was still the way to go, but make sure to restart after win works? Don't install random stuff or else it will make it harder
- Order of operations:
    - [windows/wsl] Set up windows GPG
    - [windows/wsl] set up win-gpg-agent
    - [linux] import ssh key from yubikey
        - `curl -sSL https://key.mattforster.ca/gpg.pub | gpg --import -`
    - [linux] create winhome symlink
        - `ln -s /mnt/c/Users/matt/ ~/winhome`
    - [linux] run gpg agent script
        - [win-gpg-agent-relay.sh](https://github.com/matt-forster/dotfiles/blob/main/private_dot_ssh/executable_win-gpg-agent-relay.sh)
        - `export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh`
    - [linux] install zsh
        - https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
    - [linux] run install script after cloning dotfiles repo

## Setup pass in a new environment

1. Make sure GPG is set up + key is fetched
2. `gopass clone`

# GPG Maintenance

## Creating a new key

https://chipsenkbeil.com/posts/applying-gpg-and-yubikey-part-2-setup-primary-gpg-key/

```bash
gpg --full-generate-key
Type: RSA and RSA (default)
Length: 4096
Valid for: 3y
```

## Maintenance

1. Extend master expiry?
2. Recreate subkeys
3. add to card

```bash
gpg --expert --edit-key security@mattforster.ca
key 0
expire
key 0
addkey
key 1
keytocard
key 1
# repeat for other keys
```#

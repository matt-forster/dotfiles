# Environment and Dotfiles


## Notes from last clean install

- https://github.com/rupor-github/win-gpg-agent was still the way to go, but make sure to restart after win works? Don't install random stuff or else it will make it harder
- Order of operations:
    - [windows] Set up windows GPG
    - [windows] set up win-gpg-agent
    - [linux] install coreutils, build-essential, socat
    - [linux] Install Go
    - [linux] install gopass - alias to pass by symlink gopass -> pass
    - [linux] install volta
    - [linux] install asdf
    - [linux] install antibody
    - [linux] get dotfiles from q
    - [linux] get local dotfiles using chezmoi

## Setup pass in a new environment

1. Make sure GPG is set up + key is fetched
2. `g clone gh:matt-forster/passwords ~/.password-store`
3. `pass init security@mattforster.ca`

## Adding dotfiles to new environment:

1. Setup pass repo
2. `sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply matt-forster`

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

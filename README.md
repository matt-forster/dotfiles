# Environment and Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/) and [Homebrew](https://brew.sh/).

## Steps

1. Clone public dotfiles repo
1. Run bootstrap script (installs Homebrew, GnuPG, imports GPG keys)
1. Run install script (installs chezmoi, dotfiles, packages)
1. [Mac] Verify ssh-agent is configured
1. [Windows] Setup win-gpg-agent / https://github.com/demonbane/wsl-gpg-systemd
1. Probably a bunch of other steps, it never works quite right

Useful commands;

- `brew bundle check || brew bundle install`
- `brew bundle cleanup`
- `chezmoi apply`

## Setup pass in a new environment

1. Make sure GPG is set up + key is fetched
1. `gopass clone`

## GPG Maintenance

### Creating a new key

<https://chipsenkbeil.com/posts/applying-gpg-and-yubikey-part-2-setup-primary-gpg-key/>

```bash
gpg --full-generate-key
Type: RSA and RSA (default)
Length: 4096
Valid for: 3y
```

### Maintenance

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

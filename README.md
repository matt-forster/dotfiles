# Environment and Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Steps

```bash
./setup.sh
```

Run as your user — sudo is called internally where needed. Re-run at any time; all steps are idempotent.

### Individual scripts

- `install-linux.sh` — re-run to update/install packages on Linux
- `Brewfile` + `brew bundle` — manage packages on macOS

### Work machines

Add to `~/.config/chezmoi/chezmoi.toml` to enable Colima/Docker socket configuration:

```toml
[data]
  isWork = true
```
1. [Windows] Setup win-gpg-agent / https://github.com/demonbane/wsl-gpg-systemd
1. Probably a bunch of other steps, it never works quite right

### Work machines

On work machines, add the following to `~/.config/chezmoi/chezmoi.toml` to enable Colima/Docker socket configuration:

```toml
[data]
  isWork = true
```

Useful commands:

- `brew bundle check || brew bundle install`  (macOS)
- `brew bundle cleanup`                        (macOS)
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
```

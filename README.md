# Environment and Dotfiles

## Steps

1. Clone public dotfiles repo
1. Install GPG and fetch keys
  
- `curl -sSL https://key.mattforster.ca/gpg.pub | gpg --import -`
- Trust keys `gpg --edit-key [key-id]`
- [Mac] Setup ssh-agent
- [Windows] Setup win-gpg-agent
- [Windows] https://github.com/demonbane/wsl-gpg-systemd

1. Run bootstrap script (env agnostic)
1. Run install script (env agnostic)
1. [optional] install brew, if absolutely needed
1. Probably a bunch of other steps, it never works quite right

Useful commands;

- `home-manager switch`
- `brew bundle cleanup && brew bundle check || brew bundle install`

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

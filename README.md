# Environment and Dotfiles

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

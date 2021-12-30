# Creating a new key

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

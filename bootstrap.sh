#!/usr/bin/env zsh

set -euo pipefail

# Install Homebrew if not present
# https://brew.sh

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '✅ Homebrew installed — relaunch shell to source env, then re-run'
  exit 0
else
  echo '✅ Homebrew already installed'
fi

# Install gnupg early — needed before chezmoi can decrypt templates
brew install gnupg
if [[ "$(uname)" == "Darwin" ]]; then
  brew install pinentry-mac
fi
echo '✅ GnuPG installed'

# Import public key
echo '⏳ Importing GPG public key'
curl -sSL https://key.mattforster.ca/gpg.pub | gpg --import -

# Trust the key ultimately (owner trust level 5)
KEY_FP=$(gpg --list-keys --with-colons hey@mattforster.ca 2>/dev/null \
  | awk -F: '/^fpr:/{print $10; exit}')
if [[ -n "$KEY_FP" ]]; then
  echo "${KEY_FP}:5:" | gpg --import-ownertrust
  echo '✅ GPG key imported and trusted'
else
  echo '⚠️  GPG key import succeeded but fingerprint lookup failed — trust manually with: gpg --edit-key <key-id>'
fi

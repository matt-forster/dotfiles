#!/usr/bin/env zsh

set -euo pipefail

# ── User Steps ──────────────────────────────────────────────────────
# Run bootstrap-admin.sh first to install Homebrew.

if ! command -v brew &>/dev/null; then
  echo 'fatal: brew not present, is it installed? Run bootstrap-admin.sh first.' >&2
  exit 1
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
KEY_FP='D2F68FD439072E33659E495B8B5A4B24F610E234'
echo "${KEY_FP}:5:" | gpg --import-ownertrust
echo '✅ GPG key imported and trusted'

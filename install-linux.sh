#!/usr/bin/env bash

set -euo pipefail

# ── Linux Package Installation ──────────────────────────────────────
# Installs packages via apt and direct binary downloads.
# Run with sudo / as a user with sudo privileges.

BIN_DIR="/usr/local/bin"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

latest_release() {
  curl -fsSL "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name"' | cut -d'"' -f4
}

echo '⏳ Updating apt...'
sudo apt-get update -qq

# ── apt packages ────────────────────────────────────────────────────
echo '⏳ Installing apt packages...'
sudo apt-get install -y \
  cmake \
  curl \
  git \
  git-extras \
  gnupg \
  gopass \
  graphviz \
  jq \
  lcov \
  libfido2-1 \
  libssh-4 \
  openssh-client \
  pgcli \
  pinentry-curses \
  postgresql-client \
  silversearcher-ag \
  socat \
  stow \
  tmux \
  wget \
  zsh

# ── mise ────────────────────────────────────────────────────────────
if ! command -v mise &>/dev/null; then
  echo '⏳ Installing mise...'
  mkdir -p "$HOME/.local/bin"
  curl -fsSL https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
  export PATH="$HOME/.local/bin:$PATH"
  echo '✅ mise installed'
fi

# ── diff-so-fancy ───────────────────────────────────────────────────
if ! command -v diff-so-fancy &>/dev/null; then
  echo '⏳ Installing diff-so-fancy...'
  if [ -d /usr/local/lib/diff-so-fancy ]; then
    sudo git -C /usr/local/lib/diff-so-fancy pull
  else
    sudo git clone --depth=1 https://github.com/so-fancy/diff-so-fancy.git /usr/local/lib/diff-so-fancy
  fi
  sudo ln -sf /usr/local/lib/diff-so-fancy/diff-so-fancy "$BIN_DIR/diff-so-fancy"
  echo '✅ diff-so-fancy installed'
fi

# ── GitHub CLI ──────────────────────────────────────────────────────
if ! command -v gh &>/dev/null; then
  echo '⏳ Installing GitHub CLI...'
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y gh
  echo '✅ GitHub CLI installed'
fi

# ── Docker ──────────────────────────────────────────────────────────
if ! command -v docker &>/dev/null; then
  echo '⏳ Installing Docker...'
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
  echo '✅ Docker installed (re-login required for group membership)'
fi

# ── Buildkite agent ─────────────────────────────────────────────────
if ! command -v buildkite-agent &>/dev/null; then
  echo '⏳ Installing Buildkite agent...'
  curl -fsSL "https://keys.openpgp.org/vks/v1/by-fingerprint/32A37959C2FA5C3C99EFBC32A79206696452D198" \
    | sudo gpg --dearmor -o /usr/share/keyrings/buildkite-agent-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/buildkite-agent-archive-keyring.gpg] https://apt.buildkite.com/buildkite-agent stable main" \
    | sudo tee /etc/apt/sources.list.d/buildkite-agent.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y buildkite-agent
  echo '✅ Buildkite agent installed'
fi

echo ''
echo '✅ Linux packages installed'
echo ''
echo 'Notes:'
echo '  - Re-login or run: newgrp docker    (for Docker group membership)'
echo '  - Developer tool versions are managed by mise; run: mise install'

#!/usr/bin/env bash

set -euo pipefail

# ── Fedora / Amazon Linux (dnf) Package Installation ────────────────
# Installs packages available in dnf repos and direct binary downloads.
# Run with sudo / as a user with sudo privileges.

BIN_DIR="/usr/local/bin"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

latest_release() {
  curl -fsSL "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name"' | cut -d'"' -f4
}

echo '⏳ Installing dnf packages...'
sudo dnf install -y \
  cmake \
  curl \
  git \
  gnupg2 \
  graphviz \
  jq \
  lcov \
  libatomic \
  postgresql15 \
  socat \
  tmux \
  util-linux-user \
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
  VERSION=$(latest_release cli/cli)
  curl -fsSL "https://github.com/cli/cli/releases/download/${VERSION}/gh_${VERSION#v}_linux_amd64.tar.gz" \
    | tar -C "$TMP" -xz --strip-components=1
  sudo install "$TMP/bin/gh" "$BIN_DIR/gh"
  echo '✅ GitHub CLI installed'
fi

# ── Docker ──────────────────────────────────────────────────────────
if ! command -v docker &>/dev/null; then
  echo '⏳ Installing Docker...'
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
  echo '✅ Docker installed (re-login required for group membership)'
fi

# ── kubectl ─────────────────────────────────────────────────────────
if ! command -v kubectl &>/dev/null; then
  echo '⏳ Installing kubectl...'
  K8S_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
  curl -fsSL "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl" -o "$TMP/kubectl"
  sudo install -m 0755 "$TMP/kubectl" "$BIN_DIR/kubectl"
  echo '✅ kubectl installed'
fi

# ── AWS CLI v2 ──────────────────────────────────────────────────────
if ! command -v aws &>/dev/null; then
  echo '⏳ Installing AWS CLI...'
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$TMP/awscliv2.zip"
  unzip -q "$TMP/awscliv2.zip" -d "$TMP"
  sudo "$TMP/aws/install"
  echo '✅ AWS CLI installed'
fi

# ── Buildkite agent ─────────────────────────────────────────────────
if ! command -v buildkite-agent &>/dev/null; then
  echo '⏳ Installing Buildkite agent...'
  VERSION=$(latest_release buildkite/agent)
  curl -fsSL "https://github.com/buildkite/agent/releases/download/${VERSION}/buildkite-agent-linux-amd64-${VERSION#v}.tar.gz" \
    | tar -C "$TMP" -xz
  sudo install "$TMP/buildkite-agent" "$BIN_DIR/buildkite-agent"
  echo '✅ Buildkite agent installed'
fi

echo ''
echo '✅ Fedora/AL2023 packages installed'
echo ''
echo 'Notes:'
echo '  - Re-login or run: newgrp docker    (for Docker group membership)'
echo '  - Developer tool versions are managed by mise; run: mise install'

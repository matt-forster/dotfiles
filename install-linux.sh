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
  bat \
  cmake \
  curl \
  direnv \
  ffmpeg \
  fzf \
  git \
  git-extras \
  gnupg \
  gopass \
  graphviz \
  jq \
  lcov \
  libfido2-1 \
  libssh-4 \
  neovim \
  openssh-client \
  pgcli \
  pinentry-curses \
  postgresql-client \
  ripgrep \
  silversearcher-ag \
  socat \
  stow \
  tmux \
  wget \
  zsh

# bat is named batcat on Ubuntu — create a local symlink
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
fi

# ── diff-so-fancy ───────────────────────────────────────────────────
if ! command -v diff-so-fancy &>/dev/null; then
  echo '⏳ Installing diff-so-fancy...'
  sudo curl -fsSL https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy \
    -o "$BIN_DIR/diff-so-fancy"
  sudo chmod +x "$BIN_DIR/diff-so-fancy"
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

# ── Go ──────────────────────────────────────────────────────────────
if ! command -v go &>/dev/null; then
  echo '⏳ Installing Go...'
  GO_VERSION=$(curl -fsSL "https://go.dev/VERSION?m=text" | head -1)
  curl -fsSL "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" | sudo tar -C /usr/local -xz
  sudo tee /etc/profile.d/go.sh > /dev/null <<'EOF'
export PATH=$PATH:/usr/local/go/bin
EOF
  export PATH="$PATH:/usr/local/go/bin"
  echo '✅ Go installed'
fi

# ── Docker ──────────────────────────────────────────────────────────
if ! command -v docker &>/dev/null; then
  echo '⏳ Installing Docker...'
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
  echo '✅ Docker installed (re-login required for group membership)'
fi

# ── Starship prompt ─────────────────────────────────────────────────
if ! command -v starship &>/dev/null; then
  echo '⏳ Installing Starship...'
  curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
  echo '✅ Starship installed'
fi

# ── bottom (btm) ────────────────────────────────────────────────────
if ! command -v btm &>/dev/null; then
  echo '⏳ Installing bottom...'
  VERSION=$(latest_release ClementTsang/bottom)
  curl -fsSL "https://github.com/ClementTsang/bottom/releases/download/${VERSION}/bottom_${VERSION#v}_amd64.deb" \
    -o "$TMP/bottom.deb"
  sudo dpkg -i "$TMP/bottom.deb"
  echo '✅ bottom installed'
fi

# ── lazygit ─────────────────────────────────────────────────────────
if ! command -v lazygit &>/dev/null; then
  echo '⏳ Installing lazygit...'
  VERSION=$(latest_release jesseduffield/lazygit)
  curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/${VERSION}/lazygit_${VERSION#v}_Linux_x86_64.tar.gz" \
    | tar -C "$TMP" -xz lazygit
  sudo install "$TMP/lazygit" "$BIN_DIR/lazygit"
  echo '✅ lazygit installed'
fi

# ── k9s ─────────────────────────────────────────────────────────────
if ! command -v k9s &>/dev/null; then
  echo '⏳ Installing k9s...'
  VERSION=$(latest_release derailed/k9s)
  curl -fsSL "https://github.com/derailed/k9s/releases/download/${VERSION}/k9s_Linux_amd64.tar.gz" \
    | tar -C "$TMP" -xz k9s
  sudo install "$TMP/k9s" "$BIN_DIR/k9s"
  echo '✅ k9s installed'
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

# ── actionlint ──────────────────────────────────────────────────────
if ! command -v actionlint &>/dev/null; then
  echo '⏳ Installing actionlint...'
  VERSION=$(latest_release rhysd/actionlint)
  curl -fsSL "https://github.com/rhysd/actionlint/releases/download/${VERSION}/actionlint_${VERSION#v}_linux_amd64.tar.gz" \
    | tar -C "$TMP" -xz actionlint
  sudo install "$TMP/actionlint" "$BIN_DIR/actionlint"
  echo '✅ actionlint installed'
fi

# ── tfswitch ────────────────────────────────────────────────────────
if ! command -v tfswitch &>/dev/null; then
  echo '⏳ Installing tfswitch...'
  curl -fsSL https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
  echo '✅ tfswitch installed'
fi

# ── Deno ────────────────────────────────────────────────────────────
if ! command -v deno &>/dev/null; then
  echo '⏳ Installing Deno...'
  curl -fsSL https://deno.land/install.sh | sh
  echo '✅ Deno installed'
fi

# ── asdf ────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.asdf" ]; then
  echo '⏳ Installing asdf...'
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf"
  echo '✅ asdf installed'
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
echo '  - npm globals (bitwarden-cli, etc.) can be installed after Volta is set up'

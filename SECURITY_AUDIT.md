# Security Audit — Dotfiles Tool Inventory

> **Purpose:** Comprehensive inventory of every tool, binary, plugin, and external
> dependency installed or referenced by this dotfiles repository. Intended for
> security teams maintaining software/binary scanning exclusion lists.
>
> **Management stack:** [chezmoi](https://www.chezmoi.io/) (dotfile manager) +
> [Homebrew](https://brew.sh/) (package manager) on macOS / Linux.

---

## Table of Contents

1. [Homebrew Taps](#1-homebrew-taps)
2. [Homebrew Formulae](#2-homebrew-formulae)
3. [Externally Downloaded Tools](#3-externally-downloaded-tools)
4. [Zsh Plugin Manager & Plugins](#4-zsh-plugin-manager--plugins)
5. [Custom Shell Scripts](#5-custom-shell-scripts-bin)
6. [Optional / Conditionally Loaded Tools](#6-optional--conditionally-loaded-tools)
7. [External Services Contacted at Runtime](#7-external-services-contacted-at-runtime)

---

## 1. Homebrew Taps

These are third-party or built-in Homebrew tap repositories enabled in the
[`Brewfile`](Brewfile).

| Tap | Purpose |
|-----|---------|
| `homebrew/bundle` | Enables `brew bundle` (Brewfile support) |
| `homebrew/services` | Enables `brew services` (service management) |

---

## 2. Homebrew Formulae

All packages below are installed via `brew bundle --file=Brewfile`. Versions are
managed by Homebrew and update with `brew upgrade`.

| Formula | Description | Homepage | Network Access |
|---------|-------------|----------|----------------|
| `awscli` | AWS command-line interface | https://aws.amazon.com/cli/ | Yes — AWS API |
| `bat` | Cat clone with syntax highlighting and Git integration | https://github.com/sharkdp/bat | No |
| `bottom` | Cross-platform graphical process/system monitor | https://github.com/ClementTsang/bottom | No |
| `chezmoi` | Manage dotfiles across multiple machines | https://www.chezmoi.io/ | Yes — fetches dotfiles repo on init |
| `circleci` | CircleCI command-line interface | https://circleci.com/docs/local-cli/ | Yes — CircleCI API |
| `cmake` | Cross-platform build system generator | https://cmake.org/ | No |
| `curl` | Command-line HTTP/HTTPS client | https://curl.se/ | Yes — user-directed |
| `deno` | Secure JavaScript/TypeScript runtime | https://deno.land/ | Yes — module downloads |
| `diff-so-fancy` | Human-readable diff output for Git | https://github.com/so-fancy/diff-so-fancy | No |
| `direnv` | Per-directory environment variable loader | https://direnv.net/ | No |
| `docker` | Container runtime (CLI component) | https://www.docker.com/ | Yes — Docker Hub / registries |
| `docker-compose` | Multi-container Docker orchestration | https://docs.docker.com/compose/ | Yes — Docker Hub / registries |
| `ffmpeg` | Multimedia framework (audio/video processing) | https://ffmpeg.org/ | No (unless streaming) |
| `fzf` | General-purpose command-line fuzzy finder | https://github.com/junegunn/fzf | No |
| `gh` | GitHub command-line interface | https://cli.github.com/ | Yes — GitHub API |
| `git` | Distributed version control system | https://git-scm.com/ | Yes — remote repositories |
| `git-extras` | Additional useful Git commands | https://github.com/tj/git-extras | No |
| `gnupg` | GNU Privacy Guard — encryption and signing | https://gnupg.org/ | Yes — key servers |
| `go` | Go programming language | https://go.dev/ | Yes — module proxy |
| `gopass` | Password manager for teams (GPG-based) | https://github.com/gopasspw/gopass | Yes — Git-backed store sync |
| `graphviz` | Graph visualization software (DOT language) | https://graphviz.org/ | No |
| `jq` | Lightweight command-line JSON processor | https://jqlang.github.io/jq/ | No |
| `k9s` | Terminal UI for Kubernetes clusters | https://k9scli.io/ | Yes — Kubernetes API server |
| `kubectl` | Kubernetes command-line tool | https://kubernetes.io/docs/reference/kubectl/ | Yes — Kubernetes API server |
| `lazygit` | Terminal UI for Git | https://github.com/jesseduffield/lazygit | No |
| `lcov` | Graphical front-end for GCC code coverage | https://github.com/linux-test-project/lcov | No |
| `libssh` | SSH library (C implementation) | https://www.libssh.org/ | No (library, not a binary) |
| `neovim` | Hyperextensible Vim-based text editor | https://neovim.io/ | No |
| `packer` | Machine image build tool (HashiCorp) | https://www.packer.io/ | Yes — cloud provider APIs |
| `pinentry-mac` | macOS GUI for GPG passphrase entry *(macOS only)* | https://github.com/GPGTools/pinentry-mac | No |
| `postgresql` | Relational database (client and server) | https://www.postgresql.org/ | Yes — database connections |
| `ripgrep` | Fast recursive text search (`rg`) | https://github.com/BurntSushi/ripgrep | No |
| `socat` | Multipurpose socket relay | https://repo.or.cz/socat.git | Yes — arbitrary network connections |
| `starship` | Minimal, fast, cross-shell prompt | https://starship.rs/ | No |
| `stow` | Symlink farm manager | https://www.gnu.org/software/stow/ | No |
| `terraform` | Infrastructure-as-code provisioning (HashiCorp) | https://www.terraform.io/ | Yes — cloud provider APIs, Terraform registries |
| `the_silver_searcher` | Fast code search tool (`ag`) | https://github.com/ggreer/the_silver_searcher | No |
| `ttyd` | Share terminal over the web via WebSocket | https://tsl0922.github.io/ttyd/ | Yes — exposes local terminal over HTTP |
| `tz` | Time zone helper for the terminal | https://github.com/oz/tz | No |
| `vault` | Secret management tool (HashiCorp) | https://www.vaultproject.io/ | Yes — Vault server API |
| `wget` | Network file downloader | https://www.gnu.org/software/wget/ | Yes — user-directed |
| `zsh` | Z shell | https://www.zsh.org/ | No |

---

## 3. Externally Downloaded Tools

These tools are fetched via `curl` or `git clone` during installation
([`bootstrap.sh`](bootstrap.sh), [`install.sh`](install.sh)).

| Tool | Installation Method | Source URL | Description |
|------|---------------------|------------|-------------|
| **Homebrew** | Curl → Bash pipe | `https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh` | macOS/Linux package manager |
| **chezmoi** (init) | Curl → Shell pipe | `https://chezmoi.io/get` | Dotfile manager (bootstrap installer) |
| **Volta** | Curl → Bash pipe | `https://get.volta.sh` | JavaScript tool/version manager (Node.js, npm, yarn) |
| **Antidote** | `git clone` | `https://github.com/mattmc3/antidote.git` → `~/.antidote` | Zsh plugin manager |
| **GPG public key** | `curl` → `gpg --import` | `https://key.mattforster.ca/gpg.pub` | Owner's GPG public key for commit signing / encryption |

---

## 4. Zsh Plugin Manager & Plugins

### Plugin Manager

| Name | Repository | Description |
|------|------------|-------------|
| **Antidote** | https://github.com/mattmc3/antidote | Fast Zsh plugin manager (static loading) |

### Plugins

Defined in
[`private_dot_config/zsh/dot_zsh_plugins.txt`](private_dot_config/zsh/dot_zsh_plugins.txt).

| Plugin | Repository | Description |
|--------|------------|-------------|
| `zsh-mkc` | https://github.com/caarlos0/zsh-mkc | `mkdir` + `cd` in one command |
| `zsh-open-github-pr` | https://github.com/caarlos0/zsh-open-github-pr | Open GitHub PR from the command line |
| `zsh-async` | https://github.com/mafredri/zsh-async | Async job support for Zsh |
| `z` | https://github.com/rupa/z | Frecency-based directory jumper |
| `nx-completion` | https://github.com/jscutlery/nx-completion | Zsh completions for Nx CLI |
| `zsh-completions` | https://github.com/zsh-users/zsh-completions | Additional Zsh completion definitions |
| `zsh-autosuggestions` | https://github.com/zsh-users/zsh-autosuggestions | Fish-like autosuggestions for Zsh |
| `zsh-history-substring-search` | https://github.com/zsh-users/zsh-history-substring-search | History search by substring |
| `ohmyzsh/plugins/aws` | https://github.com/ohmyzsh/ohmyzsh | AWS CLI completions/helpers (from Oh My Zsh) |
| `fast-syntax-highlighting` | https://github.com/zdharma/fast-syntax-highlighting | Syntax highlighting for Zsh commands |

### Built-in Zsh Plugin Keywords

Loaded via the `plugins=()` array in
[`private_dot_config/zsh/configs/plugins.zsh`](private_dot_config/zsh/configs/plugins.zsh):

| Keyword | Source | Description |
|---------|--------|-------------|
| `git` | Oh My Zsh (bundled via Antidote) | Git aliases and helpers |
| `npm` | Oh My Zsh (bundled via Antidote) | npm completions |
| `aws` | Oh My Zsh (bundled via Antidote) | AWS CLI helpers |

---

## 5. Custom Shell Scripts (`~/.bin`)

Located in [`dot_bin/`](dot_bin/). These are plain shell scripts placed on
`$PATH` — no external downloads, no compiled binaries.

| Script | Description | External Tools Used |
|--------|-------------|---------------------|
| `aws-sts` | Retrieve AWS STS session tokens with YubiKey MFA | `aws`, `ykman` |
| `git-amend` | Amend last Git commit | `git` |
| `git-ca` | Git commit --amend shortcut | `git` |
| `git-changes` | Show changes in working tree | `git` |
| `git-ci` | Git commit shortcut | `git` |
| `git-create-branch` | Create and push a new branch | `git` |
| `git-ctags` | Regenerate ctags for a Git repo | `git`, `ctags` |
| `git-current-branch` | Print the current branch name | `git` |
| `git-default-branch` | Print the default branch name | `git` |
| `git-delete-branch` | Delete a local and remote branch | `git` |
| `git-merge-branch` | Merge a branch into the current branch | `git` |
| `git-pr` | Open a pull request | `git`, `gh` |
| `git-purge` | Remove merged local branches | `git` |
| `git-rename-branch` | Rename a branch locally and remotely | `git` |
| `git-reset-hard` | Hard reset to HEAD | `git` |
| `git-revision` | Print short SHA of HEAD | `git` |
| `git-sync` | Sync fork with upstream | `git` |
| `git-tfo` | Terraform format shortcut | `git`, `terraform` |
| `git-undo` | Undo last commit (soft reset) | `git` |
| `git-up` | Pull with rebase and submodule update | `git` |
| `replace` | Find and replace across files | `ag` (silver_searcher), `sed` |
| `tat` | Attach or create a named tmux session | `tmux` |

### Custom Zsh Functions

Located in
[`private_dot_config/zsh/functions/`](private_dot_config/zsh/functions/).

| Function | Description | External Tools Used |
|----------|-------------|---------------------|
| `call-pg` | Prefer `pgcli` over `psql` if available | `pgcli` (optional), `psql` |
| `change-extension` | Bulk rename file extensions | `mv` |
| `envup` | Export variables from a `.env` file | — |
| `g` | Git wrapper; prefers `hub` if available | `git`, `hub` (optional) |
| `mcd` | Create a directory and cd into it | — |

---

## 6. Optional / Conditionally Loaded Tools

These tools are not installed by this repository but are expected or detected at
runtime.

| Tool | Detection Context | Description |
|------|-------------------|-------------|
| `tmux` | `tmux.conf`, `dot_bin/tat` — full config present but not in Brewfile | Terminal multiplexer |
| `rbenv` | `post/path.zsh` — loaded if present on `$PATH` | Ruby version manager |
| `hub` | `functions/g` — used instead of `git` if present | GitHub CLI wrapper (legacy) |
| `pgcli` | `functions/call-pg` — preferred over `psql` if present | Enhanced PostgreSQL CLI |
| `ykman` | `dot_bin/aws-sts` — reads TOTP codes from YubiKey | YubiKey Manager CLI |
| `ctags` | `dot_bin/git-ctags` — generates tags | Exuberant/Universal Ctags |
| `gpg-agent-relay` | `aliases.zsh` `reset-card` alias | GPG agent relay for smart card reset |
| `pbcopy` | `tmux.conf` — copy-mode pipe target *(macOS only)* | macOS system clipboard utility |
| `dig` | `aliases.zsh` `fire` alias — DNS TXT lookup | DNS lookup utility (bind-tools) |

---

## 7. External Services Contacted at Runtime

These network endpoints are referenced in configuration or scripts.

| Endpoint | Context | Purpose |
|----------|---------|---------|
| `https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh` | `bootstrap.sh` | Homebrew installer |
| `https://chezmoi.io/get` | `install.sh` | chezmoi bootstrap installer |
| `https://get.volta.sh` | `install.sh` | Volta installer |
| `https://github.com/mattmc3/antidote.git` | `install.sh` | Antidote Zsh plugin manager |
| `https://github.com/matt-forster/dotfiles.git` | `install.sh` | This dotfiles repository |
| `https://key.mattforster.ca/gpg.pub` | `bootstrap.sh` | GPG public key import |
| `https://ipinfo.io/ip` | Shell alias `ip` | Public IP lookup |
| `istheinternetonfire.com` | Shell alias `fire` (DNS TXT query) | Internet status check |
| `github.com` | SSH config, `gh`, `git` | GitHub access |
| `homeassistant.local` | SSH config | Local Home Assistant host |
| `https://starship.rs/config-schema.json` | `starship.toml` | Editor schema validation (optional) |

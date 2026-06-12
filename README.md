# Environment and Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/), host packages, and [mise](https://mise.jdx.dev/).

## Steps

```bash
./setup.sh
```

Run as your user — sudo is called internally where needed. Re-run at any time; all steps are idempotent.

### Individual scripts

- `install-linux.sh` — re-run to update/install packages on Linux
- `Brewfile` + `brew bundle` — manage packages on macOS
- `mise install` — install/update mise-managed developer tools
- `chezmoi apply` — apply dotfiles

### Work machines

Add to `~/.config/chezmoi/chezmoi.toml` to enable Colima/Docker socket configuration:

```toml
[data]
  isWork = true
```

## Tool Management

Prefer mise for versioned developer tools, language runtimes, project tasks, and project-scoped environment variables. Homebrew and apt should stay focused on bootstrap and host packages. The global mise config pins current stable defaults for Go, Node, npm, Deno, Terraform, Codex, Nx, and agentmemory so they do not depend on Volta, asdf, or tfswitch being present.

Project `mise.toml` files should own project-specific tool pins. Use `[env]`, `_.path`, `_.file`, and `_.source` before adding new `.envrc` logic.

`direnv` remains installed as a legacy fallback, but zsh only hooks it when `mise` is not available. Do not use `direnv` to manage tool versions or language layouts; migrate those cases to mise. Avoid `use mise` in `.envrc`.

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

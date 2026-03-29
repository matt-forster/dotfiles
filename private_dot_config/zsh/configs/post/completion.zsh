# completion fpath and compinit are initialized in plugins.zsh before antidote load


if command -v asdf >/dev/null 2>&1; then
  mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
  asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
fi

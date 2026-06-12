plugins=(git npm aws)
autoload -U +X bashcompinit && bashcompinit
bindkey "^[[3~" delete-char

_zsh_config_dir="$HOME/.config/zsh"

# load our own and Homebrew completion functions
fpath=(
  "$_zsh_config_dir/completion"
  /opt/homebrew/share/zsh/site-functions
  /usr/local/share/zsh/site-functions
  /home/linuxbrew/.linuxbrew/share/zsh/site-functions
  $fpath
)

# completion; -i ignores insecure directories
autoload -U compinit
_zcompdump="${_zsh_config_dir}/.zcompdump"
if [[ -f "$_zcompdump" ]]; then
  compinit -C -d "$_zcompdump"
else
  compinit -i -d "$_zcompdump"
fi
unset _zcompdump

# source antidote
source ~/.antidote/antidote.zsh

# initialize plugins statically with ~/.config/zsh/.zsh_plugins.txt
antidote load "${_zsh_config_dir}/.zsh_plugins.txt"
unset _zsh_config_dir

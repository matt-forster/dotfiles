plugins=(git npm aws)
autoload -U +X bashcompinit && bashcompinit
bindkey "^[[3~" delete-char

source ~/.zsh/functions/antidote.zsh
source ~/.zsh/zsh_plugins.sh

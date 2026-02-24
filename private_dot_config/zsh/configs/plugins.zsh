plugins=(git npm aws)
autoload -U +X bashcompinit && bashcompinit
bindkey "^[[3~" delete-char

# source antidote
source ~/.antidote/antidote.zsh

export ZDOTDIR=~/.config/zsh
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

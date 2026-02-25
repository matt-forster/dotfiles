plugins=(git npm aws)
autoload -U +X bashcompinit && bashcompinit
bindkey "^[[3~" delete-char

# load our own completion functions
fpath=(~/.config/zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion; -i ignores insecure directories
autoload -U compinit
compinit -i

# source antidote
source ~/.antidote/antidote.zsh

export ZDOTDIR=~/.config/zsh
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

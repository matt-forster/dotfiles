plugins=(git npm aws)
autoload -U +X bashcompinit && bashcompinit
bindkey "^[[3~" delete-char

plugins=(git npm aws)
autoload -U +X bashcompinit && bashcompinit
bindkey "^[[3~" delete-char

zsh_plugins=$HOME/.zsh/zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source $HOME/.antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

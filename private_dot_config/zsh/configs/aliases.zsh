# Unix
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'
alias md='mkdir -p'
alias rd=rmdir
alias ln="ln -v"
alias mkdir="mkdir -p"
alias ci="circleci-cli"
alias python="python3"
alias note="nv ~/note.md"

alias e="$EDITOR"
alias v="$VISUAL"

alias pr="gh pr create -d -a matt-forster"

#postgres scripts
alias pg=call-pg

#docker scripts
alias docker-purge='docker rmi -f $(docker images -a -q)'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# command aliases
alias projects='cd $HOME/projects'
alias fire='dig +short txt istheinternetonfire.com'
alias ip='curl https://ipinfo.io/ip'
alias dot='chezmoi'
alias nv='nvim'
alias pass=gopass

# shortcuts
alias :wq='echo "Bye!" && logout'
alias ':q!'='echo "Bye! - History is removed!" && clear-history && logout'
alias 2fa='ykman oath accounts code -s'

alias git-branch='git log --graph --oneline --all'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias clear-history='rm -f ~/.bash_history && rm -f $HISTFILE'
alias reset-card='gpg-agent-relay stop && gpg-agent-relay start'


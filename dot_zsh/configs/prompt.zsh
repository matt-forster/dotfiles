eval "$(starship init zsh)"
eval "$(direnv hook bash)"

gpg --card-status | ag --nocolor -o 'rsa4096/FD79F7B533DEACFB'

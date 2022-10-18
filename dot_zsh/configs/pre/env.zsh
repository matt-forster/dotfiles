export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

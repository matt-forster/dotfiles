#1 /urs/bin/env zsh

# May have to rerun if this is missing (as it doesn't get sourced the same everywhere)
if ! type nix-env >/dev/null 2>&1; then
  sh <(curl -L https://nixos.org/nix/install)
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

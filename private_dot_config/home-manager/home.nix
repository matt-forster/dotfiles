{ config, pkgs, ... }:

{

  imports = [
    ./bat.nix
    ./git.nix
    ./zsh/zsh.nix
    ./editorconfig.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matthew.forster";
  home.homeDirectory = "/Users/matthew.forster";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    awscli2
    bat
    curl
    deno
    docker
    docker-compose
    docker-credential-gcr
    docker-credential-helpers
    fzf
    ripgrep
    lazygit
    bottom
    gh
    git
    git-extras
    git-revise
    gnupg
    go_1_19
    gopass
    jq
    neovim
    packer
    pgcli
    postgresql
    sampler
    silver-searcher
    socat
    starship
    stow
    terraform
    tz
    vault
    vscode
    wget
    zsh
    circleci-cli
    libclang
    cmake
    gcc
    direnv
    kubectl
    libssh
    k9s
    ffmpeg
    ttyd
    pinentry_mac

    # Added for work
    redis
    buf
    colima
    grpcurl
    sops

  ];
}

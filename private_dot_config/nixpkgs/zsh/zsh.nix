{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    localVariables = {
      NODE_OPTIONS = "--openssl-legacy-provider";
    };

    initExtra = ''
    	source $HOME/.config/nixpkgs/zsh/init.zsh
    	source $HOME/.config/nixpkgs/zsh/work.zsh
    '';
  };
}

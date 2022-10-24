{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh/";

    localVariables = {
      NODE_OPTIONS = "--openssl-legacy-provider";
    };

    initExtra = ''
    	source $HOME/.config/nixpkgs/zsh/init.zsh
    	source $HOME/.config/nixpkgs/zsh/work.zsh
    '';
  };
}

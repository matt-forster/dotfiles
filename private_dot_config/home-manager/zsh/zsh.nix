{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    localVariables = {
    };

    initExtra = ''
    	source $HOME/.config/home-manager/zsh/init.zsh
    	source $HOME/.config/home-manager/zsh/work.zsh
    '';
  };
}

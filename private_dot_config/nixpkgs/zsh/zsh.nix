{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
    	source $HOME/.config/nixpkgs/zsh/init.zsh
    	source $HOME/.config/nixpkgs/zsh/work.zsh
    '';
  };
}

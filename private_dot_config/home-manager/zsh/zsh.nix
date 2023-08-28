{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    localVariables = {
    };

    envExtra = ''
      export CC=/usr/bin/clang
      export CXX=/usr/bin/clang++
    '';

    initExtra = ''
    	source $HOME/.config/home-manager/zsh/init.zsh
    	source $HOME/.config/home-manager/zsh/work.zsh
    '';
  };
}

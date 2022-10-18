{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
    	source $HOME/.zshrc.d/old_init.zsh
    	source $HOME/.zshrc.d/local_init.zsh
    	source $HOME/.zshrc.d/secrets.zsh
    	source $HOME/.zshrc.d/work.zsh
    '';

    envExtra = ''
        source $HOME/.zshenv.d/old_env.zsh
    '';
  };
}

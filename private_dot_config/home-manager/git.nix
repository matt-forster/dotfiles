{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Matt Forster";
    userEmail = "hey@mattforster.ca";

    aliases = {
      l  = "log --pretty=colored --reverse -10";
      cb = "create-branch";
      db = "delete-branch";
      aa = "add --all";
      ap = "add --patch";
      ci = "commit -v";
      co = "checkout";
      pf = "push --force-with-lease";
      aliases = "!git config --get-regexp ^alias\\. | colrm 1 6 | sed 's/[ ]/ = /' | sort";
    };

    signing = {
      signByDefault = true;
      key = "17E54D76A6213FDB!"; # can we eval this eventually?
    };

    attributes = [ "* text=auto" "*.pem text eol=lf" ];

    ignores = [ ".vscode/" ];

    extraConfig = {
      branch.autosetuprebase = "always";
      pull.rebase = "true";
      push.default = "current";
      merge.ff = "only";
      fetch.prune = "true";
      rebase.autoSquash = "true";
      color.ui = "auto";
      core.editor = "nvim";
      core.autocrlf = "input";
      pretty.colored = "format:%Cred%h%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset";
      init.defaultBranch = "main";
      diff.algorithm = "patience";
    };

    diff-so-fancy.enable = true;
  };
}
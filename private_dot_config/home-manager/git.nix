{ config, pkgs, ... }:

{
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      key = "E2620E73258A426D";
    };

    attributes = [ "* text=auto" "*.pem text eol=lf" ];

    ignores = [ ".vscode/" ];

    settings = {
      user = {
        name = "Matt Forster";
        email = "hey@mattforster.ca";
      };

      alias = {
        l  = "log --pretty=colored --reverse -10";
        cb = "create-branch";
        db = "delete-branch";
        aa = "add --all";
        ap = "add --patch";
        co = "checkout";
        pf = "push --force-with-lease";
        aliases = "!git config --get-regexp ^alias\\. | colrm 1 6 | sed 's/[ ]/ = /' | sort";
      };

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
  };
}

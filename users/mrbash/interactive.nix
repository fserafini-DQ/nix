{ pkgs, ... }: {

  # TODO: experiment with these
  # programs.nix-index.enable = true;
  # programs.nix-index.enableZshIntegration = true;
  # nix-index-database.comma.enable = true;
  # fzf.enable = true;
  # fzf.enableZshIntegration = true;
  # lsd.enable = true;
  # lsd.enableAliases = true;
  # zoxide.enable = true;
  # zoxide.enableZshIntegration = true;
  # broot.enable = true;
  # broot.enableZshIntegration = true;
  # direnv.enable = true;
  # direnv.enableZshIntegration = true;
  # direnv.nix-direnv.enable = true;

  # TODO: consider gitui, which should be faster
  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
    extraConfig = {
      user.useConfigOnly = true;
      # Automatically handle !fixup and !squash commits -- see https://thoughtbot.com/blog/autosquashing-git-commits
      rebase.autosquash = "true";
      # Improve merge conflicts style showing base -- see https://ductile.systems/zdiff3/
      merge.conflictstyle = "zdiff3";
      # Different color for moves in diffs.
      diff.colorMoved = "default";
      # Default branch name.
      init.defaultBranch = "main";
      # Help with autocorrect but ask for permission.
      help.autocorrect = "prompt";
      # Use ISO dates.
      log.date = "iso";
      # Probably easier diffs when permuting functions.
      diff.algorithm = "histogram";
      # Sort branches by last commit.
      branch.sort = "-committerdate";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreDups = true;
    historySubstringSearch.enable = true;
    shellAliases = {
      t = "timew";
    };
    initExtra = ''
      # Usage: ssh-L [user@]host ports...
      ssh-L () { ssh -vN $(printf ' -L %1$s:localhost:%s' ''${@:2}) $1 }
    '';
  };

  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      # username.show_always = true;
      # hostname.ssh_only = false;
      memory_usage.disabled = false;
      status.disabled = false;
      sudo.disabled = false;
      docker_context.only_with_files = false;
    };
  };

  home.file.".editorconfig".source = ./files/editor_config.ini;

  home.file.".justfile".source = ../../tasks/justfile;

}

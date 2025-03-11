{ config, pkgs, unstable, ... }: {
  programs.git = {
    enable = true;
    package = unstable.gitFull;
    userName = "Sam Miller";
    userEmail = "23262411+s-mil@users.noreply.github.com";
    maintenance.enable = true;
    lfs.enable = true;
    aliases = {
      fpush = "push --force-with-lease";
    };
    extraConfig = {
      credential.helper = "libsecret";
      pull.rebase = true;
      color.ui = true;
      init.defaultBranch = "main";
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      push = {
        default = "simple";
        followTags = true;
        autoSetupRemote = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      commit.verbose = true;
      rebase = {
        autoStash = true;
        autoSquash = true;
        updateRefs = true;
      };
      merge.conflictstyle = "zdiff3";
      maintenance = {
        gc = "disabled";
        commit-graph = "hourly";
        prefetch = "hourly";
        loose-objects = "daily";
        incremental-repack = "daily";
      };
    };
  };

  programs.gh = { enable = true; };

}

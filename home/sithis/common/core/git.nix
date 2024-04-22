{ config, pkgs, unstable, ... }: {
  programs.git = {
    enable = true;
    package = unstable.gitFull;
    userName = "Sam Miller";
    userEmail = "23262411+s-mil@users.noreply.github.com";
    lfs.enable = true;
    extraConfig = {
      credential.helper = "libsecret";
      pull.rebase = true;
      color.ui = true;
      init.defaultBranch = "main";
    };
  };

  programs.gh = { enable = true; };

}

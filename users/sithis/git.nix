{ config, pkgs, ... }:
{
    programs.git = {
        enable = true;
        package = pkgs.gitFull;
        userName = "Sam Miller";
        userEmail = "smiller2033@outlook.com";
        lfs.enable = true;
        extraConfig = {
        pull.rebase = true;
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
        color.ui = true;
        init.defaultBranch = "main";
        };
    };

}
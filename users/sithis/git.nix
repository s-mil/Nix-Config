{ config, pkgs, unstable, ... }:
{
    programs.git = {
        enable = true;
        package = unstable.gitFull;
        userName = "Sam Miller";
        userEmail = "smiller2033@outlook.com";
        lfs.enable = true;
        extraConfig = {
        credential.helper = "libsecret";
        pull.rebase = true;
        color.ui = true;
        init.defaultBranch = "main";
        };
    };

}

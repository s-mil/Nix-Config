{ config, pkgs, ... }:
{
    programs.git = {
        enable = true;
        userName = "Sam Miller";
        userEmail = "smiller2033@outlook.com";
        lfs.enable = true;
        extraConfig = {
        pull.rebase = true;
        color.ui = true;
        init.defaultBranch = "main";
        };
    };

}
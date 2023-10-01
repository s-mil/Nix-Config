{ config, pkgs, pkgs-stable, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs-stable.vscode;
        #enableUpdateCheck = false;
    };
}

{ config, pkgs, pkgs-unstable,... }:
{
    programs.vscode = {
        enable = true;
        package = pkgs-unstable.vscode;
        enableUpdateCheck = false;
    };
}
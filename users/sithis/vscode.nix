{ config, pkgs, pkgs-unstable,... }:

let
    pkgs-unstable = import pkgs-unstable {};

in
{
    programs.vscode = {
        enable = true;
        package = pkgs-unstable.vscode;
        enableUpdateCheck = false;
    };
}
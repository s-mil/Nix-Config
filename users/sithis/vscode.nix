{ config, pkgs, pkgs-unstable, ... }:

{
    programs.vscode = {
        enable = true;
       # enableUpdateCheck = false;
    };
}
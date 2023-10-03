{ config, pkgs, nixpkgs-stable, ... }:

{
    programs.vscode = {
        enable = true;
        #package = nixpkgs-stable.vscode;
        #enableUpdateCheck = false;
    };
}

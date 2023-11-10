{ config, pkgs, unstable, ... }:

{
    programs.vscode = {
        enable = true;
        package = unstable.vscode;
    };
}

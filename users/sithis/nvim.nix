{ config, pkgs, pkgs-unstable, ... }:
{
    programs.neovim = {
        enable = true;
        package = pkgs-unstable.neovim;
    };
}
{ config, pkgs, pkgs-unstable, ... }:
let
    pkgs-unstable = import <nixpkgs-unstable> {};

in
{
    programs.neovim = {
        enable = true;
        package = pkgs-unstable.neovim;
    };
}
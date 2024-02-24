{ config, pkgs, unstable, ... }:
{
    programs.neovim = {
        enable = true;
        package = unstable.neovim-unwrapped;
    };
}

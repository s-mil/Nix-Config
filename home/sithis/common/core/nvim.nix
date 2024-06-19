{ config, pkgs, unstable, ... }: {

  stylix.targets.vim.enable = false;
  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;
  };
}

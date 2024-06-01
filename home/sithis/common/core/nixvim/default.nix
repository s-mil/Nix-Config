{ inputs, pkgs, ... }:
let
  forceWrite = {
    action = "<cmd>silent! update! | redraw<cr>";
    options.desc = "Force write";
  };
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./colorscheme.nix
    ./keymaps.nix
    ./autocommands.nix
    ./completion.nix
    ./options.nix
    ./todo.nix
    ./plugins
  ];

  stylix.targets.vim.enable = false;

  programs.nixvim = {
    enable = true;
    enableMan = true;

    clipboard.register = "unamedplus";

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

  };
}

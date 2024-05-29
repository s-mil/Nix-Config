{ config, pkgs, unstable, inputs, ... }:

{
  programs.vscode = {
    enable = true;
    package = unstable.vscode;
  };

  stylix.targets.vscode.enable = false;
  stylix.targets.vim.enable = false;

}

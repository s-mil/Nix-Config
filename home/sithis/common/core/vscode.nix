{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
  };

  stylix.targets.vscode.enable = false;
}

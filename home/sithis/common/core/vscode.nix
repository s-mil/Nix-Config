{ config, pkgs, unstable, inputs, ... }:

{
  programs.vscode = {
    enable = true;
    package = unstable.vscode-fhs;
  };

  stylix.targets.vscode.enable = false;

}

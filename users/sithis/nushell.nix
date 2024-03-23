{ config, pkgs, unstable, ... }: {
  programs.nushell = {
    enable = true;

  };

  programs.starship = {
    enable = true;

  };

  programs.atuin = { enable = true; };

  programs.zoxide = { enable = true; };
}

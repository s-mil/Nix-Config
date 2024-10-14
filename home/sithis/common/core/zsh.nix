{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -lah";
      update = "just -f ~/Nix-Config/justfile `cat /etc/hostname`";
      dc = "docker compose";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
  programs.starship = {
    enable = true;

  };

  programs.atuin = { enable = true; };

  programs.zoxide = { enable = true; };

  programs.direnv = { enable = true; };
}

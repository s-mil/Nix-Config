{ config, pkgs, ... }:
{
programs.zsh = {
  enable = true;
  shellAliases = {
    ll = "ls -l";
    la = "ls -lah";
    update = "sudo nixos-rebuild switch";
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
 oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "agnoster";
  };
};

}
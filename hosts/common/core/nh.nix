{ ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 15";
    flake = "/home/sithis/git/Nix-Config";
  };
}

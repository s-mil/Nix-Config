{ config, pkgs, unstable, ... }: {
  environment.systemPackages = with pkgs; [ brightnessctl ];
}

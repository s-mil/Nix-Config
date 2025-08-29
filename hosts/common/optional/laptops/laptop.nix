{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    kdePackages.wacomtablet
    libwacom
  ];
}

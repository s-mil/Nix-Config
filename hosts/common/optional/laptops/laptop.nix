{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    kdePackages.wacomtablet
    libwacom
  ];
  hardware.sensor.iio.enable = true;
  hardware.openrazer = {
    enable = true;
    users = ["sithis"];
    
  };
}

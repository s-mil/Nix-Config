{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    kdePackages.wacomtablet
    libwacom
    sof-firmware
    alsa-tools
  ];
  hardware.sensor.iio.enable = true;
  hardware.openrazer = {
    enable = true;
    users = ["sithis"];
    
  };
}

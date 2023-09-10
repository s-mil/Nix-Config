{ config, pkgs, ... }:
{
 environment.systemPackages = with pkgs; [
    yuzu-mainline
    dolphin-emu
    dolphin-emu-primehack
    emulationstation
    retroarch-with-cores
  ];
}

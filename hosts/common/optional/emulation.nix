{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dolphin-emu
    dolphin-emu-primehack
    emulationstation
    retroarchFull
  ];
}

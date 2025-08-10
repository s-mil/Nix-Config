{ unstable, ... }:
{
  environment.systemPackages = with unstable; [
    dolphin-emu-primehack
    #emulationstation-de #depends on insecure package :(
    pegasus-frontend
    # retroarchFull
    #ryujinx
    ryubing
  ];
}

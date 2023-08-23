{ config, pkgs, pkgs-unstable,lib, inputs, ... }:
let

  Hostname = "odin";

in
{
    networking.hostName = Hostname;

    imports =
    [
        ../bootloaders/systemd.nix
        ../displayManager/sddm.nix
        ../windowManager/sway.nix
        ../desktopEnvironment/kde.nix
    ];
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  
  virtualisation.docker.enable= true;

  programs.steam.enable = true;
}

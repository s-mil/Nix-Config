{ config, pkgs, lib, ... }:
let

  Hostname = "thor";

in
{
    networking.hostName = Hostname;

    imports =
    [
        ../common.nix
        ../bootloaders/systemd.nix
        ../displayManager/sddm.nix
        ../windowManager/sway.nix
        ../desktopEnvironment/kde.nix
        ../users/root/user.nix
        ../users/sithis/user.nix

    ];
  
  hardware.bluetooth.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  

  services.tailscale = {
    enable = true;
    port = 41641;
    };
  virtualisation.docker.enable= true;

  programs.steam.enable = true;
}

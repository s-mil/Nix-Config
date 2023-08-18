{ config, pkgs, pkgs-unstable,lib, inputs, ... }:
let

  Hostname = "mjolnr";

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
  
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  
  virtualisation.docker.enable= true;

  programs.steam.enable = true;
}

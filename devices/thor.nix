{ config, pkgs, pkgs-unstable,lib, inputs, ... }:
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
        ../desktopEnvironment/sunshine.nix
        ../users/root/user.nix
        ../users/sithis/user.nix

    ];
  
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  virtualisation.docker = {
    enable= true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  programs.steam.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false; 
}

{ config, pkgs, pkgs-unstable,lib, inputs, ... }:
let

  Hostname = "freya";

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
        ../tweaks/brother_printer.nix
        ../tweaks/emulation.nix
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

  virtualisation.docker = {
    enable= true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

}

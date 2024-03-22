{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
let

  Hostname = "freya";

in {
  networking = {
    hostName = Hostname;
    hostId = "007f0202";
    firewall.enable = false;
    interfaces = {
      eno1 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "10.10.0.11";
          prefixLength = 8;
        }];
      };
    };
    defaultGateway4 = "10.0.0.1";
    nameservers = [ "1.1.1.1" ];
  };
  imports = [
    ../common.nix
    ../bootloaders/systemd.nix
    ../displayManager/sddm.nix
    ../windowManager/sway.nix
    ../desktopEnvironment/kde.nix
    ../users/root/user.nix
    ../users/sithis/user.nix
    ../tweaks/brother_printer.nix
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  services.k3s = {
    enable = true;
    role = "server";
  };
}

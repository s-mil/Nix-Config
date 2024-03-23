{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
let

  Hostname = "odin";

in {
  networking = {
    hostName = Hostname;
    hostId = "007f0200";
    firewall.enable = false;
    interfaces = {
      enp6s18 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "10.10.0.64";
          prefixLength = 8;
        }];
      };
    };
    defaultGateway = "10.0.0.1";
    nameservers = [ "10.10.0.11" "10.10.0.10" ];
  };

  imports = [
    ../bootloaders/systemd.nix
    ../displayManager/sddm.nix
    ../windowManager/sway.nix
    ../desktopEnvironment/kde.nix
    ../desktopEnvironment/sunshine.nix
    ../users/root/user.nix
    ../users/sithis/user.nix
    ../tweaks/emulation.nix
    ../tweaks/brother_printer.nix
  ];

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  services.sunshine.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  programs.steam.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    hardware.nvidia.powerManagement.finegrained = false;
    hardware.nvidia.open = false;
    nvidiaSettings = true;
  };
}

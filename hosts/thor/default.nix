{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
let

  Hostname = "thor";
  mountPoint = "/boot";

in {
  networking.hostName = Hostname;


  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    ../common/optional/services/openssh.nix # allow remote SSH access

    ../common/optional/sway.nix # window manager
    ../common/optional/pipewire.nix # audio
    ../common/optional/xfce4.nix

    #################### Users to Create ####################
    ../common/users/sithis
  

    
    # ../common.nix
    # ../bootloaders/systemd.nix
    # ../displayManager/sddm.nix
    # ../windowManager/sway.nix
    # ../desktopEnvironment/kde.nix
    # ../users/root/user.nix
    # ../users/sithis/user.nix
    # ../tweaks/emulation.nix
    # ../tweaks/laptop.nix
  ];

  networking = { networkmanager = { enable = true; }; };

  services.xserver.enable = true;
  sevices.xserver.displayManager.sddm.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  boot = {
    loader = {
      systemd-boot = {
        editor = true;
        enable = true;
        configurationLimit = 10;
      };
      efi = { efiSysMountPoint = mountPoint; };
    };
  };


  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}

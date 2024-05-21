# ############################################################
#
#  Thor - Daily Driver Laptop
#  NixOS running on Lenovo Yoga x1 Carbon Gen 1
#
###############################################################
{ inputs, configLib, ... }:
let

  Hostname = "thor";
  mountPoint = "/boot";

in {
  networking.hostName = Hostname;

  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    ../common/optional/sddm.nix
    ../common/optional/laptops
    ../common/optional/services/openssh.nix # allow remote SSH access
#    ../common/optional/services/docker.nix
    ../common/optional/hyprland.nix
    ../common/optional/sway.nix # window manager
    ../common/optional/pipewire.nix # audio
    ../common/optional/xfce4.nix # escape hatch
    ../common/optional/kubernetesOps
    ../common/optional/services/flatpak.nix

    #################### Users to Create ####################
    ../common/users/sithis

  ];

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

  networking = { networkmanager = { enable = true; }; };

  services.xserver.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

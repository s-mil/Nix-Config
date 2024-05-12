# ############################################################
#
#  Odin - Daily Driver Desktop
#  NixOS running under proxmox, with passthrough 3080ti
#
###############################################################

{ inputs, configLib, ... }:
let

  Hostname = "odin";
  mountPoint = "/boot";

in {
  networking = {
    hostName = Hostname;
    hostId = "007f0200";
    firewall.enable = false;
    interfaces = {
      enp4s0 = {
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
  

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };


  services.sunshine.enable = true;

  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    ../common/optional/services/openssh.nix # allow remote SSH access
    ../common/optional/nvidia.nix
    ../common/optional/steam.nix
    ../common/optional/pipewire.nix # audio
    ../common/optional/emulation.nix
    ../common/optional/kde.nix
    ../common/optional/xfce4.nix # escape hatch
    ../common/optional/hyprland.nix
    ../common/optional/kubernetesOps
    ../common/optional/services/sunshine.nix
    ../common/optional/services/dockerNV.nix
    ../common/optional/services/openrgb.nix
    ../common/optional/services/flatpak.nix
    ../common/optional/services/printing.nix

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

  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-sddm-corners";

  };


  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

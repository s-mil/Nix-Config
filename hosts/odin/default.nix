# ############################################################
#
#  Odin - Daily Driver Desktop
#  NixOS running on 5900x with 3080ti
#
###############################################################

{ inputs, config, lib, pkgs, ... }:
let

  Hostname = "odin";
  mountPoint = "/boot";

in {

  environment.systemPackages = [ pkgs.zfs pkgs.lz4 ];

  services.zfs = {
    autoSnapshot = {
      enable = true;
      weekly = 4;
      monthly = 12;
      hourly = 24;
      daily = 7;
      frequent = 4;

    };
    autoScrub = { enable = true; };
  };

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

  fileSystems = { "/".options = [ "compress=zstd" ]; };

  services.sunshine.enable = true;

  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    ../common/optional/sddm.nix
    ../common/optional/services/openssh.nix # allow remote SSH access
    ../common/optional/nvidia.nix
    ../common/optional/steam.nix
    ../common/optional/pipewire.nix # audio
    ../common/optional/emulation.nix
    ../common/optional/xfce4.nix # escape hatch
    ../common/optional/kde.nix
    ../common/optional/hyprland.nix
    ../common/optional/services/sunshine.nix
    ../common/optional/services/dockerNV.nix
    ../common/optional/services/openrgb.nix
    ../common/optional/services/flatpak.nix
    ../common/optional/services/printing.nix

    #################### Users to Create ####################
    ../common/users/sithis

  ];

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams =
      [ "quiet" "splash" "acpi_osi=linux" "processor.max_cstate=1" "zfs.zfs_arc_max=21474836480" ];
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
    zfs = {
      extraPools = [ "Data" "Clio" ];
    };
    plymouth = { enable = true; };
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

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.nfs.server.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

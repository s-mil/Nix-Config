# ############################################################
#
#  Thor - Daily Driver Laptop
#  NixOS running on Lenovo Yoga x1 Carbon Gen 1
#
###############################################################
{ inputs, config, lib, ... }:
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
    # ../common/optional/sddm.nix
    ../common/optional/cosmic.nix
    ../common/optional/laptops
    ../common/optional/services/openssh.nix # allow remote SSH access
    ../common/optional/services/docker.nix
    ../common/optional/hyprland.nix
    ../common/optional/pipewire.nix # audio
    # ../common/optional/xfce4.nix # escape hatch
    ../common/optional/kubernetesOps
    ../common/optional/services/flatpak.nix
    ../common/optional/stylix
    ../common/optional/adb.nix

    ../common/optional/sops.nix
    #################### Users to Create ####################
    ../common/users/sithis

  ];

  boot = {
    plymouth = { enable = true; };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [ "quiet" "splash" "acpi_osi=linux" ];
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
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  services.displayManager.defaultSession = "hyprland";


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

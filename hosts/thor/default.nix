# ############################################################
#
#  Thor - Daily Driver Laptop
#  NixOS running on Lenovo Yoga x1 Carbon Gen 1
#
###############################################################
{
  inputs,
  pkgs,
  ...
}:
let

  Hostname = "thor";
  mountPoint = "/boot";

in
{
  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    # ../common/optional/sddm.nix
    ../common/optional/cosmic-greeter.nix
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
    ../common/optional/brother_printer.nix

    ../common/optional/sops.nix
    #################### Users to Create ####################
    ../common/users/sithis

  ];

  boot = {
    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
    };
    kernelParams = [
      "quiet"
      "splash"
      "acpi_osi=linux"
    ];
    loader = {
      systemd-boot = {
        editor = true;
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        efiSysMountPoint = mountPoint;
      };
    };
  };

  networking = {
    hostName = Hostname;
    networkmanager = {
      enable = true;
    };
  };
  services = {
    xserver.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
  security = {
    polkit.enable = true;
    pam.services.sddm.enableGnomeKeyring = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

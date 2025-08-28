# ############################################################
#
#  Odin - Daily Driver Desktop
#  NixOS running on 5900x with 3080ti
#
###############################################################

{
  inputs,
  config,
  pkgs,
  ...
}:
let

  Hostname = "odin";
  mountPoint = "/boot";

in
{

  networking = {
    hostName = Hostname;
    hostId = "007f0200";
    firewall.enable = false;
    interfaces = {
      enp4s0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "10.10.0.64";
            prefixLength = 8;
          }
        ];
      };
    };
    defaultGateway = "10.0.0.1";
    nameservers = [
      "10.10.0.11"
      "10.10.0.64"
    ];
  };

  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix
    ./disk-config.nix

    #################### Host-specific Optional Configs ####################
    #../common/optional/sddm.nix
    ../common/optional/cosmic-greeter.nix
    ../common/optional/cosmic.nix
    ../common/optional/services/openssh.nix # allow remote SSH access
    ../common/optional/nvidia.nix
    ../common/optional/steam.nix
    ../common/optional/pipewire.nix # audio
    ../common/optional/emulation.nix
    #../common/optional/kde.nix
    ../common/optional/hyprland.nix
    ../common/optional/services/sunshine.nix
    ../common/optional/services/docker.nix
    ../common/optional/services/openrgb.nix
    ../common/optional/services/flatpak.nix
    ../common/optional/brother_printer.nix
    #../common/optional/services/ollama.nix
    ../common/optional/services/rustic-container-timer.nix
    ../common/optional/kubernetesOps
    # ../common/optional/services/tabby.nix
    #../common/optional/sops.nix
    ../common/optional/stylix

    #################### Users to Create ####################
    ../common/users/sithis

  ];

  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "acpi_osi=linux"
      "processor.max_cstate=1"
    ];

    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
    };
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
  #sops.secrets.odin_cache = { };

  services.xserver.enable = true;

  #services.nix-serve = {
  #  enable = true;
  #  secretKeyFile = config.sops.secrets.odin_cache.path;
  #  port = 22222;
  #};

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.displayManager.defaultSession = "cosmic";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

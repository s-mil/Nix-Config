# ############################################################
#
#  Odin - Daily Driver Desktop
#  NixOS running on 5900x with 3080ti
#
###############################################################

{ inputs, config, pkgs, ... }:
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
      flags="-p";
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
    nameservers = [ "10.10.0.11" "10.10.0.64" ];
  };

  fileSystems = { "/".options = [ "compress=zstd" ]; };

  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    ../common/optional/cosmic.nix
    # ../common/optional/sddm.nix
    ../common/optional/services/openssh.nix # allow remote SSH access
    ../common/optional/nvidia.nix
    ../common/optional/steam.nix
    ../common/optional/pipewire.nix # audio
    ../common/optional/emulation.nix
    ../common/optional/kde.nix
    ../common/optional/hyprland.nix
    ../common/optional/services/sunshine.nix
    ../common/optional/services/docker.nix
    ../common/optional/services/openrgb.nix
    ../common/optional/services/flatpak.nix
    ../common/optional/services/printing.nix
    ../common/optional/services/ollama.nix
    ../common/optional/services/rustic-container-timer.nix
    ../common/optional/kubernetesOps
    # ../common/optional/services/tabby.nix
    ../common/optional/sops.nix
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
      "zfs.zfs_arc_max=21474836480"
    ];
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
    zfs = { extraPools = [ "Data" "Clio" ]; };
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
  sops.secrets.odin_cache = { };

  services.xserver.enable = true;

  services.nix-serve = {
    enable = true;
    secretKeyFile = config.sops.secrets.odin_cache.path;
    port = 22222;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.displayManager.defaultSession = "cosmic";

  services.nfs.server = {
    enable = true;
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    exports = ''
      /Clio/Media/audiobooks         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Clio/Media/podcasts         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Clio/Media/tv         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Clio/paperless         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Clio/download/pyload         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Clio/download/tdown         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Anime         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Audio-Books         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/AV_Test         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Books         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Manga         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Movies         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Music         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
      /Data/Media/Photos         10.0.0.0/8(insecure,rw,sync,no_subtree_check)
    '';
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

# ############################################################
#
#  Freya - Server / Container host
#  NixOS running on HP laptop
#
###############################################################

{ inputs, configLib, ... }:
let

  Hostname = "freya";
  mountPoint = "/boot";

in {
  networking = {
    hostName = Hostname;
    hostId = "007f0200";
    firewall.enable = false;
    interfaces = {
      enp6s18 = {
        useDHCP = false;
        ipv4.addresses = [{
          address = "10.10.0.11";
          prefixLength = 8;
        }];
      };
    };
    defaultGateway = "10.0.0.1";
    nameservers = [ "10.10.0.11" "10.10.0.10" ];
  };

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
    ../common/optional/pipewire.nix # audio
    ../common/optional/xfce4.nix # escape hatch
    ../common/optional/services/docker.nix

    #################### Users to Create ####################
    ../common/users/sithis

  ];

  services.k3s = {
    enable = true;
    role = "server";
  };
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
  sevices.xserver.displayManager.sddm.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

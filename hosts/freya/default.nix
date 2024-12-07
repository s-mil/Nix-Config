# ############################################################
#
#  Freya - Server / Container host
#  NixOS running on HP laptop
#
###############################################################

{ inputs, ... }:
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
    nameservers = [ "10.10.0.11" "10.10.0.64" ];
  };

  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix
    # ../common/optional/cosmic.nix
    #################### Host-specific Optional Configs ####################
    ../common/optional/services/openssh.nix # allow remote SSH access
    ../common/optional/pipewire.nix # audio
    # ../common/optional/xfce4.nix # escape hatch
    ../common/optional/services/docker.nix
    ../common/optional/kde.nix
    # ../common/optional/services/k3s.nix
    ../common/optional/services/docker.nix

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

  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  security.pam.services.sddm.enableGnomeKeyring = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

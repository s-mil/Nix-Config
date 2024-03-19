{ config, pkgs, pkgs-unstable,lib, inputs, ... }:
let

  Hostname = "freya";

in
{
    networking =
    {
      hostName = Hostname;
      hostId = "007f0202";
      firewall.enable = false;
      interfaces= {
        eno1 = {
          useDHCP = false;
          ipv4.addresses = [ {
            address = "10.10.0.11";
            prefixLength = 16;
          } ];
        };
      };
      defaultGateway = "10.0.0.1";
      nameservers = [ "1.1.1.1" ];
    };
    imports =
    [
        ../common.nix
        ../bootloaders/systemd.nix
        ../displayManager/sddm.nix
        ../windowManager/sway.nix
        ../desktopEnvironment/kde.nix
        ../users/root/user.nix
        ../users/sithis/user.nix
        ../tweaks/brother_printer.nix
    ];
  

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  virtualisation.docker = {
    enable= true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  services.k3s = {
    enable = true;
    role = "server";
  };
}

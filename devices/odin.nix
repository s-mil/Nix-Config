{ config, pkgs, pkgs-unstable,lib, inputs, ... }:
let

  Hostname = "odin";

in
{
    networking =
    {
      hostName = Hostname;
      hostId = "007f0200";
      firewall.enable = false;
      interfaces= {
        enp6s18 = {
          useDHCP = false;
          ipv4.addresses = [ {
            address = "10.10.0.64";
            prefixLength = 16;
          } ];
        };
      };
      defaultGateway = "10.10.0.1";
      nameservers = [ "10.40.0.2" ];
    };

    imports =
    [
        ../bootloaders/systemd.nix
        ../displayManager/sddm.nix
        ../windowManager/sway.nix
        ../desktopEnvironment/kde.nix
        ../desktopEnvironment/sunshine.nix
        ../users/root/user.nix
        ../users/sithis/user.nix
        ../tweaks/emulation.nix
    ];
  

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  services.sunshine.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  virtualisation.docker = {
    enable= true;
    enableNvidia = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  programs.steam.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false; 
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed most of the time
    modesetting.enable = true;

	# Enable power management (do not disable this unless you have a reason to).
	# Likely to cause problems on laptops and with screen tearing if disabled.
	powerManagement.enable = true;

    # Use the open source version of the kernel module ("nouveau")
	# Note that this offers much lower performance and does not
	# support all the latest Nvidia GPU features.
	# You most likely don't want this.
    # Only available on driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;
  };
}

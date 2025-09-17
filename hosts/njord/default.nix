{ inputs, config, pkgs, ... }:

let
  Hostname = "njord";
  mountPoint = "/boot";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.hardware.nixosModules.common-cpu-amd
      inputs.hardware.nixosModules.common-pc-ssd
      ../common/core
      
      ../common/optional/services/openssh.nix # allow remote SSH access
      ../common/optional/pipewire.nix # audio
      ../common/optional/services/docker.nix
      ../common/optional/services/rustic-container-timer.nix
      ../common/optional/sops.nix
      ../common/users/sithis
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = Hostname;
    hostId = "007f0201";
    firewall.enable = false;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "10.0.0.102";
            prefixLength = 8;
          }
        ];
      };
      ens19 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "10.0.0.102";
            prefixLength = 8;
          }
        ];
      };
    };
    defaultGateway = "10.0.0.1";
    nameservers = [
      "10.0.0.102"
      "10.10.0.64"
    ];
  }; 

  sops.secrets.odin_cache = { };

  services.xserver.enable = true;

  services.nix-serve = {
   enable = true;
   secretKeyFile = config.sops.secrets.odin_cache.path;
   port = 22222;
  };
  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sithis = {
    isNormalUser = true;
    description = "Sam Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
   git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   services.qemuGuest.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

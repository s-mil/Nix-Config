{ inputs, lib, config, pkgs, pkgs-unstable, ... }:
let
  baseconfig = { allowUnfree = true; };
in
{

    
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  networking = {
    networkmanager = {
      enable = true;
    };
  };

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

  console = {
    keyMap = "us";
  };

  time.timeZone="America/Chicago";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "Iosevka" "FiraCode" "DroidSansMono" ]; })
  ];

  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  environment.systemPackages = with pkgs; [
    nano
    git
    tldr
    sshfs
    btop
    p7zip
    zsh
    just
    dig

  ];


  services.tailscale = {
    enable = true;
    port = 41641;
    package = pkgs.tailscale;
    };


  system = {
    stateVersion = "23.05";
  };
}

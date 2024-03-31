{ inputs, lib, config, pkgs, pkgs-unstable, ... }:
let baseconfig = { allowUnfree = true; };
in {

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;
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
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = { config = { allowUnfree = true; }; };

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

  console = { keyMap = "us"; };

  time.timeZone = "America/Chicago";

  imports = [ 
    inputs.sops-nix.nixosModules.sops
    inputs.xremap-flake.nixosModules.default
   ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      # Where the ssh host keys live
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # Store in a safe location
      keyFile = "/var/lib/sops-nix/key.txt";
      # If it doesnt exist yet make it
      generateKey = true;
    };

    #will exist in /run/secrets as files/folders
    secrets = { example_key = { }; };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "Hack" "Iosevka" "FiraCode" "DroidSansMono" ];
      })
    ];

  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  environment.systemPackages = with pkgs; [
    nano
    git
    tldr
    sshfs
    btop
    age
    sops
    p7zip
    zsh
    just
    dig
    cifs-utils
    ranger
    nushell
    nixfmt
    nixd
    zellij
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Enable flatpak
  services.flatpak.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.tailscale = {
    enable = true;
    port = 41641;
  };

  services.xremap = {
    serviceMode = "user";
    userName = "sithis";
    withWlroots = true;
  };
  services.xremap.config = {
    modmap = [{
      name = "Global";
      remap = {
        "CapsLock" = {
          alone = "Esc";
          held = "CTRL_R";
          alone_timeout = 500;
        };
      }; # globally remap CapsLock to Esc
    }];
    keymap = [{
      name = "RightCtrl+hjkl to Arrows";
      remap = {
        "Ctrl_R-h" = "Left";
        "Ctrl_R-l" = "Right";
        "Ctrl_R-j" = "Down";
        "Ctrl_R-k" = "Up";
      };
    }];
  };

  system = { stateVersion = "23.05"; };
}

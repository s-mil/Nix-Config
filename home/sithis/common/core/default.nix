{ config, lib, pkgs, outputs, unstable, ... }: {
  imports = [
    ./bash.nix
    ./zsh.nix
    ./git.nix
    ./jujutsu.nix
    ./nvim.nix
    ./alacritty.nix
    ./bat.nix
    ./zoxide.nix
    ./vscode.nix
    ./wofi.nix
    ./catppuccin-gtk.nix

  ] ++ (builtins.attrValues outputs.homeManagerModules);

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault "sithis";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" "$HOME/.cargo/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/git/Nix-Config";
      SHELL = "zsh";
      TERM = "alacritty";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      MANPAGER = "batman";
    };
  };

  home.packages = with pkgs; [
    firefox-devedition
    spotify
    spotifyd
    vlc
    btop
    htop
    neofetch
    gparted
    unzip
    trash-cli
    wget
    curl
    docker-compose
    gcc
    rustup
    python3Full
    ansible
    xclip
    ffmpeg
    vlc
    xf86_input_wacom
    wacomtablet
    libwacom
    libsecret
    unstable.signal-desktop
    ghidra
    unstable.tailscale
    gh
    pssh
    du-dust
    bitwarden-cli
    fd
    python311Packages.pynvim
    lazygit
    tree-sitter
    unstable.nodejs_21
    ripgrep
    ffmpeg
    discord
    moonlight-qt
    rustdesk
    pcmanfm
    catppuccin-gtk
    catppuccin-kde
    catppuccin-cursors
    helix
    pkg-config
    openssl.dev
    brlaser
    unstable.dotnet-sdk_8
    pika-backup
    go
    gox
    turso-cli
    sqld
    via
    vial
    qmk
    qmk_hid
    qmk-udev-rules
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  programs = { home-manager.enable = true; };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}

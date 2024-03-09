{ config, pkgs, unstable, lib, ... }:
let

in
{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
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
    unstable.texliveFull
    unstable.dotnet-sdk_8
    pika-backup
    go
    gox
    turso-cli
    sqld
  ];
  

}

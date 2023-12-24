{ config, pkgs, unstable, lib, ... }:
let

in
{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  home.packages = with pkgs; [
    firefox-devedition
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
    postman
    libsecret
    unstable.signal-desktop
    ghidra
    tailscale
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
    pkgconfig
    openssl.dev
    brlaser
  ];

}

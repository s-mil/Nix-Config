{ config, pkgs, unstable, lib, ... }:
let

in {
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  home.packages = with pkgs; [
    firefox
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
    libsecret
    unstable.tailscale
    gh
    pssh
    du-dust
    fd
    python311Packages.pynvim
    lazygit
    tree-sitter
    ripgrep
    ffmpeg
    pcmanfm
    catppuccin-gtk
    catppuccin-kde
    catppuccin-cursors
    pika-backup
  ];

}

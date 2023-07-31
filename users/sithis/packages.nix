{ config, pkgs, pkgs-unstable, lib, ... }:
let

in
{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  home.packages = with pkgs-unstable; [
    firefox
    vlc
    btop
    htop
    neofetch
    gparted
    unzip
    trash-cli
    vscode
    neovim
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
    signal-desktop
    ghidra
    tailscale
  ];



}
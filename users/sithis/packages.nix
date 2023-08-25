{ config, pkgs, lib, ... }:
let

in
{
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
    xf86_input_wacom
    wacomtablet
    libwacom
    postman
    libsecret
    signal-desktop
    ghidra
    tailscale
    gh
    pssh
    du-dust
    bitwarden-cli
    ffmpeg
  ];



}

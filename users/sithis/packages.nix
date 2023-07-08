{ config, pkgs, unstable, lib, ... }:
let

in
{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  home.packages = [
    pkgs.firefox
    pkgs.vlc
    pkgs.btop
    pkgs.htop
    pkgs.neofetch
    pkgs.gparted
    pkgs.unzip
    pkgs.trash-cli
    pkgs.vscode
    pkgs.neovim
    pkgs.wget
    pkgs.curl
    pkgs.docker-compose
    pkgs.gcc
    pkgs.rustup
    pkgs.python3Full
    pkgs.ansible
    pkgs.xclip
    pkgs.ffmpeg
    pkgs.vlc
    pkgs.xf86_input_wacom
    pkgs.wacomtablet
    pkgs.libwacom
    pkgs.postman
    pkgs.libsecret
    unstable.signal-desktop
    unstable.ghidra
    unstable.tailscale
  ];
}
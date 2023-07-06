{ config, pkgs, lib, ... }:
let

  Hostname = "thor";

in
{
    networking.hostName = Hostname;

    imports =
    [
        ../common.nix
        ../bootloaders/systemd.nix
        ../displayManager/sddm.nix
        ../windowManager/sway.nix
        ../desktopEnvironment/kde.nix
        ../users/root/user.nix
        ../users/sithis/user.nix

    ];

  virtualisation.docker.enable= true;

  programs.steam.enable = true;
}
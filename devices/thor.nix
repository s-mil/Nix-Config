{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
let

  Hostname = "thor";

in {
  networking.hostName = Hostname;

  imports = [
    ../common.nix
    ../bootloaders/systemd.nix
    ../displayManager/sddm.nix
    ../windowManager/sway.nix
    ../desktopEnvironment/kde.nix
    ../users/root/user.nix
    ../users/sithis/user.nix
    ../tweaks/emulation.nix
    ../tweaks/laptop.nix
  ];

  networking = { networkmanager = { enable = true; }; };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };
  # programs.steam.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
}

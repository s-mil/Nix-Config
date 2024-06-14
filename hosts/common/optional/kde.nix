{ inputs, pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.kdeconnect.enable = true;

}

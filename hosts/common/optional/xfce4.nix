{ inputs, pkgs, ... }: {
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.enableScreensaver = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

}

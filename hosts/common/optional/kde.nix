{ inputs, pkgs, ... }: {
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    useQtScaling = true;

  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  programs.kdeconnect.enable = true;

}

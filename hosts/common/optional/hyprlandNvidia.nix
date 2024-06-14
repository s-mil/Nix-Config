{ inputs, pkgs, unstable, ... }: {

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    wlogout
    swaynotificationcenter
    mako
    wofi
    waybar
    eww
    xdg-desktop-portal-hyprland
    wl-clipboard
    wf-recorder
    pavucontrol
    pulseaudio
    xfce.thunar
  ];
  environment.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME= "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  xdg.portal.enable = true;
  programs.waybar.enable = true;
  security.polkit.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable gnome keyring
  services.gnome.gnome-keyring.enable = true;
}

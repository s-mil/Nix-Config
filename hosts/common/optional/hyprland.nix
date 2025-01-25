{
  inputs,
  pkgs,
  unstable,
  ...
}:
{

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
    wofi
    waybar
    xdg-desktop-portal-hyprland
    wl-clipboard
    wf-recorder
    pavucontrol
    pulseaudio
    xfce.thunar
    kdePackages.polkit-kde-agent-1
    xwayland
  ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal.enable = true;
  programs.waybar.enable = true;
  security.polkit.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable gnome keyring
  services.gnome.gnome-keyring.enable = true;
}

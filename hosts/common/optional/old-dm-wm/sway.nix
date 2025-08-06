{ inputs, pkgs, ... }: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako
      wofi
      sway-contrib.grimshot
      pavucontrol
      pulseaudio
      xfce.thunar
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  qt.enable = true;
  qt.platformTheme = "kde";
  programs.waybar.enable = true;
  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable gnome keyring
  services.gnome.gnome-keyring.enable = true;
}

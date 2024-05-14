{ config, ... }: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    monitor = [ ",preferred,auto,1" ];

    env = [ "QT_WAYLAND_DISABLE_WINDOWDECORATION,1" "XCURSOR_SIZE,24" ];

    input = {
      kb_layout = "us";

      follow_mouse = 1;

      touchpad.natural_scroll = true;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
    };

    general = {
      gaps_in = 4;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" =
        "rgba(136, 57, 239, 1) rgba(203, 166, 247, 1) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      layout = "dwindle";

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;
    };

    decoration = {
      rounding = 16;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 1.0e-2;

        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        passes = 4;
        size = 7;

        popups = true;
        popups_ignorealpha = 0.2;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(136, 57, 239, 1)";
    };

    animations = {
      enabled = true;

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      andimation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];

    };

    dwindle = {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile =
        true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
    };

    master = {
      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      new_is_master = true;
    };

    gestures = {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      workspace_swipe = true;
    };

    misc = {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      force_default_wallpaper =
        0; # Set to 0 to disable the anime mascot wallpapers
    };

    xwayland.force_zero_scaling = true;
  };
}

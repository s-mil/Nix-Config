{ config, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {

    exec-once = [
      # bar
      "waybar"

      # Core components (authentication, lock screen, notification daemon)
      "gnome-keyring-daemon --start --components=secrets"
      "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
      "hypridle"
      "exec = mako"
      "hyprpaper"
      "nm-applet --indicator"

      # Clipboard: history
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];

  };
}

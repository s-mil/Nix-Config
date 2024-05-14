{ config, pkgs, ... }:
{
  #   wayland.windowManager.hyprland.settings = {
  #     "$mod" = "SUPER";
  #     bind = [
  #       "$mod, F, exec, firefox"
  #       ", Print, exec, grimblast copy area"
  #       "$mod, ENTER, exec, alacritty"
  #       "$mod, d, exec, wofi -c ~/.config/wofi/config -I"
  #       ]
  #       ++ (
  #         # workspaces
  #         # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  #         builtins.concatLists (builtins.genList (x:
  #           let
  #             ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
  #           in [
  #             "$mod, ${ws}, workspace, ${toString (x + 1)}"
  #             "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
  #           ]) 10));
  #   };

  # xdg.configfile."hypr/hyprland.conf".text=''

  # '';
}

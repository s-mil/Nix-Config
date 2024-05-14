{ inputs, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    # systemd = {
    #   variables = [ "--all" ];
    #   extraCommands = [
    #     "systemctl --user stop graphical-session.target"
    #     "systemctl --user start hyprland-session.target"
    #   ];
    # };
  };
}

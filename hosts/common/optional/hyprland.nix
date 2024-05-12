{ inputs, pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    unstable.hyprcursor
    unstable.hyprlock
    unstable.hypridle
    hyprpaper
    mako
    wofi
  ];
}

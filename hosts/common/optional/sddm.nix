{ inputs, pkgs, ... }: {
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-sddm-corners";
    settings = { General = { InputMethod = " "; }; };
    wayland.enable = true;
  };

}

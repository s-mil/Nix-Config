{ inputs, pkgs, unstable, ... }: {
  
  environment.systemPackages = [(
  pkgs.catppuccin-sddm.override {
    flavor = "mocha";
    font  = "Hack Nerd Font";
    fontSize = "15";
    background = "/home/sithis/.config/background.png";
    loginBackground = true;
  }
)];
  
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm = {
    enable = true;
    extraPackages = [
      pkgs.kdePackages.sddm-kcm
    ];
    theme = "catppuccin-mocha";
    settings = { General = { InputMethod = " "; }; };
    wayland.enable = true;
  };
}

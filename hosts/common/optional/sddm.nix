{ pkgs, ... }: {

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Hack Nerd Font";
      fontSize = "15";
      background = "/home/sithis/.config/background.png";
      loginBackground = true;
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    extraPackages = [ pkgs.kdePackages.sddm-kcm ];
    settings = { General = { InputMethod = " "; }; };
    wayland.enable = true;
  };
}

{ config, pkgs, unstable, ... }: {
  environment.systemPackages = with pkgs; [ 
    brightnessctl
    libsForQt5.qt5.qtgraphicaleffects
  ];
}

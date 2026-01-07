{ inputs, pkgs, unstable, ... }: {

  environment.systemPackages = with pkgs; [
    steamtinkerlaunch
    sunshine
    protonup-ng
    protontricks
    steam-run
    mangohud
  ];

   programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.steam = {
    enable = true;

    # localNetworkGameTransfers.openFirewall = true; # Future version
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin steamtinkerlaunch ];

  };
  hardware.xone.enable = true;
  # programs.gamemode.enable = true;
}

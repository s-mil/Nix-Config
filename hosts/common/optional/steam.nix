{ inputs, pkgs, unstable, ... }: {

  environment.systemPackages = with pkgs; [
    steamtinkerlaunch
    sunshine
    mangohud
    protonup
    protontricks
    gamemode
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
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin steamtinkerlaunch ];

  };

  # programs.gamemode.enable = true;
}

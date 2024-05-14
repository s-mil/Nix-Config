{ inputs, pkgs, unstable, ... }: {

  environment.systemPackages = with pkgs; [
    unstable.steamtinkerlaunch
    sunshine
    mangohud
    protonup
    protontricks
  ];

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

{ inputs, pkgs, unstable, ... }: {

  environment.systemPackages = with pkgs; [ unstable.steamtinkerlaunch ];

  programs.steam = {
    enable = true;

    # localNetworkGameTransfers.openFirewall = true; # Future version
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin steamtinkerlaunch ];

  };
}

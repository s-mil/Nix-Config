{ inputs, pkgs, ... }: {
  programs.steam = {
    enable = true;

    # localNetworkGameTransfers.openFirewall = true; # Future version
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

  };
  #programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ]; # Future Version
}

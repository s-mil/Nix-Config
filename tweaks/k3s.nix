{ config, pkgs, ... }:
{
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  environment.systemPackages = with pkgs; [
    k3s
    nfs-utils
  ];

  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost"; 
  }
}

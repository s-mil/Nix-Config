{ config, pkgs, ... }:
{
 environment.systemPackages = with pkgs; [
  k3s
  nfs-utils
  ];

  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost"; 
  }
}

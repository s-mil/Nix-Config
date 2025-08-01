{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ cups-brother-mfcl2750dw ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}

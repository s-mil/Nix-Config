{ config, pkgs, ... }:
{

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    brlaser 
    cups-brother-mfcl2750dw
  ];
}

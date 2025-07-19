{ config, pkgs, ... }:
{
  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    package = pkgs.sunshine.override { cudaSupport = true; };

  };

}

{ config, lib, pkgs, unstable, ... }: {
  services.sunshine = {
    enable = true;
    capSysAdmin = true;

  };
}

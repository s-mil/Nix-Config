{ config, pkg, ... }:
let
  mountPoint = "/boot";
in
{
  boot = {
    loader = {
      grub = {
        useOSProber = true;
        enable = true;
        configurationLimit = 10;
        device = "/dev/sda";
      };
    };
  };
}

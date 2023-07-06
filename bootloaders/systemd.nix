{ config, pkg, ... }:
let
  mountPoint = "/boot";
in
{
  boot = {
    loader = {
      systemd-boot = {
        editor = true;
        enable = true;
      };
      efi = {
        efiSysMountPoint = mountPoint;
      };
    };
  };
}

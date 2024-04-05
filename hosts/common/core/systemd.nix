{ config, pkg, ... }:
let mountPoint = "/boot";
in {
  boot = {
    loader = {
      systemd-boot = {
        editor = true;
        enable = true;
        configurationLimit = 10;
      };
      efi = { efiSysMountPoint = mountPoint; };
    };
  };
}

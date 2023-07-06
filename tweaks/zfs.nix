{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.zfs
    pkgs.lz4
  ];
  # ZFS is a pain in the ass with it's own mounting when paired with the hardware config.
  # Disabling the service is the easiest solution.
  systemd.services = {
    zfs-mount = {
      enable = false;
      restartIfChanged = false;
    };
  };
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];
  # Consistent hostID. Idk why this is required. It makes it difficult to move a ZFS drive to another computer.
  networking.hostId = "27c52aa1";
}

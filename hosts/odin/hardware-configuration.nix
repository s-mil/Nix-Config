{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1844c22d-a8ef-4cd1-9a02-8af87e880349";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/1844c22d-a8ef-4cd1-9a02-8af87e880349";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/1844c22d-a8ef-4cd1-9a02-8af87e880349";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/1844c22d-a8ef-4cd1-9a02-8af87e880349";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/1844c22d-a8ef-4cd1-9a02-8af87e880349";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

fileSystems."/boot" =
  {
    device = "/dev/disk/by-uuid/433B-90D1";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=022" ];
  };


  swapDevices = [ { device = "/swap/swapfile"; } ];

  networking.useDHCP = lib.mkDefault true;


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

{ inputs, pkgs, ... }: {
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";

  };
}

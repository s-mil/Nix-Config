{ config, inputs, pkgs, lib, ... }: {
  services.tailscale = {
    enable = true;
    port = 41641;
  };
}

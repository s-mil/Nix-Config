{ config, pkgs, ... }:
{
 environment.systemPackages = with pkgs; [
    cups-brother-mfcl2750dw
  ];
}

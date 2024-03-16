{ config, pkgs, ... }:
{
 environment.systemPackages = with pkgs; [
   brightnessctl
   kubectl
   kubernetes-helm
   fluxcd
   fluxctl
  ];
}

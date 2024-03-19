{ config, pkgs, unstable,... }:
{
 environment.systemPackages = with pkgs; [
   brightnessctl
   kubectl
   kubernetes-helm
   unstable.fluxcd
   unstable.fluxctl
  ];
}

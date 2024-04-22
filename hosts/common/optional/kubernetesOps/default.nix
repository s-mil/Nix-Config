{ config, pkgs, unstable, ... }: {
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
    unstable.fluxcd
    unstable.fluxctl
  ];
}

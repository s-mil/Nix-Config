{ config, pkgs, unstable, ... }: {
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
    fluxcd
    talosctl
  ];
}

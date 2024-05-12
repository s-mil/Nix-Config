{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nano
    git
    tldr
    sshfs
    btop
    age
    sops
    p7zip
    zsh
    just
    dig
    cifs-utils
    ranger
    nixfmt
    nixd
    zellij
    unstable.nh
    catppuccin-sddm-corners
  ];
}

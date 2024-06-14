{ pkgs, inputs, ... }: {
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
    syncthing
    syncthing-tray
    inputs.nixvim.packages."x86_64-linux".default
  ];

}

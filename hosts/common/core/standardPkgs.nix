{ pkgs, ... }:
{
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
    nixfmt-rfc-style
    nixd
    zellij
    nh
    syncthing
    syncthingtray
    # inputs.nixvim.packages."x86_64-linux".default
    wdisplays
    devenv
    direnv
    rclone
    zed-editor
    ghostty
    fish
  ];

}

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
    nixfmt-classic
    nixd
    zellij
    unstable.nh
    syncthing
    syncthingtray
    inputs.nixvim.packages."x86_64-linux".default
    wdisplays
    devenv
    direnv
    rclone
  ];

}

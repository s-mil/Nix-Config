{pkgs, inputs, unstable,...}: {
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    unstable.nano
    unstable.git
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
    beszel
    wdisplays
    devenv
    direnv
    rclone
    zed-editor
    ghostty
    fish
    caligula
    openssl
    inputs.nixvim.packages.${system}.nixCats
  ];
}

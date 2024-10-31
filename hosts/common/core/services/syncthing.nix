{ ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/sithis/syncthing";
    user = "sithis";
    group = "users";

  };
}

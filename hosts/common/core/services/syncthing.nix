{ ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/sithis/syncthing";
    databaseDir = "/home/sithis/.config/syncthing";
    user = "sithis";
    group = "users";

  };
}

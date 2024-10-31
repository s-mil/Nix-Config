{ ... }: {
  services.syncthing = {
    enable = true;
    dataDir = "/home/sithis/syncthing";
  };
}

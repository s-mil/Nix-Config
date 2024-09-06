{ ... }: {
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
    daemon.settings = {
      features = {
        cdi = true;
      };
    };
  };
}

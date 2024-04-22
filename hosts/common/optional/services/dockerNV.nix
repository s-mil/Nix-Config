{ inputs, pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

}

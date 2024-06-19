{ inputs, pkgs, ... }: {
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
  virtualisation.containers.cdi.dynamic.nvidia.enable = true;
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
  ];
}

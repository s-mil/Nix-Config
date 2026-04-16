{ pkgs, config, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    gsp.enable = true;
    videoAcceleration = true;
    nvidiaSettings = true;
  };
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_latest_open ];
  # CONTAINERS
  hardware.nvidia-container-toolkit = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];

  # HYPRLAND ENV
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

}

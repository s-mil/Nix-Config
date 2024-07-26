{ inputs, pkgs, config, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  # CONTAINERS
  hardware.nvidia-container-toolkit.enable = true;
  environment.systemPackages = with pkgs; [ cudatoolkit ];
  virtualisation.containers.cdi.dynamic.nvidia.enable = true;

# HYPRLAND ENV
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME= "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

}

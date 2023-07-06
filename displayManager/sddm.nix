{ inputs, pkgs, ...}:
{
    services.xserver.enable = true;
    services.xserver.displayManager.sddm = {
        enable = true;

    };
}

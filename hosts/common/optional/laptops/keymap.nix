{ inputs, lib, config, pkgs, pkgs-unstable, ... }:
{
  services.xremap = {
    serviceMode = "user";
    userName = "sithis";
    withWlroots = true;
  };
  services.xremap.config = {
    modmap = [{
      name = "Global";
      remap = {
        "CapsLock" = {
          alone = "Esc";
          held = "CTRL_R";
          alone_timeout = 500;
        };
      }; # globally remap CapsLock to Esc
    }];
    keymap = [{
      name = "RightCtrl+hjkl to Arrows";
      remap = {
        "Ctrl_R-h" = "Left";
        "Ctrl_R-l" = "Right";
        "Ctrl_R-j" = "Down";
        "Ctrl_R-k" = "Up";
      };
    }];
  };
}

{ config, lib, pkgs, unstable, ... }:

with lib;

let

  cfg = config.services.sunshine;

in {
  options = {

    services.sunshine = { enable = mkEnableOption (mdDoc "Sunshine"); };

  };

  config = mkIf config.services.sunshine.enable {

    environment.systemPackages = [ unstable.sunshine ];

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${unstable.sunshine}/bin/sunshine";
    };

    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';


    systemd.user.services.sunshine = {
      description = "sunshine";
      wantedBy = [ "graphical-session.target" ];
      startLimitBurst = 5;
      startLimitIntervalSec = 500;
      serviceConfig = {
        ExecStart = "${config.security.wrapperDir}/sunshine";
        Restart = "always";
        RestartSec = "5s";
      };
    };

  };
}

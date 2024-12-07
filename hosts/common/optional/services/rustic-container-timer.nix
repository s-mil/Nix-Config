{ pkgs, ... }:
let
  schedule = "daily";
  AccuracySec = "1m";
  RandomizedDelaySec = "1h";

in {
  systemd.timers."Backup-Containers" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = schedule;
      AccuracySec = AccuracySec;
      RandomizedDelaySec = RandomizedDelaySec;
      Persistent = true;
      Unit = "Backup-Containers.service";
    };
  };

  systemd.services."Backup-Containers" = {
    script = ''
      ${pkgs.rustic}/bin/rustic backup  
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "sithis";
    };
  };

  systemd.timers."Backup-Containers-Forget" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = schedule;
      AccuracySec = AccuracySec;
      RandomizedDelaySec = RandomizedDelaySec;
      Persistent = true;
      Unit = "Backup-Containers-Forget.service";
    };
  };
  systemd.services."Backup-Containers-Forget" = {
    script = ''
      ${pkgs.rustic}/bin/rustic forget
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "sithis";
    };
  };
}

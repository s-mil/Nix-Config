{pkgs, ...}:{
  systemd.timers."Backup-Containers" = {
    wantedBy = [ "timers.target"];
      timerConfig = {
        OnCalendar = "*-*-* 4:00:00";
        Persistent = true;
        Unit = "Backup-Containers.service";
      };
  };

  systemd.services."Backup-Containers"={
    script = ''
    ${pkgs.rustic}/bin/rustic backup  
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "sithis";
    };
  };

}

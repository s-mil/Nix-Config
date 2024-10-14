{pkgs, ...}:{
  systemd.timers."Backup-Picutres" = {
    wantedBy = [ "timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "Backup-Pictures.service";
      };
  };

  systemd.services."Backup-Pictures"={
    script = ''
    ${pkgs.rclone}/bin/rclone copy  
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "sithis";
    };
  };

}

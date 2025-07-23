{pkgs, ...}:{
  services.prometheus = {
    enable = true;
    port = 9001;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9002;
      };
    };
    scrapeConfigs = [
      {
        job_name = "${builtins.getEnv "HOSTNAME"}-scrape";
        static_configs = [
          {
            targets = [ "127.0.0.1:9002" ];
          }
        ];
      }
    ];
  };
  xdg.configFile."loki/loki.yaml".text =''

  '';
 services.loki = {
   enable = true;
   extraFlags = [ "--server.http-listen-port=3101" ];
   configFile = /home/sithis/loki/loki.yaml;
 };

  systemd.services.promtail = {
    description = "Promtail service for Loki";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.grafana-loki}/bin/promtail --config.file ${/home/sithis/.config/promtail.yaml}
      '';
    };
  };
}

{
  config,
  ...
}:
{
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
  services.loki = {
    enable = true;
    extraFlags = [ "--server.http-listen-port=3101" ];

  };

  # configuration = {
  #   auth_enabled = false;
  #   server = {
  #     http_listen_port = 3100;
  #   };
  #   ingester = {
  #     lifecycler = {
  #       address = "0.0.0.0";
  #       ring = {
  #         kvstore = {
  #           store = "inmemory";
  #         };
  #         replication_factor = 1;
  #       };
  #       final_sleep = "0s";
  #     };
  #     chunk_idle_period = "1h";
  #     max_chunk_age = "1h";
  #     chunk_target_size = 1048576;
  #     chunk_retain_period = "30s";
  #     max_transfer_retries = 0;
  #   };
  #   schema_config = {
  #     configs = [
  #       {
  #         from = "2025-07-21";
  #         store = "tsdb";
  #         object_store = "filesystem";
  #         schema = "v13";
  #         index = {
  #           prefix = "index_";
  #           period = "24h";
  #         };
  #       }
  #     ];
  #   };
  #   storage_config = {
  #     tsdb_shipper = {
  #       active_index_directory = "/var/lib/loki/tsdb-index";
  #       cache_location = "/var/lib/loki/tsdb-cache";
  #       cache_ttl = "24h";
  #       shared_store = "filesystem";
  #     };
  #     filesystem = {
  #       directory = "/var/lib/loki/chunks";
  #     };
  #   };
  #   limits_config = {
  #     reject_old_samples = true;
  #     reject_old_samples_max_age = "168h";
  #   };
  #   chunk_store_config = {
  #     max_look_back_period = "0s";
  #   };
  #   table_manager = {
  #     retention_deletes_enabled = false;
  #     retention_period = "0s";
  #   };
  # };
}

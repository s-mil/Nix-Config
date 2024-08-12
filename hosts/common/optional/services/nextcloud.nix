{
  services.nextcloud = {
    enable = true;
    settings = {
      trusted_proxies = ["10.0.10.64"];
      trusted_domains = ["nextcloud.sammiller.dev" ];
    };
  };
}

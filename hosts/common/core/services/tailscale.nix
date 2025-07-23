{ unstable, ... }: {
  services.tailscale = {
    enable = true;
    package = unstable.tailscale;
    port = 41641;
  };
}

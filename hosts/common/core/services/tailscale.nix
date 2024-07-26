{ unstable, ... }: {
  services.tailscale = {
    enable = true;
    port = 41641;
    package = unstable.tailscale;
  };
}

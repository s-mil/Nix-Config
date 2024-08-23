{ ... }: {
  services.tabby = {
    enable = true;
    port = 6060;
    acceleration = "cuda";
    model = "TabbyML/StarCoder2-7B";
  };
}

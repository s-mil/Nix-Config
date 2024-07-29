{ config, inputs, pkgs, lib, unstable, ... }: {

  services.ollama = {
    enable = true;
    package = unstable.ollama;
    acceleration = "cuda";
    home = "/llm";
    models = "/llm/models";
    port = 11434;
    host = "0.0.0.0";
  };

}

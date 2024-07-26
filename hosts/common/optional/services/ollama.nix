{ config, inputs, pkgs, lib, unstable, ... }: {

  services.ollama = {
    enable = true;
    package = unstable.ollama;
    acceleration = "cuda";
    # serviceConfig.ReadWritePaths = [ "/home/llm" "/home/llm/models" ];
    # home = "/home/llm";
    models = "/home/llm/models";
    port = 11434;
    host = "0.0.0.0";
  };

}

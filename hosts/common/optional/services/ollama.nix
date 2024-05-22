{ config, inputs, pkgs, lib, unstable, ... }: {

services.ollama = {
  enable = true;
  package = unstable.ollama;
  acceleration = "cuda";
  writablePaths = [ "/home/llm" "/home/llm/models" ];
  home = "/home/llm";
  models = "/home/llm/models";
  listenAddress = "0.0.0.0:11434";
};


}

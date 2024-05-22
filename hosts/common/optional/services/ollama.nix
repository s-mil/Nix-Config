{ config, inputs, pkgs, lib, unstable, ... }: {

services.ollama = {
  enable = true;
  package = unstable.ollama;
  accelleration = "cuda";
  writablePaths = [ "/home/llm" "/home/llm/models" ];
  home = "/home/llm";
  models = "/home/llm/models";
  listenAddress = "10.10.0.64:11434";
};


}

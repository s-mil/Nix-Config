{ pkgs, ... }: {

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    home = "/llm";
    models = "/llm/models";
    port = 11434;
    host = "0.0.0.0";
    loadModels = [
        "llama3.2:latest"
        "codellama:latest"
        "mistral:latest"
        "deepseek-r1:8b"
                ];
  };

}

{ pkgs, ... }: {

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    home = "/llm";
    models = "/llm/models";
    port = 11434;
    host = "0.0.0.0";
    loadModels = [
        "llama3.2:latest"
        "mistral-3:8b"
        "deepseek-r1:8b"
        "glm-4.7-flash:q8_0"
        "gpt-oss:20b"
        "qwen3:8b"
];
  };

}

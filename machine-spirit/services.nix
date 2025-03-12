{lib, pkgs, ...}:
{

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.ollama  = {
    enable = true;
    acceleration = false;
    loadModels = ["qwen2.5-coder:1.5b"];
  };

  services.open-webui = {
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
    port = 8084;
    host = "0.0.0.0";
    openFirewall = true;
  };
}

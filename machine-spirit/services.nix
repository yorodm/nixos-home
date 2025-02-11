{lib, pkgs, ...}:
{

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
    host = "192.168.0.109";
    openFirewall = true;
  };
  services.nomad = {
    enable = true;
    enableDocker = true;
    # Nomad as Root to access Docker/Podman sockets.
    dropPrivileges = false;
    # Nomad configuration, as Nix attribute set.
    settings = {
      advertise ={
        # Defaults to the first private IP address.
        http = "192.168.0.109";
        rpc  = "192.168.0.109";
      };
      bind_addr = "0.0.0.0";
      client.enabled = true;
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
    };
  };

  # Do not start when system starts
  # systemd.services.nomad.wantedBy = lib.mkForce [ ];

  # Handy packages
  environment.systemPackages = with pkgs; [
    damon # nomad tui
  ];

}

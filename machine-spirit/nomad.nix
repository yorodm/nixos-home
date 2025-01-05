{lib, pkg, ...}:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };


   services.nomad = {
    enable = true;
    # Add Podman
    extraSettingsPlugins = [ pkgs.nomad-driver-podman ];

    # Nomad as Root to access Docker/Podman sockets.
    dropPrivileges = false;

    # Nomad configuration, as Nix attribute set.
    settings = {
      client.enabled = true;
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      plugin = [{
        nomad-driver-podman = {
          config = { };
        };
      }];
    };
  };

  # Do not start when system starts
  # systemd.services.nomad.wantedBy = lib.mkForce [ ];

  # Handy packages
  environment.systemPackages = with pkgs; [
    nomad-driver-podman
    damon # nomad tui
    podman-compose
    podman-tui
  ];
}

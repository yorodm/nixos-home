{pkgs, ...}:

{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";


  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  programs = {
    fish.enable = true;
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  # services.stubby = {
  #   enable = true;
  #   settings = pkgs.stubby.passthru.settingsExample // {
  #     upstream_recursive_servers = [{
  #       address_data = "116.202.176.26";
  #       tls_auth_name = "dot.libredns.gr";
  #       tls_port = 853;
  #       tls_pubkey_pinset = [{
  #         digest = "sha256";
  #         value = "V0Y0pvWkAwOPkNSPxDyZd/vJ2bo40ylADWJFu/ubPlM=";
  #        }];
  #     }
  #      {
  #       address_data = "158.64.1.29";
  #       tls_auth_name = "dnspub.restena.lu";
  #       tls_port = 853;
  #       tls_pubkey_pinset = [{
  #         digest = "sha256";
  #         value = "aC/vKm0neSr3uDucVsYO62RPZ4ETWjoI0Gw8uWjGdLg=";
  #       }];
  #     }];
  #   };
  # };

  fonts.fontDir.enable = true;
  fonts.fonts = [
    pkgs.monaspace
  ];

  homebrew = {
    enable = true;

    brews = [
       "bat"
       "cfssl"
       "docker"
       "fish"
       "htop"
       "hyperkit"
       "kubernetes-cli"
       "lsd"
       "neofetch"
       "osx-cpu-temp"
       "qemu"
       "ripgrep"
       "smartmontools"
       "starship"
       "watch"
       "wireguard-tools"
    ];
    casks = [
       "font-0xproto-nerd-font"
       "iterm2"
       "keepingyouawake"
       "monitorcontrol"
       "multipass"
       "smcfancontrol"
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
  };

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}

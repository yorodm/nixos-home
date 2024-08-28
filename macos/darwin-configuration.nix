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

  fonts.packages = [
    pkgs.monaspace
    pkgs.nerdfonts
  ];

  homebrew = {
    enable = true;

    brews = [
       "docker"
       "kubernetes-cli"
       "osx-cpu-temp"
       "smartmontools"
       "watch"
       "wireguard-tools"
    ];
    casks = [
       "iterm2"
       "keepingyouawake"
       "monitorcontrol"
       "multipass"
       "smcfancontrol"
       "zed"
    ];
  };

  system.defaults = {
    dock =  {
      appswitcher-all-displays = true;
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.15;
      dashboard-in-overlay = false;
      enable-spring-load-actions-on-all-items = false;
      expose-animation-duration = 0.2;
      expose-group-by-app = false;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = false;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = true;
      showhidden = true;
      static-only = false;
      tilesize = 48;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = [
	    "/System/Applications/Launchpad.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/Applications/Zed.app"
        "/Applications/iTerm.app"
        "/System/Applications/Utilities/Activity Monitor.app"
        "/System/Applications/System Preferences.app"
      ];
      # persistent-others = [ "/Users/${user.login}/Downloads/" ];
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

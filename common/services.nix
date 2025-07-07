{ lib, config, pkgs, ... }:

{
  # Input device configuration
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      disableWhileTyping = true;
    };
  };

  security.pam.services.hyprlock = {};
  # Enable polkit for proper permissions
  security.polkit.enable = true;

  # Configure keymap
  nixpkgs.config.allowUnfree = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "grp:shift_caps_toggle";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Power management
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=10m
      HibernateDelaySec=2h
    '';
  };

  # Enable virtualization
  virtualisation.docker.enable = true;

  # Enable various system services
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.fstrim.enable = true;

  # Audio configuration
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];

  # Networking
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  # Bluetooth
  services.blueman.enable = true;

  # DNS configuration
  networking.networkmanager.dns = "none";
  networking.nameservers = ["127.0.0.1" "::1"];
  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      upstream_recursive_servers = [{
        address_data = "116.202.176.26";
        tls_auth_name = "dot.libredns.gr";
        tls_port = 853;
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = "V0Y0pvWkAwOPkNSPxDyZd/vJ2bo40ylADWJFu/ubPlM=";
         }];
      }
       {
        address_data = "158.64.1.29";
        tls_auth_name = "dnspub.restena.lu";
        tls_port = 853;
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = "aC/vKm0neSr3uDucVsYO62RPZ4ETWjoI0Gw8uWjGdLg=";
        }];
      }];
    };
  };
}

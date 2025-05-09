{ lib, config, pkgs, ... }:

{

  services.libinput.enable = true;
# Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver.enable = true;
  # services.xserver.displayManager.lightdm.greeter.enable = true;
  services.xserver.windowManager.session = lib.singleton {
    name = "xsession";
    start = pkgs.writeScript "xsession" ''
      #!${pkgs.runtimeShell}
        if test -f $HOME/.xsession; then
          exec ${pkgs.runtimeShell} -c $HOME/.xsession
        else
          echo "No xsession script found"
          exit 1
        fi
    '';
  };
  # Configure keymap in X11
  nixpkgs.config.allowUnfree = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "grp:shift_caps_toggle";



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=10m
      HibernateDelaySec=2h
    '';
  };

  virtualisation.docker.enable = true;
  services.udisks2.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # power daemon and firmware
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.fstrim.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # No idea if I need this
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  # Stubby DNS
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

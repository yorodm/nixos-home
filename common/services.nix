{ config, pkgs, ... }:

{
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=10m
      HibernateDelaySec=2h
    '';
  };

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
  # Stubby DNS
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

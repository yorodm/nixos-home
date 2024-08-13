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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;
      AHCI_RUNTIME_PM_ON_BAT = "on";
      AHCI_RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 70;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # power daemon and firmware
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.fstrim.enable = true;
  services.udisks2.enable = true;
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
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = "4pqQ+yl3lAtRvKdoCCUR8iDmA53I+cJ7orgBLiF08kQ=";
        }];
      }];
    };
  };
}

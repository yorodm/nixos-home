{ lib, pkgs, ... }:

{

  # Stay Up Always
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
  services.thermald.enable = true;

  systemd.services.disable-turbo = {
    description = "Disable CPU Turbo Boost";
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      if [ -w /sys/devices/system/cpu/intel_pstate/no_turbo ]; then
        echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
      elif [ -w /sys/devices/system/cpu/cpufreq/boost ]; then
        echo 0 > /sys/devices/system/cpu/cpufreq/boost
      fi
    '';
  };
}

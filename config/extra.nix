{ config, pkgs, ... }:

let
  battery = "BAT0";
  notifyCapacity = 40;
  suspendCapacity = 15;
in {
  services = {
    # xsettingsd = {
    #   enable = true;
    # };
    # screen-locker = {
    #   enable  = true;
    #   lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #   xautolock = {
    #     enable = true;
    #   };
    #   inactiveInterval = 5;
    # };
    poweralertd = {
      enable = true;
    };
    xidlehook = {
      enable = true;
      not-when-fullscreen = true;
      timers = [
        {
          delay = 60 * 15;
          command = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        }
        {
          delay = 60 * 60;
          command = "systemctl suspend";
        }
      ];

    };
    emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
    };
    flameshot = { enable = true; };
  };
  # systemd.user.timers."lowbatt" = {
  #   Unit = {
  #     Description = "check battery level";
  #   };
  #   Timer ={
  #     OnBootSec = "1m";
  #     OnUnitInactiveSec = "1m";
  #   };
  #   Install.WantedBy = [ "timers.target" ];
  # };

  # systemd.user.services."lowbatt" = {
  #   Unit = {
  #     Description = "battery level notifier";
  #   };
  #   Service = {
  #     PassEnvironment = "DISPLAY";
  #     ExecStart = toString (pkgs.writeScript "lowbatt.sh" ''
  #     #! ${pkgs.runtimeShell} -el
  #     export battery_capacity=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${battery}/capacity)
  #     export battery_status=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${battery}/status)
  #     if [[ $battery_capacity -le ${
  #       builtins.toString notifyCapacity
  #     } && $battery_status = "Discharging" ]]; then
  #         ${pkgs.dunst}/bin/dunstify --urgency=critical --icon=battery_empty "Battery Low" "You should probably plug-in."
  #     fi
  #     if [[ $battery_capacity -le ${
  #       builtins.toString suspendCapacity
  #     } && $battery_status = "Discharging" ]]; then
  #         ${pkgs.dunst}/bin/dunstify --urgency=critical -icon=battery_empty "Battery Critically Low" "Computer will suspend in 60 seconds."
  #         sleep 60s
  #         battery_status=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${battery}/status)
  #         if [[ $battery_status = "Discharging" ]]; then
  #             systemctl suspend
  #         fi
  #     fi
  #   '');
  #   };
  # };
}

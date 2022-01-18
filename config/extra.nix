{ config, pkgs, ... }:

{
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
    xidlehook = {
      enable = true;
      not-when-fullscreen = true;
      timers = [{
        delay = 60 * 15;
        command = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
      }];

    };
    emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
    };
    flameshot = { enable = true; };
  };

}

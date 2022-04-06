{ config, pkgs, ... }:

let
  battery = "BAT0";
  notifyCapacity = 40;
  suspendCapacity = 15;
in {
  services = {
    betterlockscreen.enable = true;
    lorri = { enable = true; };
    poweralertd = { enable = true; };
    xidlehook = {
      enable = true;
      not-when-fullscreen = true;
      not-when-audio = true;
      timers = [
        {
          delay = 15 * 60;
          command = "systemctl suspend";
        }
      ];

    };
    udiskie = { enable = true; };
  };
  xdg = {
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/dl";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pics";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
      createDirectories = true;
    };
  };
}

{ config, pkgs, lib, ... }:

let
  battery = "BAT0";
  notifyCapacity = 40;
  suspendCapacity = 15;
in {
  services = {

    poweralertd = { enable = true; };
    xidlehook = {
      enable = true;
      not-when-fullscreen = true;
      timers = [
        {
          delay = 60 * 15;
          command = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        }
        {
          delay = 60 * 30;
          command = "systemctl suspend";
        }
      ];

    };
    udiskie = { enable = true; };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = import ./default-apps.nix;
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

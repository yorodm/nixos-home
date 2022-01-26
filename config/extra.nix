{ config, pkgs, ... }:

let
  battery = "BAT0";
  notifyCapacity = 40;
  suspendCapacity = 15;
  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
      overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
        }))
      ];
    };
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
          delay = 60 * 60;
          command = "systemctl suspend";
        }
      ];

    };
    emacs = {
      enable = true;
      package = unstable.emacsPgtkGcc;
    };
    flameshot = { enable = true; };
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

{
  config,
  pkgs,
  lib,
  ...
}:

let
  battery = "BAT0";
  notifyCapacity = 40;
  suspendCapacity = 15;
in
{
  services = {

    wlsunset = {
      enable = true;
      latitude = "42.698334";
      longitude = "23.319941";
      temperature = {
        day = 6500;
        night = 3500;
      };
    };

    poweralertd = {
      enable = true;
    };
    udiskie = {
      enable = true;
    };
    blueman-applet = {
      enable = true;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = import ./default-apps.nix;
  };
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      xdgOpenUsePortal = true;
    };
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

{ config, pkgs, lib, ... }:

{
  # create ~/.config/systemd/user/default.target.wants/redshift.service to enable
services.gammastep = {
    enable = true;
    tray = true;
    dawnTime = "6:30-7:30";
    duskTime = "18:30-19:30";
    package = pkgs.gammastep;
    temperature = {
      day = 5700;
      night = 4000;
    };
    settings = {
      general = {
        brightness-day = 1;
        gamma-day = 1.3;
        fade = 1;
      };
    };
  };
}

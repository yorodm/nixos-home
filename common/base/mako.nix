# Wayland notification daemon
{ config, pkgs, ... }:

{
  home.packages = [pkgs.libnotify];
  services.mako = {
    enable = true;
    settings = {
      font = "DejaVu Sans Mono 11";
      "background-color" = "#282828";
      "text-color" = "#ebdbb2";
      "border-color" = "#689d6a";
      "progress-color" = "over #98971a";
      width = 400;
      height = 200;
      margin = "10";
      padding = "15";
      "border-size" = 2;
      "default-timeout" = 10000;
    };
  };
}

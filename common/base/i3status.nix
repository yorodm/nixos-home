{ config, pkgs, ... }:

{
  programs = {
    i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "backlight";
            }
            {
              alert = 10.0;
              block = "disk_space";
              info_type = "available";
              interval = 60;
              path = "/";
              warning = 20.0;
            }
            {
              block = "memory";
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "temperature";
            }
            {
              block = "sound";
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
              interval = 60;
            }
            {
              block = "net";
            }
            {
              block = "battery";
            }
          ];
        };
      };

    };
  };
}

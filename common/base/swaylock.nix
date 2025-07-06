# Wayland screen locker
{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      color = "282828";
      font = "DejaVu Sans Mono";
      indicator-radius = 100;
      indicator-thickness = 7;
      line-color = "689d6a";
      ring-color = "458588";
      inside-color = "282828";
      key-hl-color = "98971a";
      separator-color = "1d2021";
      text-color = "ebdbb2";
      layout-text-color = "ebdbb2";
      
      # Gruvbox-inspired colors
      ring-ver-color = "98971a";
      inside-ver-color = "282828";
      text-ver-color = "ebdbb2";
      
      ring-wrong-color = "cc241d";
      inside-wrong-color = "282828";
      text-wrong-color = "fb4934";
      
      bs-hl-color = "fb4934";
      
      # Misc settings
      indicator-caps-lock = true;
      show-failed-attempts = true;
      ignore-empty-password = true;
      show-keyboard-layout = true;
    };
  };
}


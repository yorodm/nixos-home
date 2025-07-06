# Screen locking for Wayland
{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      color = "282828";
      font = "DejaVu Sans Mono";
      font-size = 24;
      indicator-radius = 100;
      indicator-thickness = 7;
      inside-color = "282828";
      inside-clear-color = "fabd2f";
      inside-ver-color = "83a598";
      inside-wrong-color = "fb4934";
      key-hl-color = "b8bb26";
      line-color = "282828";
      line-clear-color = "282828";
      line-ver-color = "282828";
      line-wrong-color = "282828";
      ring-color = "689d6a";
      ring-clear-color = "fabd2f";
      ring-ver-color = "458588";
      ring-wrong-color = "cc241d";
      separator-color = "282828";
      text-color = "ebdbb2";
      text-clear-color = "282828";
      text-ver-color = "282828";
      text-wrong-color = "282828";
    };
  };
}


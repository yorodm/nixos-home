# Wayland notification daemon
{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    font = "DejaVu Sans Mono 11";
    backgroundColor = "#282828";
    textColor = "#ebdbb2";
    borderColor = "#689d6a";
    progressColor = "over #98971a";
    width = 400;
    height = 200;
    margin = "10";
    padding = "15";
    borderSize = 2;
    defaultTimeout = 10000;

    # Gruvbox-inspired styling
    extraConfig = ''
      [urgency=low]
      background-color=#282828
      text-color=#a89984
      border-color=#458588

      [urgency=normal]
      background-color=#282828
      text-color=#ebdbb2
      border-color=#689d6a

      [urgency=high]
      background-color=#282828
      text-color=#fb4934
      border-color=#cc241d
    '';
  };
}

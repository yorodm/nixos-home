# Wayland application launcher
{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 32;
      gtk_dark = true;
    };
    
    # Gruvbox-inspired style
    style = ''
      window {
        margin: 0px;
        border: 2px solid #689d6a;
        background-color: #282828;
        border-radius: 10px;
      }

      #input {
        margin: 5px;
        border: 2px solid #458588;
        background-color: #1d2021;
        color: #ebdbb2;
        border-radius: 5px;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #282828;
        border-radius: 5px;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #282828;
        border-radius: 5px;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ebdbb2;
      }

      #entry:selected {
        background-color: #458588;
        border-radius: 5px;
      }

      #text:selected {
        color: #ebdbb2;
      }
    '';
  };
}


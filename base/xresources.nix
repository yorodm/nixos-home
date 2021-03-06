{ config, pkgs, lib, ... }:

{

  xresources.properties = {
    #"st.font" = "Iosevka:pixelsize=14:antialias=true:autohint=true";
    "st.font" = "Fira Code Nerd Font Mono:size=12:antialias=true:autohint=true";
    "st.alpha" = "0.92";
    "st.alphaOffset" = "0.3";

    # !! Set a default font and font size as below:
    # st.font: Monospace-11;

    # ! st.termname: st-256color
    # ! st.borderpx: 2

    # !! Set the background, foreground and cursor colors as below:

    # !! gruvbox:
    "*.color0" = "#1d2021";
    "*.color1" = "#cc241d";
    "*.color2" = "#98971a";
    "*.color3" = "#d79921";
    "*.color4" = "#458588";
    "*.color5" = "#b16286";
    "*.color6" = "#689d6a";
    "*.color7" = "#a89984";
    "*.color8" = "#928374";
    "*.color9" = "#fb4934";
    "*.color10" = "#b8bb26";
    "*.color11" = "#fabd2f";
    "*.color12" = "#83a598";
    "*.color13" = "#d3869b";
    "*.color14" = "#8ec07c";
    "*.color15" = "#ebdbb2";
    "*.background" = "#282828";
    "*.foreground" = "white";
    "*.cursorColor" = "white";
    "Xft.dpi" = "96";
    " Xft.autohint" = "0";
    "Xft.lcdfilter" = "lcddefault";
    " Xft.hintstyle" = "hintfull";
    "Xft.hinting" = "1";
    " Xft.antialias" = "1";
    "Xft.rgba" = "rgb";
  };
}

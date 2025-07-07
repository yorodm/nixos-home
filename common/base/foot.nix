# Wayland terminal emulator
{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Fira Code Nerd Font Mono:size=10";  # Reduced font size from 12 to 10
        dpi-aware = "yes";
        pad = "8x8";
        term = "xterm-256color";
      };
      
      mouse = {
        hide-when-typing = "yes";
      };
      
      colors = {
        # Gruvbox theme
        alpha = "0.92";
        foreground = "ebdbb2";
        background = "282828";
        
        # Normal colors
        regular0 = "1d2021";  # black
        regular1 = "cc241d";  # red
        regular2 = "98971a";  # green
        regular3 = "d79921";  # yellow
        regular4 = "458588";  # blue
        regular5 = "b16286";  # magenta
        regular6 = "689d6a";  # cyan
        regular7 = "a89984";  # white
        
        # Bright colors
        bright0 = "928374";   # bright black
        bright1 = "fb4934";   # bright red
        bright2 = "b8bb26";   # bright green
        bright3 = "fabd2f";   # bright yellow
        bright4 = "83a598";   # bright blue
        bright5 = "d3869b";   # bright magenta
        bright6 = "8ec07c";   # bright cyan
        bright7 = "ebdbb2";   # bright white
      };
    };
  };
}


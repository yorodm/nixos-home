{ config, pkgs, lib, ... }:

let
  emacsclient = "${config.programs.emacs.finalPackage}/bin/emacsclient -c";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];

      window.border = 0;

      gaps = {
        inner = 15;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle # Volume up";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "XF86KbdBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86KbdBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec ${pkgs.xst}/bin/xst -e ${pkgs.zsh}/bin/zsh";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        # "${modifier}+Shift+x" = "exec ${pkgs.rofi-power}/bin/rofi-power";
        # "${modifier}+Shift+b" = "exec ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
        "${modifier}+Shift+f" = "exec ${pkgs.xst}/bin/xst -e ${pkgs.nnn}/bin/nnn";
        "${modifier}+Shift+e" = "exec ${emacsclient}";
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ~/wallpapers/wallpaper.jpg";
          always = true;
          notification = false;
        }
      ];
    };
  };
}

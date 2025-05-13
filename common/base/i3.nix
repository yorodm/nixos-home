{ config, pkgs, lib, ... }:

let
  emacsclient = "${config.programs.emacs.finalPackage}/bin/emacsclient -c";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-rounded;
    config = rec {
      modifier = "Mod4";
      bars = [
        {
          fonts = {
            names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
            style = "Bold Semi-Condensed";
            size = 12.0;
          };
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
      window.border = 15;
      gaps = {
        inner = 5;
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
        "${modifier}+Shift+f" = "exec ${pkgs.xst}/bin/xst -e ${pkgs.yazi}/bin/yazi";
        "${modifier}+Shift+e" = "exec ${emacsclient}";
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ~/wallpapers/wallpaper.png";
          always = true;
          notification = false;
        }
      ];
    };
  };
}

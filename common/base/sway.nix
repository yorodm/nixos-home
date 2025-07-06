{ config, pkgs, lib, ... }:

let
  emacsclient = "${config.programs.emacs.finalPackage}/bin/emacsclient -c";
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      bars = [];
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
        "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot ${pkgs.zsh}/bin/zsh";
        "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.wofi}/bin/wofi --show window";
        "${modifier}+Shift+f" = "exec ${pkgs.foot}/bin/foot ${pkgs.yazi}/bin/yazi";
        "${modifier}+Shift+e" = "exec ${emacsclient}";
        
        # Screen locking
        "${modifier}+l" = "exec ${pkgs.swaylock}/bin/swaylock -f";
        "${modifier}+Escape" = "exec ${pkgs.systemd}/bin/systemctl suspend";
      };

      startup = [
        {
          command = "exec swaymsg workspace 1";
          always = true;
        }
        {
          command = "${pkgs.swaybg}/bin/swaybg --image ~/wallpapers/wallpaper.png --mode fill";
          always = true;
        }
        {
          command = "${pkgs.waybar}/bin/waybar";
          always = true;
        }
      ];
      
      # Wayland-specific settings
      input = {
        "type:keyboard" = {
          xkb_layout = "us, us";
          xkb_variant = ", intl";
          xkb_options = "grp:shift_caps_toggle";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      
      output = {
        "*" = {
          bg = "~/wallpapers/wallpaper.png fill";
        };
      };
    };
    
    # Enable XWayland for compatibility with X11 applications
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}

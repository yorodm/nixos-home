# Waybar configuration for Hyprland
{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 30;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-right = [
          "hyprland/language"
          "idle_inhibitor"
          "backlight"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "tray"
          "clock"
        ];
        "hyprland/language" = {
          format = "{}";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "  ";
            deactivated = " 󰒲  ";
          };
        };
        "backlight" = {
          "device" = "intel_backlight";
          "format" = "{percent}% {icon}";
          "format-icons" = ["" ""];
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "headset" = "";
            "phone" = "";
            "portab  le" = "";
            "default" = [
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
        "network" = {
          "format-wifi" = "  ({bandwidthDownBits})";
          "format-ethernet" = "  ({bandwidthDownBits})";
          "format-disconnected" = "Disconnected ⚠";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
          "tooltip-format-ethernet" = "{ifname}: {ipaddr}/{cidr}";
        };
        "cpu".format = "{usage}%  ";
        "cpu".tooltip = false;
        "temperature" = {
          "format" = "{temperatureC}°C ";
        };
        "temperature".tooltip = false;
        "tray".spacing = 10;
        "tray".icon-size = 14;
        "clock".format = "{:%a, %d %b %Y - %H:%M}";
        "clock".tooltip = false;
        "battery" = {
          "bat" = "BAT0";
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% 󰂄";
          "format-plugged" = "{capacity}%  ";
          "format-icons" = [
            "󰁺"
            "󰁼"
            "󰁾"
            "󰂀"
            "󱈏 "
          ];
        };
        "memory".format = "{percentage}%  ";
      };
    };
    style = ''
       * {
         font-family: Iosevka Nerd Font, Roboto, Helvetica, Arial, sans-serif;
         font-size: 15px;
       }

       window#waybar {
         background-color: #4c566a;
         color: #ffffff;
         transition-property: background-color;
         border-bottom: 0px solid rgba(0, 0, 0, 0);
         transition-duration: .5s;
       }

       #workspaces button {
         padding: 0 5px;
         background-color: transparent;
         border: none;
         border-radius: 0;
       }

       #workspaces button:hover {
         background: #2e3440;
         color: white;
       }

       #workspaces button.active {
         background-color: #5e81ac;
         box-shadow: inset 0 -3px #ffffff;
       }

       #clock,
       #idle_inhibitor
       #battery,
       #cpu,
       #memory,
       #temperature,
       #network,
       #pulseaudio,
       #tray {
         margin: 0 5px;
         padding: 0 2px;
       }

       #idle_inhibitor.activated {
         background-color: #a3be8c;
       }

       #battery.charging {
          color: #a3be8c;
       }

       @keyframes blink {
         to {
            background-color: #ffffff;
            color: black;
         }
       }

       #battery.warning:not(.charging) {
         color: white;
         animation-name: blink;
         animation-duration: 0.5s;
         animation-timing-function: linear;
         animation-iteration-count: infinite;
         animation-direction: alternate;
      }

       #window,
       #workspaces {
         margin: 0 4px;
       }

       .modules-left > widget:first-child > #workspaces {
         margin-left: 0;
       }

       .modules-right > widget:last-child > #workspaces {
         margin-right: 0;
       }

       #network.disconnected {
         background-color: #f53c3c;
       }

       #temperature.critical {
         background-color: #eb4d4b;
       }
    '';
  };
}

# Waybar configuration for Hyprland
{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces" "hyprland/mode" "hyprland/window"];
        modules-center = [];
        modules-right = [
          "backlight"
          "disk"
          "memory"
          "cpu"
          "temperature"
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "tray"
        ];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
        };
        
        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        
        "disk" = {
          interval = 60;
          format = "{percentage_used}% ";
          path = "/";
          warning = 20.0;
          alert = 10.0;
        };
        
        "memory" = {
          format = "{}% ";
        };
        
        "cpu" = {
          format = "{usage}% ";
          interval = 1;
        };
        
        "temperature" = {
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
        
        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        
        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\\n<tt><small>{calendar}</small></tt>";
          format = "{:%a %d/%m %R}";
          interval = 60;
        };
        
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        /* Use both font families to ensure icons are displayed properly */
        font-family: "DejaVu Sans Mono", "Font Awesome 6 Free", "Font Awesome 6 Brands";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(40, 40, 40, 0.9);
        color: #ebdbb2;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ebdbb2;
        border-bottom: 3px solid transparent;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inherit;
        border-bottom: 3px solid #ebdbb2;
      }

      #workspaces button.active {
        background-color: #64727D;
        border-bottom: 3px solid #ebdbb2;
      }

      #workspaces button.urgent {
        background-color: #cc241d;
      }

      #mode {
        background-color: #64727D;
        border-bottom: 3px solid #ebdbb2;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #tray,
      #mode {
        padding: 0 10px;
        margin: 0 4px;
      }

      #battery.charging, #battery.plugged {
        color: #98971a;
      }

      #battery.critical:not(.charging) {
        background-color: #cc241d;
        color: #ebdbb2;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: #ebdbb2;
          color: #cc241d;
        }
      }
    '';
  };
}


{ config, lib, pkgs, ... }:

let
  # A more sophisticated greeter configuration
  greetdHyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    # Hyprland config for greetd
    monitor=,preferred,auto,1
    exec-once=${pkgs.greetd.wlgreet}/bin/wlgreet --command Hyprland
    
    # Set environment variables
    env = XCURSOR_SIZE,24
    env = XCURSOR_THEME,Vanilla-DMZ
    
    # Basic input configuration
    input {
      kb_layout = us
      follow_mouse = 1
      touchpad {
        natural_scroll = true
      }
    }
    
    # Simple styling
    general {
      gaps_in = 5
      gaps_out = 10
      border_size = 2
      col.active_border = rgba(689d6aee)
      col.inactive_border = rgba(282828aa)
      layout = dwindle
    }
    
    # Decoration settings
    decoration {
      rounding = 10
      blur = true
      drop_shadow = true
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
    }
    
    # Animation settings
    animations {
      enabled = true
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }
    
    # Layout settings
    dwindle {
      pseudotile = true
      preserve_split = true
    }
  '';
in
{
  # Configure greetd with wlgreet for Wayland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Use wlgreet with Hyprland for a graphical Wayland greeter
        command = "${pkgs.greetd.wlgreet}/bin/wlgreet --config ${greetdHyprlandConfig} --command Hyprland";
        user = "greeter";
      };
    };
  };

  # Add required packages for the greeter
  environment.systemPackages = with pkgs; [
    greetd.wlgreet
    hyprland
  ];

  # Configure automatic login if desired
  # Uncomment and adjust the following to enable automatic login
  # services.greetd.settings.initial_session = {
  #   command = "Hyprland";
  #   user = "yourusername";
  # };

  # Ensure proper permissions for the greeter
  security.pam.services.greetd.enableGnomeKeyring = true;
}


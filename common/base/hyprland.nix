# Hyprland configuration
{ config, pkgs, lib, ... }:

let
  emacsclient = "${config.programs.emacs.finalPackage}/bin/emacsclient -c";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";

      # Monitor configuration
      monitor = [
        ",preferred,auto,1"
      ];

      # Autostart applications
      #exec-once = [
      #];

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(689d6aee)";
        "col.inactive_border" = "rgba(282828aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration settings
      # decoration = {
      #   rounding = 10;
      #   blur = {
      #     enabled = true;
      #     size = 3;
      #     passes = 1;
      #     new_optimizations = true;
      #   };
      #   drop_shadow = true;
      #   shadow_range = 4;
      #   shadow_render_power = 3;
      #   "col.shadow" = "rgba(1a1a1aee)";
      # };

      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Input settings
      input = {
        kb_layout = "us, us";
        kb_variant = ", intl";
        kb_options = "grp:shift_caps_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
        sensitivity = 0;
      };

      # Layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # master = {
      #   new_is_master = true;
      # };

      # Gestures
      gestures = {
        workspace_swipe = true;
      };

      # Misc settings
      misc = {
        force_default_wallpaper = 0;
      };

      # Window rules
      windowrulev2 = [
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(blueman-manager)$"
        "float,title:^(Picture-in-Picture)$"
      ];

      # Key bindings
      bind = [
        # Basic bindings
        "$mod, Return, exec, ${pkgs.foot}/bin/foot ${pkgs.fish}/bin/fish"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "$mod SHIFT, E, exec, ${emacsclient}"
        "$mod SHIFT, F, exec, ${pkgs.foot}/bin/foot ${pkgs.yazi}/bin/yazi"
        "$mod SHIFT, D, exec, ${pkgs.wofi}/bin/wofi --show window"
        "$mod, Space, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        # Lock screen and power management
        "$mod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$mod, Escape, exec, ${pkgs.systemd}/bin/systemctl suspend"

        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Media keys
      bindel = [
        ", XF86AudioRaiseVolume, exec, amixer set Master 4%+"
        ", XF86AudioLowerVolume, exec, amixer set Master 4%-"
        ", XF86AudioMute, exec, amixer set Master toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set 4%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 4%-"
        ", XF86KbdBrightnessUp, exec, brightnessctl set 4%+"
        ", XF86KbdBrightnessDown, exec, brightnessctl set 4%-"
      ];

      # Move/resize windows with mouse
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

    # Environment variables for Wayland
    extraConfig = ''
      # Environment variables
      env = SDL_VIDEODRIVER,wayland
      env = QT_QPA_PLATFORM,wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = _JAVA_AWT_WM_NONREPARENTING,1
      env = MOZ_ENABLE_WAYLAND,1
      env = XDG_SESSION_TYPE,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
    '';
  };
}

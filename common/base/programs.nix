{ config, pkgs, lib,  ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Yoandy Rodriguez";
      userEmail = "yoandy.rmartinez" + "@" + "gmail.com";
      extraConfig.credential.helper = "store";
      delta.enable = true;
    };
    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        nix-installed = "nix-instantiate --strict --json --eval -E 'builtins.map (p: p.name) (import <nixpkgs/nixos> {}).config.environment.systemPackages' | ${pkgs.jq}/bin/jq  -r '.[]' | sort -u";
        git-dated = ''git commit -m "Updated: `date +'%Y-%m-%d %H:%M:%S'`"'';
        nix-upgrade = "sudo nixos-rebuild switch --upgrade";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "rust"
          "ssh-agent"
          "themes"
          "systemd"
        ];
        theme = "robbyrussell";
      };
    };
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland; # Use Wayland-native Firefox
    };
    mpv = {
      enable = true;
    };
    # In main.nix theres an entry for the engine to use
    zathura = {
      enable = true;
    };
    # Replace feh with a Wayland-compatible image viewer
    imv = {
      enable = true;
    };
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "catppuccin"
        "catpuccin-icons"
        "elm"
      ];
      userSettings = {
        icon_theme = "Catppuccin Mocha";
        theme = "Catppuccin Mocha";
        features = {
          copilot = false;
        };
        assistans = {
          enabled = false;
        };
        telemetry = {
          metrics = false;
          diagnostics = false;
        };
        vim_mode = false;
        ui_font_size = lib.mkForce 16;
        buffer_font_size = lib.mkForce 16;
      };
    };
    
    # Add Wayland-specific utilities
    wl-clipboard = {
      enable = true;
    };
  };
  
  # Add Wayland-specific packages
  home.packages = with pkgs; [
    grim # Screenshot utility for Wayland
    slurp # Region selection for Wayland screenshots
    wl-clipboard # Clipboard utilities for Wayland
    wf-recorder # Screen recording for Wayland
    swaybg # Wallpaper utility for Sway
    swaylock # Screen locker for Sway
    swayidle # Idle management daemon for Sway
    xdg-desktop-portal-wlr # XDG desktop portal for wlroots compositors
  ];
}

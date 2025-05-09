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
    rofi = {
      enable = true;
      theme = ./files/theme.rasi;
      extraConfig = {
        show-icons = true;
        hide-scrollbar = true;
      };
      terminal = "${pkgs.xst}/bin/xst -e ${pkgs.zsh}/bin/zsh";
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
    };
    mpv = {
      enable = true;
    };
    # In main.nix theres an entry for the engine to use
    zathura = {
      enable = true;
    };
    feh = {
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
  };
}

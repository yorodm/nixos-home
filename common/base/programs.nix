{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    # Development
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
      nix-direnv.enable = true;
    };
    # Shell
    fish = {
      enable = true;
    };
    keychain = {
      enable =true;
      enableFishIntegration = true;
    };
    # Utils
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
    mpv = {
      enable = true;
    };
    # In main.nix theres an entry for the engine to use
    zathura = {
      enable = true;
    };
  };
}

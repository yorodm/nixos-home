{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./files.nix
    ./hyprland.nix
    ./waybar.nix
    ./mako.nix
    ./foot.nix
    ./wofi.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./utils.nix
    ./programs.nix
    ./emacs.nix
    ./starship.nix
    ./extraPrograms.nix
  ];

  programs = {
    home-manager.enable = true;
    nix-index.enable = false;
    command-not-found.enable = false;
  };

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 26;
    gtk.enable = true;
    x11.enable = true;
  };

  nixpkgs.config.zathura.useMupdf = true;

  systemd.user = {
    enable = true;
    startServices = "sd-switch";
  };

  home.keyboard = {
    layout = "us, us";
    variant = ", intl";
    options = [
      "grp:shift_caps_toggle" # toggle variants with alt+shift
    ];
  };

  # Wayland-specific environment variables
  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}

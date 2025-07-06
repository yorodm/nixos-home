{ config, pkgs, lib, ... }:

{
  imports = [
    ./wlsunset.nix
    ./sway.nix
    ./waybar.nix
    ./extra.nix
    ./programs.nix
    ./mako.nix
    ./emacs.nix
    ./foot.nix
    ./wofi.nix
    ./extraPrograms.nix
  ];

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;
  };

  fonts.fontconfig.enable = true;
  
  # Remove xsession and replace with wayland configuration
  wayland.enable = true;
  
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 26;
    gtk.enable = true;
    wayland.enable = true;
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

}

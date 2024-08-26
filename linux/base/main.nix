{ config, pkgs, lib, ... }:

{
  imports = [
    ./compton.nix
    ./i3.nix
    ./polybar.nix
    ./redshift.nix
    ./extra.nix
    ./programs.nix
    ./dunst.nix
    ./emacs.nix
    ./xresources.nix
    ./extraPrograms.nix
#    ./wallpapers.nix
  ];

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;
  };

  fonts.fontconfig.enable = true;
  xsession.enable = true;
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 26;
    x11.enable = true;
  };
  nixpkgs.config.zathura.useMupdf = true;
  systemd.user.startServices = true;
  home.keyboard = {
    layout = "us, us";
    variant = ", intl";
    options = [
      "grp:shift_caps_toggle" # toggle variants with alt+shift
    ];
  };
}

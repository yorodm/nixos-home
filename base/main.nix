{ config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
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
  ];

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;
  };

  xsession.enable = true;
  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 26;
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

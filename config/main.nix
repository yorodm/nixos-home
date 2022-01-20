{config, pkgs, lib, ...}:

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
  ];

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;
  };

  xsession.enable = true;
}

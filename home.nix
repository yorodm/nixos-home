{ config, pkgs, lib, ... }:


{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jadex";
  home.homeDirectory = "/home/jadex";
  # Load overlays
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/46c8425e72efd4002343df959ba1ce47381e1eca.tar.gz;
    }))
  ];
  imports = [ ./cachix.nix ./config/main.nix ./packages/main.nix];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

}

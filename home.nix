{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jadex";
  home.homeDirectory = "/home/jadex";

  # imports
  imports = [ ./overlay/main.nix ./cachix.nix ./base/main.nix ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
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

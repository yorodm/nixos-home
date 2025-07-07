# Screen locking for Wayland
{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
  };
}

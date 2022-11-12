{ config, pkgs, ... }:

let
  pinned = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "e179d1e57ad07f1294dcc29ad5283b214a6ae21e";
    sha256 = "mgLxYh21/0h7S/QS8U/QS+zLwlSRiiFOfPkOxLZnPgk=";
  };
  overlay = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "emacs-overlay";
    rev = "63e405c4207a8ff3d3739e3a0f6f7ff7e8b37844";
    sha256 = "k9q3RAv9i4R51F1CZAIUi9AePeeUwYYkJur6Q8YRX0s=";
  };

  overlaid = import (pinned) { overlays = [ (import overlay) ]; };
in {
  services = {
    emacs = {
      enable = true;
      package = overlaid.emacsNativeComp;
    };
  };
  programs = {
    emacs = {
      enable = true;
      package = overlaid.emacsNativeComp;
    };
  };
}

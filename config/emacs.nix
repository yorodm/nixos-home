{ config, pkgs, ... }:

let
  pinned = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/6c4b9f1a2fd761e2d384ef86cff0d208ca27fdca.tar.gz") {
      overlays = [
        (import (builtins.fetchTarball {
          url =
            "https://github.com/nix-community/emacs-overlay/archive/ccf704241a96879f117b49490de1ba617defac25.tar.gz";
        }))
      ];
    };
in {
  services = {
    emacs = {
      enable = true;
      package = pinned.emacsPgtkGcc;
    };
  };
  programs = {
    emacs = {
      enable = true;
      package = pinned.emacsPgtkGcc;
    };
  };
}

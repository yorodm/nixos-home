{ config, pkgs, ... }:

let
  pinned = import (fetchTarball {
    url ="https://github.com/NixOS/nixpkgs/archive/6c4b9f1a2fd761e2d384ef86cff0d208ca27fdca.tar.gz";
    sha256 ="1yl5gj0mzczhl1j8sl8iqpwa1jzsgr12fdszw9rq13cdig2a2r5f";
  }) {
      overlays = [
        (import (builtins.fetchTarball {
          url =
            "https://github.com/nix-community/emacs-overlay/archive/ccf704241a96879f117b49490de1ba617defac25.tar.gz";
          sha256 = "1f0vq4d9b1sg3nqhrrnssaxxha02xyi74skb31p2yic7pa9s18zi";
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

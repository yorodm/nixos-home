{ config, pkgs, ... }:

let
    unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
      overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
        }))
      ];
    };

in {
  programs = {
    git = {
      enable = true;
      userName = "Yoandy Rodriguez";
      userEmail = "yoandy.rmartinez" + "@" + "gmail.com";
    };
    rofi = {
      enable = true;
      theme = "default";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        nix-installed =
          "nix-instantiate --strict --json --eval -E 'builtins.map (p: p.name) (import <nixpkgs/nixos> {}).config.environment.systemPackages' | nix run nixpkgs.jq -c jq -r '.[]' | sort -u";
        git-dated = ''git commit -m "Updated: `date +'%Y-%m-%d %H:%M:%S'`"'';
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "rust" "ssh-agent" "themes" "systemd"];
        theme = "robbyrussell";
      };
    };
    firefox = { enable = true; };
    emacs = {
      enable = true;
      package = unstable.emacsPgtkGcc;
  #    extraPackages = (epkgs: [ epkgs.vterm ]);
    };
    nnn = {
      enable = true;
      package = pkgs.nnn.override ({ withNerdIcons = true; });
    };
    password-store = {
      enable = true;
    };
  };
}

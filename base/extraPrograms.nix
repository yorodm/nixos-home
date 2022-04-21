{ pkgs, ... }:

with pkgs;
let
  default-python = python3.withPackages (python-packages:
    with python-packages; [
      pip
      black
      flake8
      setuptools
      wheel
      twine
      flake8
      virtualenv
    ]);
  # unstable = import (pkgs.fetchFromGitHub {
  #   owner = "NixOS";
  #   repo = "nixpkgs";
  #   rev = "48d63e924a2666baf37f4f14a18f19347fbd54a2";
  #   sha256 = "0dcxc4yc2y5z08pmkmjws4ir0r2cbc5mha2a48bn0bk7nxc6wx8g";
  #   fetchSubmodules = true;
  # }) { };
  unstable = import ( builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable"){};

in {
  home.packages = with pkgs; [

    # UI
    unstable.pkgs.tdesktop
    brightnessctl
    x2goclient
    xorg.xhost
    transmission-gtk
    ungoogled-chromium
    gcc
    gdb
    gnumake
    # Special
    lm_sensors
    # MISC
    protonvpn-cli
    # TERMINAL
    ripgrep
    any-nix-shell
    bpytop
    neofetch
    cava
    zip
    unrar
    unzip
    escrotum
    tree
    gnupg
    aria2
    imagemagick
    feh
    # DEVELOPMENT
    nixfmt
    default-python
    bat
    rnix-lsp
    # SYSADMIN
    #(callPackage ./termius.nix { })
    remmina
    # DEFAULT
    pavucontrol
    # wineWowPackages.stable
    # overlay
    rofi-power
    rofi-bluetooth
    xst
    # Fonts
    emacs-all-the-icons-fonts
  ];

}

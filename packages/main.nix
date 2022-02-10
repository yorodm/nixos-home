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

in {
  home.packages = with pkgs; [

    # UI
    kotatogram-desktop
    brightnessctl
    x2goclient
    xorg.xhost
    # Special
    lm_sensors
    # TERMINAL
    ripgrep
    any-nix-shell
    gotop
    htop
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
    # SYSADMIN
    #(callPackage ./termius.nix { })
    remmina
    # DEFAULT
    pavucontrol
    # wineWowPackages.stable
    # overlay
    rofi-scripts
    xst
  ];

}

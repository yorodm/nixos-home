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
  unstable = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "0b57dfbdd6dc70f6374f80bdf19a40f19cfd83ad";
    sha256 = "eVwVvJUOJFAN0H+l+dnKKIdcRrYie3FprWhmRX3RVwE=";
  }) { };

in {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Music
    lmms
    # UI
    arandr
    unstable.tdesktop
    brightnessctl
    xorg.xhost
    transmission-gtk
    ungoogled-chromium
    gcc
    gdb
    gnumake
    zathura
    lutris
    steam
    steam-run
    tuxguitar
    pulseaudio
    # Special
    lm_sensors
    cachix
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
    # DEVELOPMENT
    nixfmt
    default-python
    bat
    rnix-lsp
    niv
    # SYSADMIN
    #(callPackage ./termius.nix { })
    # remmina
    # DEFAULT
    pavucontrol
    wineWowPackages.unstable
    playonlinux
    # overlay
    rofi-power
    rofi-bluetooth
    xst
    input-leap
    # Fonts
    emacs-all-the-icons-fonts
  ];

}

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
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # UI
#    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    cascadia-code
    font-awesome
    arandr
    tdesktop
    brightnessctl
    xsct
    xorg.xhost
    transmission_4-gtk
    brave
    gcc
    gdb
    gnumake
    pulseaudio
    tor-browser
    # Special
    lm_sensors
    cachix
    # TERMINAL
    ripgrep
    btop
    neofetch
    zip
    unrar
    unzip
    tree
    gnupg
    aria2
    imagemagick
    # DEVELOPMENT
    nixfmt-rfc-style
    default-python
    bat
    fd
    yazi
    devpod
    # DEFAULT
    pavucontrol
    # Fonts
    emacs-all-the-icons-fonts
    clinfo
    kubectl
    k3d
    nixd
    nil
    wl-clipboard
    imv
  ];

}

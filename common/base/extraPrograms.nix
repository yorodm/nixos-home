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
    ungoogled-chromium
    gcc
    gdb
    gnumake
    zathura
    pulseaudio
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
    julia-lts
    # SYSADMIN
    #(callPackage ./termius.nix { })
    # remmina
    # DEFAULT
    pavucontrol
    # overlay
    # rofi-power
    # rofi-bluetooth
    xst
    # input-leap
    # Fonts
    emacs-all-the-icons-fonts
    webcord
    clinfo
    kubectl
    k3d
    nixd
    nil
    swaybg
    slurp
    grim
  ];

}

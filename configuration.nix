# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./dnscrypt-proxy2.nix
    ./services.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tammy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    extraHosts =''
    93.95.230.108 thorinx
    192.168.1.148 tiny
    '';
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  # Set your time zone.
  time.timeZone = "Europe/Sofia";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0f0.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = false;
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Use Binary Caches
  nix = {
    settings.substituters = [ "https://nix-community.cachix.org" ];
    settings.trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    settings.trusted-users = [ "root" "jadex" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
     experimental-features = nix-command flakes
    '';
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver.enable = true;
  # services.xserver.displayManager.lightdm.greeter.enable = true;
  services.xserver.windowManager.session = lib.singleton {
    name = "xsession";
    start = pkgs.writeScript "xsession" ''
      #!${pkgs.runtimeShell}
        if test -f $HOME/.xsession; then
          exec ${pkgs.runtimeShell} -c $HOME/.xsession
        else
          echo "No xsession script found"
          exit 1
        fi
    '';
  };
  # Configure keymap in X11
  nixpkgs.config.allowUnfree = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "grp:shift_caps_toggle";
  # services.xserver.videoDrivers = ["amdgpu" ];
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Libinput
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      disableWhileTyping = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jadex = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "video" "kvm" "audio" "root"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #   wget
    #   firefox
    xorg.xf86videoamdgpu
    radeontop
    smartmontools
    wireguard-tools
    git
    #  firmwareLinuxNonfree
    #     unstable.linux-firmware
  ];

  environment.pathsToLink = [ "/share/zsh" ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    fira-code
    liberation_ttf
    fira-code-symbols
    #fanstasque-sans-mono
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" ]; })
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.bash.enableCompletion = true;
  # programs.steam.enable = true;
  # Power
  powerManagement = {
    enable = true;
    # cpuFreqGovernor = "powersave";
    powertop.enable = false;
  };
  virtualisation.podman.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

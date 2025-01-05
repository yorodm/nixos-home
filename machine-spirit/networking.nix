{ config, lib, pkgs, modulesPath, ... }:

{

  networking.hostName = "machine-spirit"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking = {
    enableB43Firmware = true;
    nameservers = [ "127.0.0.1" "::1" ];
    # firewall.checkReversePath = false;
    networkmanager = {
      insertNameservers = [ "127.0.0.1" "::1" ];
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
    };

  };
  bonds = {
    bond0 = {
      interfaces = ["eth0" "enp11s0" "enp12s0"];
      driverOptions = {
        miimon = "100";
        mode = "active-backup";
      };
    };
  };
  bridges = {
    interfaces = [
      "br0"
    ];
  };
}

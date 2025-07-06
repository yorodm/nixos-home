# Wayland-compatible night light
{ pkgs, ... }:

{
  services.wlsunset = {
    enable = true;
    latitude = "40.0";  # Adjust to your location
    longitude = "-4.0"; # Adjust to your location
    temperature = {
      day = 6500;
      night = 3500;
    };
  };
}


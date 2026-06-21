{ lib, pkgs, ... }:

{
  nixarr = {
     enable = true;
     mediaDir = "/data/media";
     stateDir = "/data/media/.state/nixarr";

     jellyfin = {
       enable = true;
       openFirewall = true;
     };

     transmission = {
       enable = true;
     };

     # Enable all Arrs
     sonarr.enable = true;
     bazarr.enable = true;
     jellyseerr.enable = true;

     # --- Declarative Sonarr Download Clients ---
     sonarr.settings-sync = {
       # Automatically configure Transmission as a download client.
       # Uses the correct port and localhost (works even across VPN boundaries
       # because Nixarr sets up nginx proxies automatically).
       transmission.enable = true;
     };


     # --- Declarative Bazarr Connections ---
     bazarr.settings-sync = {
       # Automatically configure the Sonarr connection in Bazarr.
       # API keys and ports are filled in from Nixarr's configuration.
       sonarr.enable = true;
       sonarr.config = {
         # Optionally only sync subtitles for monitored content
         sync_only_monitored_series = true;
         sync_only_monitored_episodes = true;
       };
     };
   };
}

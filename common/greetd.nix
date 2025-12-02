{ config, lib, pkgs, ... }:

{
  # XDG
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  # Simple greetd configuration for Wayland/Hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Use tuigreet for a simple TUI greeter that can start Hyprland
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Add required packages
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  # Ensure proper permissions for the greeter
  security.pam.services.greetd.enableGnomeKeyring = true;
}

{config, pkgs, ...}:
{
  services.random-background  = {
    enable = true;
    imageDirectory = "%h/wallpapers";
    interval = "1h";
  };
}

{config, ...}: {

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = ["~/wallpapers/wallpaper.png"];
      wallpaper = [ "eDP-1,~/wallpapers/wallpaper.png"];
    };
  };

}

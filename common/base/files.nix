{config, libs, ...}:
{

  xdg.configFile."starship.toml".source = ./files/starship.toml;
  xdg.configFile."zathura/zathurarc".source = ./files/zathurarc;
}

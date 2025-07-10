{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
		starship
	];
	xdg.configFile."starship.toml".source = ./files/starship.toml;

  programs.starship = {
    enable = true;
		enableFishIntegration = true;

  };

}

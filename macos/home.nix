{ config, pkgs, lib, home-manager, ... }:

{

  home = {

    packages = [
      pkgs.nixd
      pkgs.ripgrep
      pkgs.bat
      pkgs.htop
       pkgs.lsd
      pkgs.neofetch
      pkgs.dockutil
    ];

    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ ];
        theme = "agnoster";
      };
    };

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    starship = {
      enable = true;

      settings = {
        command_timeout = 100;
        format = "[$all](dimmed white)";

        character = {
          success_symbol = "[❯](dimmed green)";
          error_symbol = "[❯](dimmed red)";
        };

        git_status = {
          style = "bold yellow";
          format = "([$all_status$ahead_behind]($style) )";
        };

        jobs.disabled = true;
      };
    };

    git = {
      enable = true;

      lfs.enable = true;
    };
  };
}

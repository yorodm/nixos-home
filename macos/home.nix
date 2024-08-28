{ config, pkgs, lib, ... }:

{
  home = {
    programs = {
      # Use fish
      fish = {
        enable = true;

        interactiveShellInit = ''
        set fish_greeting # N/A
      '';

        plugins = [
          {
            # TODO: Remove this
            name = "fish-asdf";
            src = pkgs.fetchFromGitHub {
              owner = "rstacruz";
              repo = "fish-asdf";
              rev = "5869c1b1ecfba63f461abd8f98cb21faf337d004";
              sha256 = "39L6UDslgIEymFsQY8klV/aluU971twRUymzRL17+6c=";
            };
          }
          {
            name = "nix-env";
            src = pkgs.fetchFromGitHub {
              owner = "lilyball";
              repo = "nix-env.fish";
              rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
              hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
            };
          }
        ];
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

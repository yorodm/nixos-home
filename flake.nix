{
  description = "All your flake's are belongs to us";

  # nixConfig = {
  #   # override the default substituters
  #   substituters = [
  #     "https://cache.nixos.org"
  #     "https://nix-community.cachix.org"
  #   ];
  #   trusted-public-keys = [
  #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #   ];
  # };
  # This is the standard format for flake.nix.
  # `inputs` are the dependencies of the flake,
  # and `outputs` function will return all the build results of the flake.
  # Each item in `inputs` will be passed as a parameter to
  # the `outputs` function after being pulled and built.
  inputs = {
    # There are many ways to reference flake inputs.
    # The most widely used is `github:owner/name/reference`,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
	    url = "github:NixOS/nixos-hardware/master";
    };
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs-darwin";
    nix-homebrew.inputs.nix-darwin.follows = "nix-darwin";

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-services = {
      url = "github:homebrew/homebrew-services";
      flake = false;
    };

    emacs-plus = {
      url = "github:d12frosted/homebrew-emacs-plus";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # `outputs` are all the build result of the flake.
  #
  # A flake can have many use cases and different types of outputs.
  #
  # parameters in function `outputs` are defined in `inputs` and
  # can be referenced by their names. However, `self` is an exception,
  # this special parameter points to the `outputs` itself(self-reference)
  #
  # The `@` syntax here is used to alias the attribute set of the
  # inputs's parameter, making it convenient to use inside the function.
  outputs = { self, nixpkgs, disko, nixpkgs-darwin, nix-darwin, nix-homebrew, nixos-hardware, home-manager, homebrew-bundle, homebrew-core, homebrew-cask, homebrew-services, emacs-plus, lix-module,... } @inputs: {

    darwinConfigurations = {
      "machine-spirit" = nix-darwin.lib.darwinSystem {
        modules = [
          ./macos/darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jadex = import ./macos/home.nix;
            };
            users.users.jadex.home = "/Users/jadex";
          }
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;
              autoMigrate = true;
              # User owning the Homebrew prefix
              user = "jadex";

              # Automatically migrate existing Homebrew installations
              mutableTaps = false;
              taps = {
                "d12frosted/emacs-plus" = emacs-plus;
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
                "homebrew/homebrew-services" = homebrew-services;
              };
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };

    darwinPackages = self.darwinConfigurations."machine-spirit".pkgs;

    nixosConfigurations = {
      # By default, NixOS will try to refer the nixosConfiguration with
      # its hostname, so the system named `nixos-test` will use this one.
      # However, the configuration name can also be specified using:
      #   sudo nixos-rebuild switch --flake /path/to/flakes/directory#<name>
      #
      # The `nixpkgs.lib.nixosSystem` function is used to build this
      # configuration, the following attribute set is its parameter.
      #
      # Run the following command in the flake's directory to
      # deploy this configuration on any NixOS system:
      #   sudo nixos-rebuild switch --flake .#nixos-test
      "three-of-5" = nixpkgs.lib.nixosSystem{
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          lix-module.nixosModules.default
          disko.nixosModules.disko
          ./three-of-five/disk-config.nix
          ./three-of-five/configuration.nix
          {
            nix = {
              settings.experimental-features = [ "nix-command" "flakes" ];
            };
          }
          ./common/services.nix
	        home-manager.nixosModules.home-manager  {
            # home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jadex = import ./common/home.nix;
          }
        ];
      };
      "machine-spirit" = nixpkgs.lib.nixosSystem{
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          lix-module.nixosModules.default
          disko.nixosModules.disko
          ./machine-spirit/disk-config.nix
          ./machine-spirit/configuration.nix
          {
            nix = {
              settings.experimental-features = [ "nix-command" "flakes" ];
            };
          }
          ./common/services.nix
	        home-manager.nixosModules.home-manager  {
            # home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jadex = import ./common/home.nix;
          }
        ];
      };
    };
  };
}

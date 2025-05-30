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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
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
  outputs = { self, nixpkgs, disko, home-manager, lix-module,... } @inputs: {

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

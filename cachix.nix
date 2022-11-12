{ config, pkgs, libs, ... }:

{
  imports = [
    (let
      declCachix = builtins.fetchTarball
        "https://github.com/jonascarpay/declarative-cachix/archive/a2aead56e21e81e3eda1dc58ac2d5e1dc4bf05d7.tar.gz";
    in import "${declCachix}/home-manager.nix")
  ];

  caches.cachix = [
    {
      name ="yorodm-cachix";
      key = "yorodm-cachix.cachix.org-1:prB4NIzTvOZSpbxVfmlL/leyxp6x7zwX07j+VsRAzK8=";
    }
    "nix-community"
  ];

}

let
  yorodm-overlay = import (builtins.fetchTarball {
    url = "https://github.com/yorodm/yorodm-overlay/archive/master.tar.gz";
  });
in { nixpkgs.overlays = [ yorodm-overlay]; }

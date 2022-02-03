let
  mozilla-overlays = import (builtins.fetchTarball {
    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
  });
  yorodm-overlay = import (builtins.fetchTarball {
    url = "https://github.com/yorodm/yorodm-overlay/archive/master.tar.gz";
  });
in { nixpkgs.overlays = [ mozilla-overlays yorodm-overlay]; }

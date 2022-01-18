let
  mozilla-overlays = import (builtins.fetchTarball {
    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
  });
in { nixpkgs.overlays = [ mozilla-overlays ]; }

{config, pkgs, ...}:

{
  programs = {
    git = {
      enable = true;
      userName = "Yoandy Rodriguez";
      userEmail = "yoandy.rmartinez" + "@" + "gmail.com";
    };

    zsh = {
      enable = true;
      shellAliases = {
        nix-installed = "nix-instantiate --strict --json --eval -E 'builtins.map (p: p.name) (import <nixpkgs/nixos> {}).config.environment.systemPackages' | nix run nixpkgs.jq -c jq -r '.[]' | sort -u";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "rust" "ssh-agent" "themes"];
        theme = "robbyrussell";
      };
    };
    firefox = {
      enable = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
      extraPackages = (epkgs: [ epkgs.vterm ] );
    };
  };
}

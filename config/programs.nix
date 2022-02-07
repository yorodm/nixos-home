{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Yoandy Rodriguez";
      userEmail = "yoandy.rmartinez" + "@" + "gmail.com";
    };
    rofi = {
      enable = true;
      theme = "Paper";
      terminal = "${pkgs.xst}/bin/xst -e ${pkgs.zsh}/bin/zsh";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        nix-installed =
          "nix-instantiate --strict --json --eval -E 'builtins.map (p: p.name) (import <nixpkgs/nixos> {}).config.environment.systemPackages' | nix run nixpkgs.jq -c jq -r '.[]' | sort -u";
        git-dated = ''git commit -m "Updated: `date +'%Y-%m-%d %H:%M:%S'`"'';
        nix-upgrade = "sudo nixos-rebuild switch --upgrade";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "rust" "ssh-agent" "themes" "systemd"];
        theme = "robbyrussell";
      };
    };
    firefox = { enable = true; };
    # nnn = {
    #   enable = true;
    #   package = pkgs.nnn.override ({ withNerdIcons = true; });
    # };
    password-store = {
      enable = true;
    };
    mpv = {
      enable = true;
    };
    rofi.pass = {
      enable = true;
    };
    # In main.nix theres an entry for the engine to use
    zathura = {
      enable = true;
    };
  };
}

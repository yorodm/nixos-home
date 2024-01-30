###################################################
# NixOS-specific `dnscrypt-proxy2` configuration. #
###################################################
{ lib, ... }:

{
  # Ensure that any relevant stateful files are persisted across reboots.
  #
  # NOTE: '/var/lib/private' is due to the upstream 'systemd' unit definition
  # using 'DynamicUser = true'.
  #
  # NOTE: Symlinking (with 'systemd.tmpfiles.rules') doesn't work here, but a
  # bind-mount to the persistent storage location does the trick.
  fileSystems."/var/lib/private/dnscrypt-proxy2" = {
    device = "/persist/var/lib/dnscrypt-proxy2";
    options = [ "bind" ];
  };

  # TODO: Document why this is necessary; should be something on the NixOS
  # wiki to link to.
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = lib.mkForce "dnscrypt-proxy2";
  };
  
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      require_nofilter = true;
      require_nolog = true;
      ipv6_servers = false;
      require_dnssec = true;
      doh_servers = true;
      disabled_server_names =["cloudflare"];
      dnscrypt_servers = false;
      # Blacklist
     blocked_names = {
      blocked_names_file = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/notracking/hosts-blocklists/master/dnscrypt-proxy/dnscrypt-proxy.blacklist.txt";
        sha256 = "1cl2wgr5sxrkksjmlmsm2kh3g4186x7scm9y3v5nyxx9zw4z9dza";
      };
     };
      sources = {
        # Quad9 DNS resolvers.
        quad9-resolvers = {
          urls = [ "https://www.quad9.net/quad9-resolvers.md" ];
          minisign_key =
            "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
          refresh_delay = 72;
          prefix = "quad9-";
          cache_file = "/persist/var/lib/dnscrypt-proxy2/quad9.md";
        };
        # Public DNS resolvers.
        public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            "https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            "https://download.dnscrypt.net/resolvers-list/v3/public-resolvers.md"
          ];
          minisign_key =
            "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 72;
          prefix = "";
          cache_file = "/persist/var/lib/dnscrypt-proxy2/public.md";
        };
        # Anonymized DNS relays.
        relays = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
            "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
            "https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md"
            "https://download.dnscrypt.net/resolvers-list/v3/relays.md"
          ];
          minisign_key =
            "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 72;
          prefix = "";
          cache_file = "/persist/var/lib/dnscrypt-proxy2/relays.md";
        };
      };
    };
  };

}

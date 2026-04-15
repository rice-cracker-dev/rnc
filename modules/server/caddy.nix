{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.server;
in {
  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;

      package = pkgs.caddy.withPlugins {
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.4"];
        hash = "sha256-Olz4W84Kiyldy+JtbIicVCL7dAYl4zq+2rxEOUTObxA=";
      };

      globalConfig = ''
        email ricecracker2234@proton.me
        acme_dns cloudflare {$CF_API_TOKEN}
      '';
    };

    age.secrets.cloudflare.file = ../../secrets/cloudflare.age;
    systemd.services.caddy.serviceConfig.EnvironmentFile = config.age.secrets.cloudflare.path;
  };
}

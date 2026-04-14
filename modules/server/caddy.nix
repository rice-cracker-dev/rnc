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
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.1"];
        hash = "sha256-o0zYCp3h7E0L1cgmJwNtGNgzhmZk5BAVoWQA+eL+zqc=";
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

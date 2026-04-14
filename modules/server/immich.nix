{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.server;
in {
  config = mkIf cfg.enable {
    services.immich = {
      enable = true;
    };

    services.caddy.virtualHosts."immich.ricec.dev".extraConfig = ''
      request_body {
        max_size 50000MB
      }

      reverse_proxy localhost:${toString config.services.immich.port}
    '';
  };
}

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
    };
  };
}

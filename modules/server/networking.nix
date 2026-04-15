{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.server;
in {
  config = mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };
  };
}

{
  config,
  lib,
  hostName,
  ...
}: let
  inherit (lib) mkDefault optionalAttrs;

  serverCfg = config.server;
in {
  config.networking =
    {inherit hostName;}
    // (optionalAttrs (!serverCfg.enable) {
      networkmanager = {
        enable = mkDefault true;
      };

      firewall = {
        allowedTCPPorts = [
          4983 # drizzle studio
        ];
      };
    });
}

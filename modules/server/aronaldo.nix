{
  self',
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (self'.packages) aronaldo;

  cfg = config.server;
in {
  config = mkIf cfg.enable {
    systemd.services.aronaldo = {
      enable = true;

      restartTriggers = [aronaldo];

      serviceConfig = {
        ExecStart = "${aronaldo}/bin/aronaldo";
        EnvironmentFile = config.age.secrets.aronaldo.path;
      };
    };
  };
}

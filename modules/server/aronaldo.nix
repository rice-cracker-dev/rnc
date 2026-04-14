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
    age.secrets.aronaldo.file = ../../secrets/aronaldo.age;

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

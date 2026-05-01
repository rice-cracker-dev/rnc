{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.server;
in {
  options.server = {
    enable = mkEnableOption "server";
  };

  config = mkIf cfg.enable {
    services.qemuGuest.enable = true;
  };
}

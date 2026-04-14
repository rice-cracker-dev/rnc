{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.utility.opencode;
  serverCfg = config.server;
in {
  options.utility.opencode = {
    enable = mkEnableOption "opencode" // {default = !serverCfg.enable;};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.opencode];
  };
}

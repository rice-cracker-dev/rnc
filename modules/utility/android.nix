{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.utility.android;
  serverCfg = config.server;
in {
  options.utility.android = {
    enable = mkEnableOption "android" // {default = !serverCfg.enable;};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.android-tools];

    core.user.extraGroups = [
      "adbusers"
    ];
  };
}

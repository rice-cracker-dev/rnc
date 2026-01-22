{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.desktop;
in {
  options = {
    desktop.enable = mkEnableOption "desktop options" // {default = true;};
  };

  config = mkIf cfg.enable {
    # force wayland on chromium and electron apps
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

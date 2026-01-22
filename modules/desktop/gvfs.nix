{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    services.gvfs.enable = true;
  };
}

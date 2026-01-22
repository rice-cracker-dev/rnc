{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.programs.kdeconnect = mkIf desktop.enable {
    enable = true;
  };
}

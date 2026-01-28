{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.programs.noisetorch = mkIf desktop.enable {
    enable = true;
  };
}

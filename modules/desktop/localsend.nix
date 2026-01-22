{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.programs.localsend = mkIf desktop.enable {
    enable = true;
    openFirewall = true;
  };
}

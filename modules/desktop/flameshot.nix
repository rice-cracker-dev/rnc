{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config.home = mkIf desktop.enable {
    packages = with pkgs; [grim slurp];

    rum.programs.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showDesktopNotification = false;
          showStartupLaunchMessage = false;
          saveAfterCopy = true;
          useGrimAdapter = true;
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    environment.systemPackages = with pkgs; [qmk via];
    hardware.keyboard.qmk.enable = true;
    services.udev.packages = with pkgs; [via];
  };
}

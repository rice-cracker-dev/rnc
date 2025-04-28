{
  inputs,
  pkgs,
  riceLib,
  lib,
  config,
  ...
}: let
  inherit (riceLib.uwsm) useUWSM;
  shellPkg = inputs.mht-shell.packages.${pkgs.system}.default;
in {
  config.me = lib.mkIf (config.configs == "mht") {
    packages = [shellPkg];
    rum.programs.hyprland.settings.exec-once = [
      (useUWSM "${shellPkg}/bin/mht-shell")
    ];
  };
}

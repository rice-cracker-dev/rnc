{
  inputs,
  pkgs,
  riceLib,
  ...
}: let
  inherit (riceLib.uwsm) useUWSM;
  shellPkg = inputs.mht-shell.packages.${pkgs.system}.default;
in {
  config.home = {
    packages = [shellPkg];
    rum.programs.hyprland.settings.exec-once = [
      (useUWSM "${shellPkg}/bin/mht-shell")
    ];
  };
}

{inputs, pkgs, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm";
  shellPkg = inputs.mht-shell.packages.${pkgs.system}.default;
in {
  wayland.windowManager.hyprland.settings.exec-once = [
    (uwsm.useUWSM "${shellPkg}/bin/mht-shell")
  ];
}

{
  inputs,
  pkgs,
  lib,
  riceLib,
  config,
  ...
}: let
  shellPkg = inputs.rix-shell.packages.${pkgs.system}.default;
  shellBin = "${shellPkg}/bin/quickshell";
in {
  config.me = lib.mkIf (config.configs == "mht") {
    packages = [shellPkg];

    rum.desktops.hyprland.settings = {
      exec-once = [(riceLib.generators.toUWSM shellBin)];
      bind = [
        "super, d, global, rix-shortcuts:toggle_launcher"
        "super, v, global, rix-shortcuts:toggle_clipboard"
      ];
    };
  };
}

{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) path nullOr;

  uwsm = import "${inputs.self}/lib/uwsm.nix";
  cfg = config.swww;
in {
  options.swww = {
    wallpaperPath = mkOption {
      type = nullOr path;
      default = null;
      description = "path to wallpaper";
    };
  };

  config = {
    home.packages = [pkgs.swww];

    wayland.windowManager.hyprland.settings.exec-once = mkIf cfg.wallpaperPath [
      (uwsm.useUWSM "swww-daemon --no-cache & sleep 1 && swww img ${cfg.wallpaperPath}")
    ];
  };
}

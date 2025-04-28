{
  pkgs,
  config,
  lib,
  riceLib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) path nullOr;
  inherit (riceLib.uwsm) useUWSM;

  cfg = config.swww;
in {
  options.swww = {
    enable = mkEnableOption "swww";

    wallpaperPath = mkOption {
      type = nullOr path;
      default = null;
      description = "path to wallpaper";
    };
  };

  config.home = mkIf cfg.enable {
    packages = [pkgs.swww];

    rum.programs.hyprland.settings.exec-once = mkIf cfg.wallpaperPath [
      (useUWSM "swww-daemon --no-cache & sleep 1 && swww img ${cfg.wallpaperPath}")
    ];
  };
}

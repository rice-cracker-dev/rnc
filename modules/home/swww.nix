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

  cfg = config.home.swww;
in {
  options.home.swww = {
    enable = mkEnableOption "swww";

    wallpaperPath = mkOption {
      type = nullOr path;
      default = null;
      description = "path to wallpaper";
    };
  };

  config.me = mkIf cfg.enable {
    packages = [pkgs.swww];

    rum.programs.hyprland.settings.exec-once = mkIf (cfg.wallpaperPath != null) [
      (useUWSM "swww-daemon --no-cache & sleep 1 && swww img ${cfg.wallpaperPath}")
    ];
  };
}

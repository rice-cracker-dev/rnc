{
  pkgs,
  config,
  lib,
  riceLib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) path nullOr;
  inherit (riceLib.generators) toUWSM;

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
      (toUWSM "swww-daemon --no-cache & sleep 1 && swww img ${cfg.wallpaperPath}")
    ];
  };
}

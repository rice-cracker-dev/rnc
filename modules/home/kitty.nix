{
  lib,
  config,
  pkgs,
  riceLib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) oneOf listOf attrsOf nullOr path;
  inherit (riceLib.types) confType;
  inherit (riceLib.generators) toKittyConf;

  cfg = config.home.kitty;

  themeFile =
    if cfg.themeFile != null
    then "include ${cfg.themeFile}"
    else "";
in {
  options.home.kitty = {
    enable = mkEnableOption "home kitty configuration";

    themeFile = mkOption {
      type = nullOr path;
      default = null;
    };

    settings = mkOption {
      type = attrsOf (oneOf [(listOf confType) confType]);
      default = {};
    };
  };

  config = mkIf cfg.enable {
    me = {
      packages = [pkgs.kitty];

      rum.programs.hyprland.settings.bind = [
        "super, return, exec, kitty"
      ];

      files.".config/kitty/kitty.conf".text = mkIf (cfg.settings != {} || cfg.themeFile != null) ''
        ${themeFile}
        ${toKittyConf cfg.settings}
      '';
    };

    home.uwsm.env = {
      TERMINAL = "kitty";
    };
  };
}

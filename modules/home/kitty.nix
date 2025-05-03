{
  lib,
  config,
  pkgs,
  riceLib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) oneOf listOf attrsOf;
  inherit (riceLib.types) confType;
  inherit (riceLib.generators) toKittyConf;

  cfg = config.home.kitty;
in {
  options.home.kitty = {
    enable = mkEnableOption "home kitty configuration";

    settings = mkOption {
      type = attrsOf (oneOf [(listOf confType) confType]);
      default = {};
    };
  };

  config.me = mkIf cfg.enable {
    packages = [pkgs.kitty];

    rum.programs.hyprland.settings.bind = [
      "super, return, exec, kitty"
    ];

    files.".config/kitty/kitty.conf".text = toKittyConf cfg.settings;
  };
}

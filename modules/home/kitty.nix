{
  lib,
  config,
  pkgs,
  riceLib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) attrsOf anything path listOf;
  inherit (riceLib.kitty) toKittyConf toKittyIncludes;

  cfg = config.home.kitty;
in {
  options.home.kitty = {
    enable = mkEnableOption "home kitty configuration";

    includes = mkOption {
      type = listOf path;
      default = [];
    };

    settings = mkOption {
      type = attrsOf anything;
      default = {};
    };
  };

  config.me = mkIf cfg.enable {
    packages = [pkgs.kitty];

    rum.programs.hyprland.settings.bind = [
      "super, return, exec, kitty"
    ];

    files.".config/kitty/kitty.conf".text = ''
      ${toKittyIncludes cfg.includes}
      ${toKittyConf cfg.settings}
    '';
  };
}

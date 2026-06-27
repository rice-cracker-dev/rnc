{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) map mkIf mkEnableOption mkOption readFile typeOf concatStringsSep;
  inherit (lib.types) oneOf str path functionTo;
  inherit (lib.generators) toLua;
  inherit (lib.rnc.types.dag) dagOf;
  inherit (lib.rnc.dag) topoSort;

  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = mkEnableOption "hyprland";

    generator = mkOption {
      type = functionTo str;
      readOnly = true;
      default = toLua {};
    };

    luaConfig = mkOption {
      type = dagOf (oneOf [path str]);
      default = {};
    };

    luaConfigFinal = mkOption {
      type = str;
      readOnly = true;
      default = let
        sortedList = (topoSort cfg.luaConfig).result;
        finalList =
          map (lua: "-- step: ${lua.name}\n${
            if typeOf lua.data == "string"
            then lua.data
            else readFile lua.data
          }")
          sortedList;
      in
        concatStringsSep "\n" finalList;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.hyprpicker];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    home.xdg.config.files."hypr/hyprland.lua".text = cfg.luaConfigFinal;
  };
}

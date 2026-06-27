{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption map concatStringsSep;
  inherit (lib.types) listOf attrsOf anything;
  inherit (lib.rnc.dag) entryAfter;

  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland.monitor = mkOption {
    type = listOf (attrsOf anything);
    description = "A list of per-monitor config, each element is converted to lua object and passed into hl.monitor({...})";
    default = [];
  };

  config.desktop.hyprland.luaConfig.monitor = entryAfter ["device"] (concatStringsSep "\n" (map (o: "hl.monitor(${cfg.generator o})") cfg.monitor));
}

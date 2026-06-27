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
  options.desktop.hyprland.device = mkOption {
    type = listOf (attrsOf anything);
    description = "A list of per-device config, each element is converted to lua object and passed into hl.device({...})";
    default = [];
  };

  config.desktop.hyprland.luaConfig.device = entryAfter ["gesture"] (concatStringsSep "\n" (map (o: "hl.device(${cfg.generator o})") cfg.device));
}

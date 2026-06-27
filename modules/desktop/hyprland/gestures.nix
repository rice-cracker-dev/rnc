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
  options.desktop.hyprland.gesture = mkOption {
    type = listOf (attrsOf anything);
    description = "A list of gesture config, each element is converted to lua object and passed into hl.gesture({...})";
    default = [];
  };

  config.desktop.hyprland.luaConfig.gesture = entryAfter ["bind"] (concatStringsSep "\n" (map (o: "hl.gesture(${cfg.generator o})") cfg.gesture));
}

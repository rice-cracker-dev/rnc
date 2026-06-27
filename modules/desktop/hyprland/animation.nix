{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption map concatStringsSep mapAttrsToList;
  inherit (lib.types) listOf attrsOf anything;
  inherit (lib.rnc.dag) entryAfter;

  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    curve = mkOption {
      type = attrsOf (attrsOf anything);
      description = "A attrset of curve config, each key is the name and value is converted to lua object and passed into hl.curve({key}, {value})";
      default = {
        easeOutQuint = {
          type = "bezier";
          points = [[0.22 1] [0.36 1]];
        };
      };
    };
    animation = mkOption {
      type = listOf (attrsOf anything);
      description = "A list of animation config, each element is converted to lua object and passed into hl.animation({...})";
      default = [
        {
          leaf = "global";
          enabled = true;
          speed = 3;
          bezier = "easeOutQuint";
        }
      ];
    };
  };
  config.desktop.hyprland.luaConfig = {
    curve = entryAfter ["workspace-rule"] (concatStringsSep "\n" (mapAttrsToList (key: o: "hl.curve(${cfg.generator key}, ${cfg.generator o})") cfg.curve));
    animation = entryAfter ["curve"] (concatStringsSep "\n" (map (o: "hl.animation(${cfg.generator o})") cfg.animation));
  };
}

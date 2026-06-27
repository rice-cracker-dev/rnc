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
  options.desktop.hyprland = {
    window-rule = mkOption {
      type = listOf (attrsOf anything);
      description = "A list of window rule config, each element is converted to lua object and passed into hl.window_rule({...})";
      default = [
        {
          match.title = "flameshot";
          no_anim = true;
          move = [0 0];
          pin = true;
          fullscreen_state = 2;
          float = true;
        }
      ];
    };

    layer-rule = mkOption {
      type = listOf (attrsOf anything);
      description = "A list of layer rule config, each element is converted to lua object and passed into hl.layer_rule({...})";
      default = [
        {
          match.namespace = "quickshell";
          blur = true;
          blur_popups = true;
          ignore_alpha = 0.5;
        }
        {
          match.namespace = "launcher";
          blur = true;
        }
      ];
    };

    workspace-rule = mkOption {
      type = listOf (attrsOf anything);
      description = "A list of workspace rule config, each element is converted to lua object and passed into hl.workspace_rule({...})";
      default = [];
    };
  };
  config.desktop.hyprland.luaConfig = {
    window-rule = entryAfter ["monitor"] (concatStringsSep "\n" (map (o: "hl.window_rule(${cfg.generator o})") cfg.window-rule));
    layer-rule = entryAfter ["window-rule"] (concatStringsSep "\n" (map (o: "hl.layer_rule(${cfg.generator o})") cfg.layer-rule));
    workspace-rule = entryAfter ["layer-rule"] (concatStringsSep "\n" (map (o: "hl.workspace_rule(${cfg.generator o})") cfg.workspace-rule));
  };
}

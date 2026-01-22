{
  lib,
  self,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption mapAttrs' nameValuePair;
  inherit (lib.types) oneOf attrsOf listOf;
  inherit (self.lib.types) uwsmValue;
  inherit (self.lib.generators) toUWSM;
  inherit (config) desktop;

  envType = attrsOf (oneOf [uwsmValue (listOf uwsmValue)]);

  mkGenerator = attrs: {
    enable = attrs != {};
    generator = toUWSM;
    value = attrs;
  };

  cfg = config.desktop.uwsm;
in {
  options.desktop.uwsm = {
    defaultEnv = mkOption {
      type = envType;
      default = {};
    };

    desktopEnv = mkOption {
      type = attrsOf envType;
      default = {};
    };
  };

  config = mkIf desktop.enable {
    programs.uwsm.enable = true;

    home.xdg.config.files =
      (mapAttrs' (desktop: attrs: nameValuePair "uwsm/env-${desktop}" (mkGenerator attrs)) cfg.desktopEnv)
      // {
        "uwsm/env" = mkGenerator cfg.defaultEnv;
      };
  };
}

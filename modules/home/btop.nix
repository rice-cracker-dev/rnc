{
  lib,
  riceLib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf isPath;
  inherit (lib.types) str attrsOf oneOf path;
  inherit (lib.strings) isString;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (riceLib.types) confType;
  inherit (riceLib.generators) toBtopConf;

  cfg = config.home.btop;
in {
  options.home.btop = {
    enable = mkEnableOption "btop";

    settings = mkOption {
      type = attrsOf confType;
      default = {};
    };

    themes = mkOption {
      type = attrsOf (oneOf [str path (attrsOf confType)]);
    };
  };

  config = mkIf cfg.enable {
    home.files =
      {
        ".config/btop/btop.conf".text = mkIf (cfg.settings != {}) (toBtopConf cfg.settings);
      }
      // mapAttrs' (name: value: let
        themePath = ".config/btop/themes";
        result =
          if (isString value)
          then {source = /. + value;}
          else if (isPath value)
          then {source = value;}
          else {text = toBtopConf value;};
      in
        nameValuePair "${themePath}/${name}.theme" result);
  };
}

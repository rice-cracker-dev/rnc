{
  pkgs,
  lib,
  self,
  config,
  pins,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf isPath;
  inherit (lib.types) str attrsOf oneOf path;
  inherit (lib.strings) isString;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (self.lib.types) btopThemeValue;
  inherit (self.lib.generators) toBtopConf;

  cfg = config.utility.btop;
in {
  options.utility.btop = {
    enable = mkEnableOption "btop" // {default = true;};

    settings = mkOption {
      type = attrsOf btopThemeValue;
      default = {
        color_theme = "catppuccin-macchiato";
        theme_background = false;
      };
    };

    themes = mkOption {
      type = attrsOf (oneOf [str path (attrsOf btopThemeValue)]);
      default = {
        catppuccin-macchiato = "${pins.catppuccin-btop}/themes/catppuccin_macchiato.theme";
      };
    };
  };

  config.home = mkIf cfg.enable {
    packages = [pkgs.btop];

    xdg.config.files =
      {
        "btop/btop.conf" = {
          enable = cfg.settings != {};
          generator = toBtopConf;
          value = cfg.settings;
        };
      }
      // mapAttrs' (name: value: let
        themePath = "btop/themes";
        result =
          if (isString value) || (isPath value)
          then {source = value;}
          else {
            inherit value;
            enable = value != {};
            generator = toBtopConf;
          };
      in
        nameValuePair "${themePath}/${name}.theme" result)
      cfg.themes;
  };
}

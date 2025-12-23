{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) str package submodule nullOr;
  inherit (inputs.hjem-rum.lib.types) gtkType;

  cfg = config.home.theme;

  themeType = submodule {
    options = {
      name = mkOption {
        type = str;
        description = "gtk theme name";
      };

      package = mkOption {
        type = package;
        description = "gtk theme package";
      };
    };
  };
in {
  options.home.theme.gtk = {
    enable = mkEnableOption "enable home gtk theme configuration";

    theme = mkOption {
      type = nullOr themeType;
      default = null;
    };

    extraSettings = mkOption {
      type = gtkType;
      default = {};
      description = "extra gtk settings";
    };
  };

  config.me.rum.misc.gtk = mkIf (config.enableDesktopModules && cfg.enable && cfg.gtk.enable) {
    enable = true;

    packages = mkIf (cfg.gtk.theme != null) [cfg.gtk.theme.package];

    settings =
      {
        theme-name = mkIf (cfg.gtk.theme != null) cfg.gtk.theme.name;
      }
      // cfg.gtk.extraSettings;
  };
}

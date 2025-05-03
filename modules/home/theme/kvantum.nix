{
  config,
  lib,
  riceLib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) attrsOf nullOr submodule str package;
  inherit (lib.attrsets) recursiveUpdate optionalAttrs;
  inherit (riceLib.generators) toKvantumConf;
  inherit (riceLib.types) confType;

  cfg = config.home.theme;

  themeType = submodule {
    options = {
      name = mkOption {
        type = str;
        description = "kvantum theme name";
      };
      package = mkOption {
        type = package;
        description = "kvantum theme package";
      };
    };
  };

  themePath = theme: "${theme.package}/share/Kvantum/${theme.name}";

  conf =
    recursiveUpdate (
      optionalAttrs (cfg.kvantum.theme != null) {
        General = {
          theme = cfg.kvantum.theme.name;
        };
      }
    )
    cfg.kvantum.extraSettings;
in {
  options.home.theme.kvantum = {
    enable = mkEnableOption "enable home kvantum theme configuration";

    theme = mkOption {
      type = nullOr themeType;
      default = null;
    };

    extraSettings = mkOption {
      type = attrsOf (attrsOf confType);
      default = {};
      description = "extra kvantum configuration";
    };
  };

  config = mkIf (cfg.enable && cfg.kvantum.enable) {
    me = {
      packages = with pkgs; [
        kdePackages.qqc2-desktop-style
        qt6.qtwayland
        qt6.qtsvg
        libsForQt5.qtstyleplugin-kvantum
        qt6Packages.qtstyleplugin-kvantum
      ];

      files = {
        ".config/Kvantum/kvantum.kvconfig".text = "${toKvantumConf conf}";
        ".config/Kvantum/${cfg.kvantum.theme.name}".source = mkIf (cfg.kvantum.theme != null) (themePath cfg.kvantum.theme);
      };
    };

    home.uwsm.env.QT_STYLE_OVERRIDE = "kvantum";
  };
}

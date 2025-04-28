{
  config,
  lib,
  riceLib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) attrsOf nullOr anything submodule str package;
  inherit (lib.attrsets) recursiveUpdate;
  inherit (riceLib.kvantum) toKvantumConf;

  cfg = config.home.theme;

  themeType = submodule {
    name = mkOption {
      type = str;
      description = "kvantum theme name";
    };
    package = mkOption {
      type = package;
      description = "kvantum theme package";
    };
  };

  themePath = theme: "${theme.package}/share/Kvantum/${theme.name}";
in {
  options.home.theme.kvantum = {
    enable = mkEnableOption "enable home kvantum theme configuration";

    theme = mkOption {
      type = nullOr themeType;
      default = null;
    };

    extraSettings = mkOption {
      type = attrsOf (attrsOf anything);
      default = {};
      description = "extra kvantum configuration";
    };
  };

  config.home = mkIf (cfg.enable && cfg.kvantum.enable) {
    packages = with pkgs; [
      kdePackages.qqc2-desktop-style
      qt6.qtwayland
      qt6.qtsvg
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
    ];

    theme.kvantum.settings =
      recursiveUpdate {
        General = {
          theme = mkIf cfg.kvantum.theme != null cfg.kvantum.theme.name;
        };
      }
      cfg.kvantum.extraSettings;

    files = {
      ".config/Kvantum/kvantum.kvconfig".text = toKvantumConf cfg.kvantum.settings;
      ".config/Kvantum/${cfg.kvantum.theme.name}".source = mkIf cfg.kvantum.theme != null (themePath cfg.kvantum.theme);
    };

    uwsm.env.QT_STYLE_OVERRIDE = "kvantum";
  };
}

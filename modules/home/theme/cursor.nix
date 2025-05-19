{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) str package int submodule nullOr;

  cfg = config.home.theme;

  cursorType = submodule {
    options = {
      name = mkOption {
        type = str;
        description = "The name of the cursor for apps to use";
      };

      package = mkOption {
        type = package;
        description = "The package that contains the cursor";
      };

      size = mkOption {
        type = int;
        description = "The size of the cursor";
      };
    };
  };
in {
  options.home.theme.cursor = mkOption {
    type = nullOr cursorType;
    default = null;
  };

  config = mkIf (cfg.enable && cfg.cursor != null) {
    me.rum.misc.gtk = {
      packages = [cfg.cursor.package];

      settings = {
        cursor-theme-name = cfg.cursor.name;
        cursor-theme-size = cfg.cursor.size;
      };
    };

    home.uwsm.env = {
      XCURSOR_SIZE = builtins.toString cfg.cursor.size;
      XCURSOR_PATH = "${cfg.cursor.package}/share/icons";
      XCURSOR_THEME = cfg.cursor.name;
    };
  };
}

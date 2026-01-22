{
  config,
  lib,
  pkgs,
  pins,
  ...
}: let
  inherit (lib) mkIf mkOption mkEnableOption optional optionalAttrs;
  inherit (lib.types) submodule str int nullOr package;
  inherit (lib.generators) toINI;
  inherit (config) desktop;

  hyprcursorOptions = submodule {
    options = {
      name = mkOption {type = str;};
      package = mkOption {type = package;};
    };
  };

  cfg = config.desktop.theme.cursor;

  bibata-hyprcursor = pkgs.callPackage "${pins.niqspkgs}/pkgs/bibata-hyprcursor/package.nix" {variant = "modern";};
in {
  options.desktop.theme.cursor = {
    enable = mkEnableOption "cursor options" // {default = desktop.enable;};

    name = mkOption {
      type = str;
      default = "Bibata-Modern-Classic";
    };

    package = mkOption {
      type = package;
      default = pkgs.bibata-cursors;
    };

    size = mkOption {
      type = int;
      default = 24;
    };

    hyprcursor = mkOption {
      type = nullOr hyprcursorOptions;
      default = {
        name = "Bibata-modern";
        package = bibata-hyprcursor;
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages =
        [cfg.package]
        ++ (optional (cfg.hyprcursor != null) cfg.hyprcursor.package);

      xdg.data.files."icons/default/index.theme" = {
        generator = toINI {};
        value = {
          "Icon Theme".Inherits = cfg.name;
        };
      };
    };

    desktop.uwsm.defaultEnv =
      {
        XCURSOR_THEME = cfg.name;
        XCURSOR_SIZE = cfg.size;
        XCURSOR_PATH = "${cfg.package}/share/icons";
      }
      // (optionalAttrs (cfg.hyprcursor != null) {
        HYPRCURSOR_THEME = cfg.hyprcursor.name;
        HYPRCURSOR_SIZE = cfg.size;
      });
  };
}
